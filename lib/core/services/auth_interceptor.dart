import 'package:dio/dio.dart';
import 'package:menu_dart_api/core/api.dart';

class AuthInterceptor extends Interceptor {
  static const String _retryHeader = 'X-Auth-Retry';

  static Future<bool> Function()? _refreshTokenCallback;
  static Future<void> Function()? _onUnauthenticatedCallback;

  static void configure({
    required Future<bool> Function() refreshToken,
    required Future<void> Function() onUnauthenticated,
  }) {
    _refreshTokenCallback = refreshToken;
    _onUnauthenticatedCallback = onUnauthenticated;
  }

  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingRequests = [];

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    if (err.requestOptions.headers[_retryHeader] == '1') {
      return handler.next(err);
    }

    if (_isRefreshing) {
      _pendingRequests.add(_PendingRequest(
        requestOptions: err.requestOptions,
        handler: handler,
      ));
      return;
    }

    _isRefreshing = true;
    try {
      final refreshSuccess = await _refreshTokenCallback?.call() ?? false;

      if (refreshSuccess) {
        final dio = API.dioClient.dio;
        final newToken = API.loginAccessToken;

        _retryRequest(dio, err.requestOptions, handler, newToken);

        for (final pending in _pendingRequests) {
          _retryRequest(dio, pending.requestOptions, pending.handler, newToken);
        }
      } else {
        await _onUnauthenticatedCallback?.call();
        handler.next(err);
      }
    } catch (e) {
      await _onUnauthenticatedCallback?.call();
      handler.next(err);
    } finally {
      _isRefreshing = false;
      _pendingRequests.clear();
    }
  }

  void _retryRequest(
    Dio dio,
    RequestOptions options,
    ErrorInterceptorHandler handler,
    String newToken,
  ) {
    options.headers['Authorization'] = 'Bearer $newToken';
    options.headers[_retryHeader] = '1';

    dio.fetch(options).then((response) {
      if (response.statusCode == 401) {
        _onUnauthenticatedCallback?.call();
        handler.next(DioException(
          requestOptions: options,
          response: response,
          type: DioExceptionType.badResponse,
        ));
      } else {
        handler.resolve(response);
      }
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 401) {
        _onUnauthenticatedCallback?.call();
      }
      handler.next(error is DioException
          ? error
          : DioException(
              requestOptions: options,
              response: null,
              type: DioExceptionType.unknown,
            ));
    });
  }
}

class _PendingRequest {
  final RequestOptions requestOptions;
  final ErrorInterceptorHandler handler;

  _PendingRequest({
    required this.requestOptions,
    required this.handler,
  });
}

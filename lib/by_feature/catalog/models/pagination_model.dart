class PaginationModel {
  final int total;
  final int offset;
  final int limit;
  final bool hasMore;

  const PaginationModel({
    required this.total,
    required this.offset,
    required this.limit,
    required this.hasMore,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      total: _parseInt(json['total']) ?? 0,
      offset: _parseInt(json['offset']) ?? 0,
      limit: _parseInt(json['limit']) ?? 50,
      hasMore: json['hasMore'] == true,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

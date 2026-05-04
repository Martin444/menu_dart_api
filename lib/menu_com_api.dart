library menu_com_api;

export 'package:menu_dart_api/core/api.dart';
export 'package:menu_dart_api/core/services/anonymous_id_service.dart';
export 'package:menu_dart_api/core/services/universal_anonymous_id_service.dart';
export 'package:menu_dart_api/core/services/anonymous_http_client.dart';
export 'package:menu_dart_api/core/services/anonymous_dio_client.dart';
export 'package:menu_dart_api/core/exeptions/api_exception.dart';
export 'package:menu_dart_api/by_feature/upload_images/data/usescases/upload_file_usescases.dart';
export 'package:menu_dart_api/by_feature/user/get_me_profile/data/usescase/get_dinning_usescases.dart';
export 'package:menu_dart_api/by_feature/user/get_me_profile/model/roles_users.dart';
export 'package:menu_dart_api/by_feature/user/get_me_profile/model/dinning_model.dart';
export 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/users_by_roles_params.dart';
export 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/user_by_role_model.dart';
export 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/users_by_roles_response.dart';
export 'package:menu_dart_api/by_feature/user/get_users_by_roles/data/usescase/get_users_by_roles_usecase.dart';

// Admin Users APIs
export 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/get_all_users_admin_params.dart';
export 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/get_all_users_admin_filters.dart';
export 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/get_all_users_admin_response.dart';
export 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/membership_enums.dart';
export 'package:menu_dart_api/by_feature/user/get_all_users_admin/data/usecase/get_all_users_admin_usecase.dart';

export 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_params.dart';
export 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_filters.dart';
export 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_response.dart';
export 'package:menu_dart_api/by_feature/user/count_users_admin/data/usecase/count_users_admin_usecase.dart';

export 'package:menu_dart_api/by_feature/user/update_user/update_user.dart';
export 'package:menu_dart_api/by_feature/user/update_user_admin/update_user_admin.dart';
export 'package:menu_dart_api/by_feature/user/delete_user/data/usecase/delete_user_usecase.dart';
export 'package:menu_dart_api/by_feature/orders/models/new_order_param.dart';
export 'package:menu_dart_api/by_feature/orders/models/order_item_model.dart';
export 'package:menu_dart_api/by_feature/orders/models/order_model.dart';
export 'package:menu_dart_api/by_feature/orders/usescase/order_usescase.dart';
export 'package:menu_dart_api/by_feature/orders/usescase/count_orders_admin_usecase.dart';
export 'package:menu_dart_api/by_feature/orders/usescase/get_total_revenue_usecase.dart';
export 'package:menu_dart_api/by_feature/user/update_user/update_fcm_token_usecase.dart';


// OAuth de Mercado Pago - Funcionalidad completa
export 'package:menu_dart_api/by_feature/payments/oauth/mp_oauth.dart';

export 'package:menu_dart_api/by_feature/auth/social_login/social_login.dart';

// Catalog APIs
export 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
export 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';
export 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';
export 'package:menu_dart_api/by_feature/catalog/models/create_catalog_item_params.dart';
export 'package:menu_dart_api/by_feature/catalog/models/update_catalog_item_params.dart';
export 'package:menu_dart_api/by_feature/catalog/data/usecase/get_my_catalogs_usecase.dart';
export 'package:menu_dart_api/by_feature/catalog/data/usecase/create_catalog_usecase.dart';
export 'package:menu_dart_api/by_feature/catalog/data/usecase/update_catalog_usecase.dart';
export 'package:menu_dart_api/by_feature/catalog/data/usecase/delete_catalog_usecase.dart';
export 'package:menu_dart_api/by_feature/catalog/data/usecase/get_catalog_by_id_usecase.dart';
export 'package:menu_dart_api/by_feature/catalog/data/usecase/create_catalog_item_usecase.dart';
export 'package:menu_dart_api/by_feature/catalog/data/usecase/update_catalog_item_usecase.dart';
export 'package:menu_dart_api/by_feature/catalog/data/usecase/delete_catalog_item_usecase.dart';

// Membership APIs
export 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
export 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
export 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';
export 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';
export 'package:menu_dart_api/by_feature/membership/models/discount_result_model.dart';
export 'package:menu_dart_api/by_feature/membership/models/payment_result_model.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/get_membership_status_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/get_membership_plans_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/create_membership_payment_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/subscribe_membership_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/apply_membership_discount_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/manage_membership_subscription_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/upgrade_membership_plan_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/get_all_admin_plans_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/get_admin_plan_by_id_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/create_admin_plan_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/update_admin_plan_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/archive_admin_plan_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/get_admin_plan_stats_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/seed_admin_plans_usecase.dart';
export 'package:menu_dart_api/by_feature/membership/data/usecase/assign_plan_to_user_usecase.dart';

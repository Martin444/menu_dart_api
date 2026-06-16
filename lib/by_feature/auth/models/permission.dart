enum Permission {
  createCatalog('create_catalog'),
  readCatalog('read_catalog'),
  updateCatalog('update_catalog'),
  deleteCatalog('delete_catalog'),

  createItem('create_item'),
  readItem('read_item'),
  updateItem('update_item'),
  deleteItem('delete_item'),

  createOrder('create_order'),
  readOrder('read_order'),
  updateOrder('update_order'),
  cancelOrder('cancel_order'),

  manageUsers('manage_users'),
  managePayments('manage_payments'),
  viewAnalytics('view_analytics'),
  manageRoles('manage_roles'),

  manageSubscriptions('manage_subscriptions'),
  viewSubscriptionPlans('view_subscription_plans'),

  createEvent('create_event'),
  readEvent('read_event'),
  updateEvent('update_event'),
  deleteEvent('delete_event'),
  manageTickets('manage_tickets'),
  validateTickets('validate_tickets');

  final String value;
  const Permission(this.value);

  static Permission fromString(String value) {
    return Permission.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError('Invalid Permission: $value'),
    );
  }
}

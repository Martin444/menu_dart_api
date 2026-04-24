enum MembershipPlanFilter {
  free,
  premium,
  enterprise;

  String get value {
    switch (this) {
      case MembershipPlanFilter.free:
        return 'free';
      case MembershipPlanFilter.premium:
        return 'premium';
      case MembershipPlanFilter.enterprise:
        return 'enterprise';
    }
  }

  static MembershipPlanFilter? fromString(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'free':
        return MembershipPlanFilter.free;
      case 'premium':
        return MembershipPlanFilter.premium;
      case 'enterprise':
        return MembershipPlanFilter.enterprise;
      default:
        return null;
    }
  }
}

enum SortByField {
  createdAt,
  name,
  email,
  plan;

  String get value {
    switch (this) {
      case SortByField.createdAt:
        return 'createdAt';
      case SortByField.name:
        return 'name';
      case SortByField.email:
        return 'email';
      case SortByField.plan:
        return 'plan';
    }
  }
}

enum SortOrder {
  asc,
  desc;

  String get value {
    switch (this) {
      case SortOrder.asc:
        return 'ASC';
      case SortOrder.desc:
        return 'DESC';
    }
  }

  static SortOrder fromString(String? value) {
    if (value == null) return SortOrder.desc;
    return value.toLowerCase() == 'asc' ? SortOrder.asc : SortOrder.desc;
  }
}
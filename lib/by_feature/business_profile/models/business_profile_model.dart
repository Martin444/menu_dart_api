class BusinessHour {
  final String day;
  final String open;
  final String close;
  final bool isHoliday;

  const BusinessHour({
    required this.day,
    required this.open,
    required this.close,
    this.isHoliday = false,
  });

  factory BusinessHour.fromJson(Map<String, dynamic> json) {
    return BusinessHour(
      day: json['day'] as String? ?? '',
      open: json['open'] as String? ?? '',
      close: json['close'] as String? ?? '',
      isHoliday: json['isHoliday'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'open': open,
        'close': close,
        'isHoliday': isHoliday,
      };
}

class SocialLinks {
  final String? instagram;
  final String? facebook;
  final String? whatsapp;
  final String? website;

  const SocialLinks({
    this.instagram,
    this.facebook,
    this.whatsapp,
    this.website,
  });

  factory SocialLinks.fromJson(Map<String, dynamic> json) {
    return SocialLinks(
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
      whatsapp: json['whatsapp'] as String?,
      website: json['website'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (instagram != null) 'instagram': instagram,
        if (facebook != null) 'facebook': facebook,
        if (whatsapp != null) 'whatsapp': whatsapp,
        if (website != null) 'website': website,
      };
}

class BusinessPolicies {
  final String? returns;
  final String? shipping;
  final String? warranty;
  final String? payment;

  const BusinessPolicies({
    this.returns,
    this.shipping,
    this.warranty,
    this.payment,
  });

  factory BusinessPolicies.fromJson(Map<String, dynamic> json) {
    return BusinessPolicies(
      returns: json['returns'] as String?,
      shipping: json['shipping'] as String?,
      warranty: json['warranty'] as String?,
      payment: json['payment'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (returns != null) 'returns': returns,
        if (shipping != null) 'shipping': shipping,
        if (warranty != null) 'warranty': warranty,
        if (payment != null) 'payment': payment,
      };
}

class BusinessProfileModel {
  final String id;
  final String commerceId;
  final List<BusinessHour>? hours;
  final SocialLinks? socialLinks;
  final List<String>? certifications;
  final String? bio;
  final String? coverage;
  final BusinessPolicies? policies;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BusinessProfileModel({
    required this.id,
    required this.commerceId,
    this.hours,
    this.socialLinks,
    this.certifications,
    this.bio,
    this.coverage,
    this.policies,
    this.createdAt,
    this.updatedAt,
  });

  factory BusinessProfileModel.fromJson(Map<String, dynamic> json) {
    return BusinessProfileModel(
      id: json['id'] as String? ?? '',
      commerceId: json['commerceId'] as String? ?? '',
      hours: json['hours'] != null
          ? (json['hours'] as List<dynamic>)
              .map((e) => BusinessHour.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      socialLinks: json['socialLinks'] != null
          ? SocialLinks.fromJson(json['socialLinks'] as Map<String, dynamic>)
          : null,
      certifications: json['certifications'] != null
          ? (json['certifications'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : null,
      bio: json['bio'] as String?,
      coverage: json['coverage'] as String?,
      policies: json['policies'] != null
          ? BusinessPolicies.fromJson(json['policies'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'commerceId': commerceId,
        if (hours != null) 'hours': hours!.map((e) => e.toJson()).toList(),
        if (socialLinks != null) 'socialLinks': socialLinks!.toJson(),
        if (certifications != null) 'certifications': certifications,
        if (bio != null) 'bio': bio,
        if (coverage != null) 'coverage': coverage,
        if (policies != null) 'policies': policies!.toJson(),
      };
}

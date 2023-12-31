class ProfileCompany {
   int? id;
   String? phone;
   String? terms;
   String? provision;
   String? latitude;
   String? longitude;
   int? radius;
   String? createdAt;
   String? updatedAt;

  ProfileCompany({
     this.id,
     this.phone,
     this.terms,
     this.provision,
     this.latitude,
     this.longitude,
     this.radius,
     this.createdAt,
     this.updatedAt,
  });

  factory ProfileCompany.fromJson(Map<String, dynamic> json) {
    return ProfileCompany(
      id: json['id'],
      phone: json['phone'],
      terms: json['terms'],
      provision: json['provision'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radius: int.parse(json['radius']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

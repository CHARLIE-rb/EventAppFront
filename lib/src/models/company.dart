import 'package:flutter/material.dart';

class Company {
  int id;
  String name;
  Image logo;
  String? description;
  String? websiteUrl;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;

  Company({
    required this.id,
    required this.name,
    required this.logo,
    this.description,
    this.websiteUrl,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logo': logo,
      'description': description,
      'website': websiteUrl,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }
}

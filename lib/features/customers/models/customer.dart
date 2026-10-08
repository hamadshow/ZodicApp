class Customer {
  const Customer({
    required this.id,
    required this.customerCode,
    required this.name,
    required this.type,
    required this.phone,
    required this.mobile,
    required this.email,
    this.website,
    this.country,
    this.state,
    this.city,
    this.address,
    this.postalCode,
    required this.openingBalance,
    required this.balance,
    required this.creditLimit,
    required this.paymentTerms,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String customerCode;
  final String name;
  final String type;
  final String phone;
  final String mobile;
  final String email;
  final String? website;
  final String? country;
  final String? state;
  final String? city;
  final String? address;
  final String? postalCode;
  final double openingBalance;
  final double balance;
  final double creditLimit;
  final String paymentTerms;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get initials {
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return words.first.substring(0, 1).toUpperCase();
    }
    return '${words.first.substring(0, 1)}${words.last.substring(0, 1)}'
        .toUpperCase();
  }

  Customer copyWith({
    String? id,
    String? customerCode,
    String? name,
    String? type,
    String? phone,
    String? mobile,
    String? email,
    String? website,
    String? country,
    String? state,
    String? city,
    String? address,
    String? postalCode,
    double? openingBalance,
    double? balance,
    double? creditLimit,
    String? paymentTerms,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      customerCode: customerCode ?? this.customerCode,
      name: name ?? this.name,
      type: type ?? this.type,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      website: website ?? this.website,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      openingBalance: openingBalance ?? this.openingBalance,
      balance: balance ?? this.balance,
      creditLimit: creditLimit ?? this.creditLimit,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CustomerType {
  CustomerType._();

  static const String individual = 'Individual';
  static const String business = 'Business';
}

class CustomerStatus {
  CustomerStatus._();

  static const String active = 'Active';
  static const String inactive = 'Inactive';
  static const String suspended = 'Suspended';
}

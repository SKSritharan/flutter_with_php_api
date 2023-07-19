class User {
  final int id;
  final String name;
  final String email;
  final DateTime dob;
  final String address;
  final String phoneNo;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.address,
    required this.phoneNo,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  static User fetchUserData(Map<String, dynamic> data) {
    return User(
      id: int.parse(data['id']),
      name: data['name'],
      email: data['email'],
      dob: DateTime.parse(data['dob']),
      address: data['address'],
      phoneNo: data['phone_no'],
      latitude: double.parse(data['latitude']),
      longitude: double.parse(data['longitude']),
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }
}

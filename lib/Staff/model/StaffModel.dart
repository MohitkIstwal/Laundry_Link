class StaffModel{
  final String name;
  final String userName;
  final String emailId;
  final String password;
  final String storeName;

  StaffModel({
    required this.name,
    required this.userName,
    required this.emailId,
    required this.password,
    required this.storeName
  });

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'userName' : userName,
      'email' : emailId,
      'password' : password,
      'storeName' : storeName
    };
  }

}
class AdminModel {
  final String userName;
  final String name;
  final String emailId;
  final String password;

  AdminModel({
    required this.userName,
    required this.name,
    required this.emailId,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return {
      'userName' : userName,
      'name' : name,
      'emailId' : emailId,
      'password' : password
    };
  }
}
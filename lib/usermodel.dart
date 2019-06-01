class User {
  Map<String, dynamic> data;
  String compatibility;
  User({this.data, this.compatibility});

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: json,
        compatibility: json['compatibility'].toString(),
      );
}

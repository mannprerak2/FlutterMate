class User {
  Map<String, dynamic> data;
  double compatibility;
  User({this.data, this.compatibility});

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: json,
        compatibility: double.parse(json['compatibility']),
      );
}

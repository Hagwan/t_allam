import 'dart:convert';

class AppUser {
  final String uid;
  final String email;
  String name;
  bool gender;
  int age;
  int level;
  
  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.gender,
    required this.age,
    required this.level,
  });

  AppUser copyWith({
    String? uid,
    String? email,
    String? name,
    bool? gender,
    int? age,
    int? level,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'gender': gender,
      'age': age,
      'level': level,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      gender: map['gender'] as bool,
      age: map['age'] as int,
      level: map['level'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) => AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, gender: $gender, age: $age, level: $level)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.email == email && other.name == name && other.gender == gender && other.age == age && other.level == level;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ email.hashCode ^ name.hashCode ^ gender.hashCode ^ age.hashCode ^ level.hashCode;
  }
}

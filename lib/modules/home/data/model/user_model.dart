import 'package:challenge_petize/modules/home/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.login,
    required super.avatarUrl,
    required super.followers,
    required super.following,
    required super.bio,
    required super.blog,
    required super.company,
    required super.email,
    required super.location,
    required super.twitterUsername,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        id: json['id'] ?? 0,
        avatarUrl: json['avatar_url'] ?? '',
        name: json['name'] ?? '',
        company: json['company'] ?? '',
        blog: json['blog'] ?? '',
        location: json['location'] ?? '',
        email: json['email'] ?? '',
        bio: json['bio'] ?? '',
        twitterUsername: json['twitter_username'] ?? '',
        followers: json['followers'] ?? 0,
        following: json['following'] ?? 0,
        login: json['login'] ?? '',
      );
    } catch (e) {
      print('Erro ao parsear JSON: $e');
      rethrow;
    }
  }
}

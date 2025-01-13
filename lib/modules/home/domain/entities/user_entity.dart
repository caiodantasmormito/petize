import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String login;
  final int id;

  final String avatarUrl;

  final String name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;

  final String? bio;
  final String? twitterUsername;

  final int followers;
  final int following;

  const UserEntity({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.twitterUsername,
    required this.followers,
    required this.following,
  });

  @override
  List<Object?> get props => [
        login,
        id,
        avatarUrl,
        name,
        company,
        blog,
        location,
        email,
        bio,
        twitterUsername,
        followers,
        following,
      ];
}

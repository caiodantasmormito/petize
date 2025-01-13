import 'package:challenge_petize/modules/profile/domain/entities/repo_entity.dart';

class RepositoryModel extends RepositoryEntity {
  const RepositoryModel({
    required super.name,
    required super.description,
    required super.htmlUrl,
    required super.stargazersCount,
    required super.updatedAt,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      description: json['description'] ?? '',
      htmlUrl: json['html_url'],
      stargazersCount: json['stargazers_count'] ?? 0,
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

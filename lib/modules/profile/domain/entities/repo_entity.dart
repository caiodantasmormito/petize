import 'package:equatable/equatable.dart';

class RepositoryEntity extends Equatable {
  final String name;
  final String htmlUrl;
  final String description;
  final int stargazersCount;
  final String updatedAt;

  const RepositoryEntity({
    required this.name,
    required this.htmlUrl,
    required this.description,
    required this.stargazersCount,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        name,
        htmlUrl,
        description,
        stargazersCount,
        updatedAt,
      ];
}

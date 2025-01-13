import 'package:challenge_petize/core/domain/failure/failure.dart';
import 'package:challenge_petize/core/domain/usecase/usecase.dart';
import 'package:challenge_petize/modules/profile/domain/entities/repo_entity.dart';
import 'package:challenge_petize/modules/profile/domain/repositories/profile_repository.dart';

class ProfileUseCase implements UseCase<List<RepositoryEntity>, String> {
  final ProfileRepository repository;

  ProfileUseCase({required this.repository});
  @override
  Future<(Failure?, List<RepositoryEntity>?)> call(String username) =>
      repository.getUserRepo(username: username);
}

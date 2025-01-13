import 'package:challenge_petize/core/domain/failure/failure.dart';
import 'package:challenge_petize/modules/profile/domain/entities/repo_entity.dart';

abstract class ProfileRepository {
  Future<(Failure?, List<RepositoryEntity>?)> getUserRepo({
    required String username,
  });
}

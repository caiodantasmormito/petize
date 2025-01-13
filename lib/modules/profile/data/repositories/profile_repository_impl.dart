import 'package:challenge_petize/core/domain/failure/failure.dart';
import 'package:challenge_petize/modules/profile/core/failures/failures.dart';
import 'package:challenge_petize/modules/profile/data/datasource/profile_datasource.dart';
import 'package:challenge_petize/modules/profile/data/exceptions/exceptions.dart';
import 'package:challenge_petize/modules/profile/domain/entities/repo_entity.dart';
import 'package:challenge_petize/modules/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _datasource;

  ProfileRepositoryImpl({required ProfileDatasource datasource})
      : _datasource = datasource;

  @override
  Future<(Failure?, List<RepositoryEntity>?)> getUserRepo(
      {required String username}) async {
    try {
      final result = await _datasource.getUserRepo(username: username);
      return (null, result);
    } on GetReposException catch (e) {
      return (GetRepoFailure(message: e.message), null);
    }
  }
}

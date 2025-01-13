import 'package:challenge_petize/core/domain/failure/failure.dart';
import 'package:challenge_petize/modules/home/core/failures/failures.dart';
import 'package:challenge_petize/modules/home/data/datasource/home_datasource.dart';
import 'package:challenge_petize/modules/home/data/exceptions/exceptions.dart';
import 'package:challenge_petize/modules/home/domain/entities/user_entity.dart';
import 'package:challenge_petize/modules/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _datasource;

  HomeRepositoryImpl({required HomeDatasource datasource})
      : _datasource = datasource;

  @override
  Future<(Failure?, UserEntity?)> getUser({required String username}) async {
    try {
      final result = await _datasource.getUser(username: username);
      return (null, result);
    } on FindUserException catch (e) {
      return (FindUserFailure(message: e.message), null);
    }
  }
}

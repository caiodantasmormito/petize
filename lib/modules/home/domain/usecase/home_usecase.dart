import 'package:challenge_petize/core/domain/failure/failure.dart';
import 'package:challenge_petize/core/domain/usecase/usecase.dart';
import 'package:challenge_petize/modules/home/domain/entities/user_entity.dart';
import 'package:challenge_petize/modules/home/domain/repositories/home_repository.dart';

class HomeUseCase implements UseCase<UserEntity, String> {
  final HomeRepository repository;

  HomeUseCase({required this.repository});
  @override
  Future<(Failure?, UserEntity?)> call(String username) =>
      repository.getUser(username: username);
}

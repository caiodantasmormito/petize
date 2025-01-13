

import 'package:challenge_petize/core/domain/failure/failure.dart';
import 'package:challenge_petize/modules/home/domain/entities/user_entity.dart';

abstract class HomeRepository {
  Future<(Failure?, UserEntity?)> getUser({
    required String username,
  });

  
}

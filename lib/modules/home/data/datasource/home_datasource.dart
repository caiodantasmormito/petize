import 'package:challenge_petize/modules/home/data/model/user_model.dart';

abstract class HomeDatasource {
  Future<UserModel> getUser({
    required String username,
  });
}

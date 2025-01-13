import 'package:challenge_petize/modules/profile/data/model/repo_model.dart';

abstract class ProfileDatasource {
  Future<List<RepositoryModel>> getUserRepo({
    required String username,
  });
}

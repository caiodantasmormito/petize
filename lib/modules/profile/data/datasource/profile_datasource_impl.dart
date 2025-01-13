import 'package:challenge_petize/core/domain/infra/http_client.dart';
import 'package:challenge_petize/modules/profile/data/datasource/profile_datasource.dart';
import 'package:challenge_petize/modules/profile/data/exceptions/exceptions.dart';
import 'package:challenge_petize/modules/profile/data/model/repo_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ProfileDatasourceImpl implements ProfileDatasource {
  final AuthenticatedClient _httpClient;

  ProfileDatasourceImpl({
    required AuthenticatedClient httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<RepositoryModel>> getUserRepo({
    required String username,
  }) async {
    try {
      final Response response = await _httpClient.get(
        '/users/$username/repos',
      );
      final List<dynamic> repo = response.data;

      return repo.map((rep) => RepositoryModel.fromJson(rep)).toList();
    } on DioException catch (e, s) {
      if (kDebugMode) {
        debugPrintStack(label: e.toString(), stackTrace: s);
      }

      throw const GetReposException(
        message: 'Nenhum repositório encontrado)',
      );
    } catch (e) {
      throw const GetReposException(
        message: 'Erro inesperado',
      );
    }
  }
}

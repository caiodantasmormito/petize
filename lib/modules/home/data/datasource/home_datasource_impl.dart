import 'package:challenge_petize/core/domain/infra/http_client.dart';
import 'package:challenge_petize/modules/home/data/datasource/home_datasource.dart';
import 'package:challenge_petize/modules/home/data/exceptions/exceptions.dart';
import 'package:challenge_petize/modules/home/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HomeDatasourceImpl implements HomeDatasource {
  final AuthenticatedClient _httpClient;

  HomeDatasourceImpl({
    required AuthenticatedClient httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<UserModel> getUser({
    required String username,
  }) async {
    try {
      final Response response = await _httpClient.get(
        '/users/$username',
      );

      return UserModel.fromJson(
        response.data,
      );
    } on DioException catch (e, s) {
      if (kDebugMode) {
        debugPrintStack(label: e.toString(), stackTrace: s);
      }

      throw const FindUserException(
        message: 'Usuário não encontrado',
      );
    } catch (e) {
      throw const FindUserException(
        message: 'Erro inesperado',
      );
    }
  }
}

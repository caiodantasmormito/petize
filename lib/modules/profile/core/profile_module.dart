import 'package:challenge_petize/core/domain/infra/http_client.dart';
import 'package:challenge_petize/modules/profile/data/datasource/profile_datasource.dart';
import 'package:challenge_petize/modules/profile/data/datasource/profile_datasource_impl.dart';
import 'package:challenge_petize/modules/profile/data/repositories/profile_repository_impl.dart';
import 'package:challenge_petize/modules/profile/domain/usecase/profile_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/cubit/profile_cubit.dart';
import '../presentation/pages/profile_page.dart';

class ProfileModule extends Module {
  final SharedPreferences sharedPreferences;

  ProfileModule({required this.sharedPreferences});
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HttpClient()),
        Bind.lazySingleton<ProfileDatasource>(
          (i) => ProfileDatasourceImpl(
            httpClient: AuthenticatedClient(
              sharedPreferences: sharedPreferences,
            ),
          ),
        ),
        Bind.lazySingleton(
          (i) => ProfileRepositoryImpl(
            datasource: i<ProfileDatasource>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => ProfileUseCase(
            repository: i<ProfileRepositoryImpl>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => ProfileCubit(
            useCase: i<ProfileUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/:username',
            child: (context, args) =>
                ProfilePage(username: args.params['username'])),
      ];
}

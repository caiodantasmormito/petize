import 'package:challenge_petize/core/domain/infra/http_client.dart';
import 'package:challenge_petize/modules/home/data/datasource/home_datasource.dart';
import 'package:challenge_petize/modules/home/data/datasource/home_datasource_impl.dart';
import 'package:challenge_petize/modules/home/data/repositories/home_repository_impl.dart';
import 'package:challenge_petize/modules/home/domain/usecase/home_usecase.dart';
import 'package:challenge_petize/modules/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/pages/home_page.dart';

class HomeModule extends Module {
  final SharedPreferences sharedPreferences;

  HomeModule({required this.sharedPreferences});

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HttpClient()),
        Bind.lazySingleton<HomeDatasource>(
          (i) => HomeDatasourceImpl(
            httpClient: AuthenticatedClient(
              sharedPreferences: sharedPreferences,
            ),
          ),
        ),
        Bind.lazySingleton(
          (i) => HomeRepositoryImpl(
            datasource: i<HomeDatasource>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => HomeUseCase(
            repository: i<HomeRepositoryImpl>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => HomeCubit(
            useCase: i<HomeUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, __) => const HomePage()),
      ];
}

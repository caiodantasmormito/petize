import 'package:challenge_petize/core/domain/infra/http_client.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/core/home_module.dart';
import 'modules/profile/core/profile_module.dart';

class AppModule extends Module {
  final SharedPreferences sharedPreferences;
  AppModule({required this.sharedPreferences});

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HttpClient()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/',
            module: HomeModule(sharedPreferences: sharedPreferences)),
        ModuleRoute('/profile',
            module: ProfileModule(sharedPreferences: sharedPreferences)),
      ];
}

import 'package:flutter/material.dart';
import '../../modules/login/login_page.dart';
import '../../modules/cadastro/cadastro_page.dart';
import '../../modules/home/home_page.dart';
import '../../modules/mapa/mapa_page.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, Widget Function(BuildContext)> pages = {
    AppRoutes.login: (_) => const LoginPage(),
    AppRoutes.cadastro: (_) => const CadastroPage(),
    AppRoutes.home: (_) => const HomePage(),
    AppRoutes.mapa: (_) => const MapaPage(),
  };
}

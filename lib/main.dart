import 'package:desafio_3tecnos/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'core/routes/app_pages.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: AppPages.pages,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

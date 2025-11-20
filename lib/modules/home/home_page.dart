import 'package:desafio_3tecnos/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.15,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo_3tecnos.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Conteúdo principal
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bem vindo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Esse é meu teste",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);

            if (index == 1) {
              Navigator.pushNamed(context, AppRoutes.mapa);
            }
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 28),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map, size: 28),
              label: "Mapa",
            ),
          ],
        ),
      ),
    );
  }
}

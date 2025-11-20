import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/theme/app_colors.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LatLng posicaoAtual = const LatLng(-15.7797, -47.9297);
  final MapController mapController = MapController();

  final latController = TextEditingController();
  final lngController = TextEditingController();

  int currentIndex = 1;

  Future pegarLocalizacao() async {
    bool servicosHabilitados = await Geolocator.isLocationServiceEnabled();
    if (!servicosHabilitados) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ative a localização do dispositivo.")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Permissão de localização negada permanentemente.\n"
            "Vá até as configurações do aparelho para liberar.",
          ),
        ),
      );
      return;
    }

    final pos = await Geolocator.getCurrentPosition();

    setState(() {
      posicaoAtual = LatLng(pos.latitude, pos.longitude);
    });

    mapController.move(posicaoAtual, 14);
  }

  @override
  void initState() {
    super.initState();
    pegarLocalizacao();
  }

  void atualizarLocal() {
    final lat = double.tryParse(latController.text);
    final lng = double.tryParse(lngController.text);

    if (lat != null && lng != null) {
      setState(() {
        posicaoAtual = LatLng(lat, lng);
      });

      mapController.move(posicaoAtual, 14);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: posicaoAtual,
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.desafio_3tecnos',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40,
                      height: 40,
                      point: posicaoAtual,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                TextField(
                  controller: latController,
                  decoration: const InputDecoration(
                    labelText: "Latitude",
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: lngController,
                  decoration: const InputDecoration(
                    labelText: "Longitude",
                    prefixIcon: Icon(Icons.location_searching),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: atualizarLocal,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.success,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Localizar",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
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

            if (index == 0) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (index == 2) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            }
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 28),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map, size: 28),
              label: "Mapa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout, size: 28),
              label: "Sair",
            ),
          ],
        ),
      ),
    );
  }
}

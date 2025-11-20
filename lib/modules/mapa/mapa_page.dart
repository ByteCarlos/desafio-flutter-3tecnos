import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  late GoogleMapController mapController;

  LatLng posicaoAtual = const LatLng(-15.7797, -47.9297); // Brasília default

  final latController = TextEditingController();
  final lngController = TextEditingController();

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

    try {
      mapController.animateCamera(CameraUpdate.newLatLng(posicaoAtual));
    } catch (_) {}
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
      mapController.animateCamera(CameraUpdate.newLatLng(posicaoAtual));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (c) => mapController = c,
              initialCameraPosition: CameraPosition(
                target: posicaoAtual,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("Atual"),
                  position: posicaoAtual,
                ),
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade200,
            child: Column(
              children: [
                TextField(
                  controller: latController,
                  decoration: const InputDecoration(labelText: "Latitude"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: lngController,
                  decoration: const InputDecoration(labelText: "Longitude"),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: atualizarLocal,
                  child: const Text("Exibir localização"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

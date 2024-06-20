// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(-23.6114, -46.694),
      zoom: 17,
    );
    Set<Marker> markers = <Marker>{
      Marker(
        markerId: const MarkerId('marker1'),
        position: const LatLng(-23.610366, -46.694891),
        infoWindow: InfoWindow(
          title: 'Itaú Personnalité',
          snippet: 'Av. Luís Carlos Berrini, 1550',
          anchor: const Offset(0.5, 0.5),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: Image.asset(
                  "assets/itau.png",
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('marker2'),
        position: const LatLng(-23.611477, -46.694059),
        infoWindow: InfoWindow(
          title: 'Edifício Igaratá',
          snippet: 'Rua Samuel Morse, 74',
          anchor: const Offset(0.5, 0.5),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: Image.asset(
                  "assets/samuelmorse.png",
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('Camera 3'),
        position: const LatLng(-23.610909, -46.695052),
        infoWindow: InfoWindow(
          title: 'Ponto de Ônibus',
          snippet: 'Av. Luís Carlos Berrini, 1636',
          anchor: const Offset(0.5, 0.5),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: Image.asset(
                  "assets/ponto.png",
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    };
    return GoogleMap(
      mapType: MapType.normal,
      markers: markers,
      initialCameraPosition: kGooglePlex,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../service/app_router.dart';
import '../service/firestore_provider.dart';
import 'sensor_data_page.dart';

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  static const name = 'map';
  static const path = '/$name';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return ref.watch(sensor1Provider).when(
          data: (sensorData1) => FlutterMap(
            options: MapOptions(center: LatLng(22.326208, 114.167748), zoom: 18.0, maxZoom: 18),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80,
                    height: 80,
                    point: LatLng(sensorData1.lat, sensorData1.lng),
                    builder: (_) => Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => ref
                            .read(routerProvider)
                            .pushNamed(SensorDataPage.name, queryParams: {'docID': sensorData1.docID}),
                        child: Icon(Icons.pin_drop, color: colorScheme.primary, size: 70),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          error: (error, stackTrace) => Center(child: Text('error: $error\nstackTrace: $stackTrace')),
          loading: () => const CircularProgressIndicator(),
        );
  }
}

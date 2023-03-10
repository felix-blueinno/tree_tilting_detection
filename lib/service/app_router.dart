import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../screen/map_page.dart';
import '../screen/sensor_data_page.dart';

final routerProvider = Provider((_) {
  return GoRouter(
    initialLocation: MapPage.path,
    routes: [
      GoRoute(
        path: MapPage.path,
        name: MapPage.name,
        builder: (context, state) => const MapPage(),
      ),
      GoRoute(
        path: SensorDataPage.path,
        name: SensorDataPage.name,
        builder: (context, state) {
          final docID = state.queryParams['docID'];
          return SensorDataPage(docID: docID!);
        },
      ),
    ],
  );
});

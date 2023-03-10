import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/sensor_data.dart';

final firestoreProvider = Provider.autoDispose((_) => FirebaseFirestore.instance);

final sensor1Provider = StreamProvider.autoDispose((ref) {
  return ref.watch(firestoreProvider).collection('data').doc('Ndikh93OcLxlEW5eG898').snapshots().map((doc) {
    final data = doc.data()!;
    data['docID'] = doc.id;
    return SensorData.fromJson(data);
  });
});

// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_data.freezed.dart';
part 'sensor_data.g.dart';

@freezed
class SensorData with _$SensorData {
  const factory SensorData({
    @JsonKey(name: 'coor') required List<Coordinate> coordinates,
    @JsonKey(name: 'lat', fromJson: _toDouble) required double lat,
    @JsonKey(name: 'lng', fromJson: _toDouble) required double lng,
    required String docID,
  }) = _SensorData;

  factory SensorData.fromJson(Map<String, dynamic> json) => _$SensorDataFromJson(json);
}

@freezed
class Coordinate with _$Coordinate {
  const factory Coordinate({
    @JsonKey(name: 'x', fromJson: _toDouble) required double x,
    @JsonKey(name: 'y', fromJson: _toDouble) required double y,
    @JsonKey(name: 'z', fromJson: _toDouble) required double z,
    @JsonKey(name: 't', fromJson: _timeStampFromJson) required DateTime t,
  }) = _Coordinate;

  factory Coordinate.fromJson(Map<String, dynamic> json) => _$CoordinateFromJson(json);
}

DateTime _timeStampFromJson(Timestamp timestamp) => timestamp.toDate();

double _toDouble(String value) => double.parse(value);

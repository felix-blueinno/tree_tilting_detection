import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/sensor_data.dart';
import '../service/firestore_provider.dart';

const _markdownDescription = '''\n
Assumes that the device is stationary and the sensor is mounted to a tree stem,
where the y-axis is only axis has force (gravity) acting on it.
''';

class SensorDataPage extends ConsumerWidget {
  const SensorDataPage({super.key, required this.docID});

  static const name = 'sensor_data';
  static const path = '/$name';

  final String docID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return ref.watch(sensor1Provider).when(
          data: (data) {
            final coordinates = data.coordinates;
            final xs = coordinates.map((e) => e.x).toList();
            final ys = coordinates.map((e) => e.y).toList();
            final zs = coordinates.map((e) => e.z).toList();
            final ts = coordinates.map((e) => e.t).toList();

            // Assumes that the device is stationary and the sensor is mounted to a tree stem,
            // where the y-axis is only axis has force (gravity) acting on it.
            // In reality, there may be other forces acting on the device,
            // and the calculated angle may not be accurate.
            final x = xs.last;
            final y = ys.last;
            final z = zs.last;

            final angle = atan(y / sqrt(pow(x, 2) + pow(z, 2)));
            final angleInDegrees = (angle * 180 / pi).abs();

            final isFalling = angleInDegrees.abs() < 30;

            return Scaffold(
              backgroundColor: isFalling ? colorScheme.errorContainer : null,
              appBar: AppBar(title: Text('${data.lat}, ${data.lng}')),
              body: Column(
                children: [
                  ListTile(
                    leading: isFalling
                        ? Icon(Icons.warning_amber_outlined, color: colorScheme.error)
                        : const Icon(Icons.nature_people_outlined),
                    title: MarkdownBody(data: 'Angle to ground: **${angleInDegrees.toStringAsFixed(2)}°**'),
                    subtitle: const MarkdownBody(data: _markdownDescription),
                    trailing: Image.asset('assets/images/angle formula.png'),
                  ),
                  const Divider(),
                  Expanded(
                    child: AccelerationChart(
                      title: 'Accelerometer Readings',
                      coordinates: coordinates,
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stack) => const Center(child: Text('Error')),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class AccelerationChart extends ConsumerWidget {
  static const max = 30.0;
  static const min = -30.0;

  const AccelerationChart({
    super.key,
    required this.coordinates,
    required this.title,
  });

  final List<Coordinate> coordinates;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SfCartesianChart(
      title: ChartTitle(text: title),
      primaryXAxis: NumericAxis(
        axisLabelFormatter: (args) {
          final millis = args.value.toInt();
          final date = DateTime.fromMillisecondsSinceEpoch(millis);

          final dateFormatter = DateFormat('HH:mm:ss');
          final formattedDate = dateFormatter.format(date);

          return ChartAxisLabel(formattedDate, const TextStyle());
        },
      ),
      primaryYAxis: NumericAxis(
        minimum: min,
        maximum: max,
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.right,
      ),
      series: [
        LineSeries(
          isVisibleInLegend: true,
          dataSource: coordinates,
          xValueMapper: (coordinate, index) => coordinate.t.millisecondsSinceEpoch,
          yValueMapper: (coordinate, index) => coordinate.x,
          animationDuration: 0,
          name: 'X',
        ),
        LineSeries(
          isVisibleInLegend: true,
          dataSource: coordinates,
          xValueMapper: (coordinate, index) => coordinate.t.millisecondsSinceEpoch,
          yValueMapper: (coordinate, index) => coordinate.y,
          animationDuration: 0,
          name: 'Y',
        ),
        LineSeries(
          isVisibleInLegend: true,
          dataSource: coordinates,
          xValueMapper: (coordinate, index) => coordinate.t.millisecondsSinceEpoch,
          yValueMapper: (coordinate, index) => coordinate.z,
          animationDuration: 0,
          name: 'Z',
        ),
      ],
      enableAxisAnimation: false,
    );
  }
}

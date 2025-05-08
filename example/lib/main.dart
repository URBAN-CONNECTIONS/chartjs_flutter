import 'package:chartjs_flutter/chartjs_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Example of a Chart.js widget in Flutter
///
/// This example demonstrates how to create a bar chart using Chart.js in a Flutter application.
/// It includes a bar chart with multiple datasets, including a line chart overlay.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: ChartjsWidget(
          data: {
            "type": "bar",
            'options': {
              "barThickness": 15,
              "responsive": true,
              "maintainAspectRatio": false,
              "scales": {
                "x": {
                  "stacked": true,
                  "border": {
                    "display": false,
                  },
                  "grid": {
                    "display": false,
                    "drawBorder": false,
                  },
                },
                "y": {
                  "stacked": true,
                  "border": {
                    "dash": [6, 6],
                    "display": false,
                  },
                  "grid": {
                    "drawBorder": false,
                  },
                },
              },
              "plugins": {
                "legend": {
                  "display": false,
                },
                "tooltip": {
                  "mode": "index",
                },
              },
            },
            'data': {
              "labels": [
                ["ENE", "2025"],
                ["FEB", "2025"],
                ["MAR", "2025"],
                ["ABR", "2025"],
                ["MAY", "2025"],
                ["JUN", "2025"]
              ],
              "datasets": [
                {
                  "label": "Pagadas",
                  "data": [821, 510, 913, 821, 510, 913],
                  "backgroundColor": ["#57CCBA"],
                  "borderColor": ["transparent"],
                  "borderSkipped": false,
                  "borderRadius": {"bottomLeft": 50, "bottomRight": 50}
                },
                {
                  "label": "Canceladas",
                  "data": [42, 46, 56, 42, 46, 56],
                  "backgroundColor": ["#FCAB65"],
                  "borderColor": ["transparent"],
                  "borderSkipped": false
                },
                {
                  "label": "Pendientes",
                  "data": [1934, 1698, 2245, 1934, 1698, 2245],
                  "backgroundColor": ["#C9C9C9"],
                  "borderColor": ["transparent"],
                  "borderSkipped": false,
                  "borderRadius": {"topLeft": 50, "topRight": 50}
                },
                {
                  "type": "line",
                  "xAxisID": "x",
                  "label": "Totales",
                  "data": [2799, 2258, 3221, 2799, 2258, 3221],
                  "backgroundColor": ["transparent"],
                  "borderColor": ["#57CCBA"],
                  "fill": false,
                  "borderDash": [5, 5],
                  "borderWidth": 1,
                  "pointRadius": 0
                }
              ]
            }
          },
        ),
      ),
    );
  }
}

import 'dart:async';

// ignore: avoid_web_libraries_in_flutter
import 'package:universal_html/html.dart' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

/// A widget that displays a Chart.js chart in a Flutter web application.
///
/// This widget uses an HTML iframe to render the chart using Chart.js.
/// It allows you to pass data and options to customize the chart.
class ChartjsWidget extends StatefulWidget {
  /// All data for the chart.
  ///
  /// This should include the chart type, data, and options.
  final Map<String, dynamic> data;

  const ChartjsWidget({super.key, required this.data});

  @override
  State<ChartjsWidget> createState() => _ChartjsWidgetState();
}

class _ChartjsWidgetState extends State<ChartjsWidget> {
  /// The name of the component used to register the HTML element.
  ///
  /// This is generated using the hash code of the widget instance.
  /// This ensures that each instance of the widget has a unique name.
  late String componentName;

  /// A subscription to listen for messages from the HTML iframe.
  ///
  /// This is used to handle events and messages sent from the iframe.
  /// It is disposed of when the widget is removed from the widget tree.
  late StreamSubscription? listenMessage;

  @override
  void initState() {
    // Register the HTML element factory for the Chart.js widget.
    componentName = 'Chartjs$hashCode';

    ui_web.platformViewRegistry.registerViewFactory(
      componentName,
          (int viewId, {Object? params}) => html.IFrameElement(),
    );

    // Listen for messages from the HTML iframe.
    listenMessage = html.window.onMessage.listen(
          (event) => onEvent(event.data),
    );

    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the message listener when the widget is removed.
    listenMessage?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create an HTML element view for the Chart.js widget.
    return HtmlElementView.fromTagName(
      tagName: 'iframe',
      onElementCreated: (element) {
        element as html.IFrameElement;

        element
          ..style.width = '100%'
          ..style.height = '100%'
          ..src = 'packages/chartjs_flutter/assets/html/index.html'
          ..style.border = 'none'
          ..id = componentName;

        // Listen for the load event to create the chart.
        element.onLoad.listen(
              (event) => createChart(),
        );
      },
    );
  }

  /// Creates the chart by sending a message to the HTML iframe.
  ///
  /// This method sends the chart data to the iframe, which then renders the chart using Chart.js.
  /// It is called when the iframe has finished loading.
  void createChart() {
    postMessage(
      'createChart',
      data: widget.data,
    );
  }

  /// Sends a message to the HTML iframe.
  ///
  /// This method is used to communicate with the iframe and send data or events.
  /// It takes an [event] name and optional [data] to send.
  void postMessage(String event, {Object? data}) {
    html.window.parent?.postMessage(
      {
        'source': componentName,
        'event': event,
        if (data != null) 'data': data,
      },
      "*",
    );
  }

  /// Handles events received from the HTML iframe.
  ///
  /// This method is called when a message is received from the iframe.
  /// It processes the [message] and performs actions based on the event type.
  void onEvent(Map message) {
    switch (message['event']) {
      case 'onChartCreated':
        break;
    }
  }
}

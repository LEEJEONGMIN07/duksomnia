import 'dart:developer';

import 'package:flutter/material.dart';

Widget buildFloatingActionButton(ValueNotifier<bool> isRecording, Function getResult) {
  return ValueListenableBuilder(
    valueListenable: isRecording,
    builder: (context, value, widget) {
      if (value == false) {
        return FloatingActionButton(
          onPressed: () {
            isRecording.value = true;
            getResult();
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.mic),
        );
      } else {
        return FloatingActionButton(
          onPressed: () {
            log('Audio Recognition Stopped');
            // Stop audio recognition logic
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.adjust),
        );
      }
    },
  );
}

import 'dart:async';

import 'package:qrscanner/src/models/scan.dart';

class Validators {
  StreamTransformer geoValidator =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      List<ScanModel> geoScans =
          scans.where((scan) => scan.type == 'geo').toList();
      sink.add(geoScans);
    },
  );
  StreamTransformer urlValidator =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      List<ScanModel> urlScans =
          scans.where((scan) => scan.type == 'http').toList();
      sink.add(urlScans);
    },
  );
}

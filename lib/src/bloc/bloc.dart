import 'dart:async';
import 'package:qrscanner/src/bloc/validators.dart';
import 'package:qrscanner/src/providers/db.dart';
export 'package:qrscanner/src/providers/db.dart';

class Bloc with Validators {
  //INTERNAL CONSTRUCTOR INSTANCE
  static final Bloc instance = Bloc._internal();
  //INTERNAL CONSTRUCTOR
  Bloc._internal();

  StreamController _streamController =
      StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get geoScansStream =>
      _streamController.stream.transform(geoValidator);
  //
  //
  Stream<List<ScanModel>> get urlScansStream =>
      _streamController.stream.transform(urlValidator);

  void dispose() {
    _streamController?.close();
  }

  void selectAllScans() async {
    _streamController.sink.add(await DBProvider.instance.selectAll());
  }

  void insertScan(ScanModel scan) async {
    await DBProvider.instance.insert(scan);
    selectAllScans();
  }

  void deleteScan(int id) async {
    await DBProvider.instance.delete(id);
    selectAllScans();
  }

  void deleteAllScans() async {
    await DBProvider.instance.deleteAll();
    selectAllScans();
  }
}

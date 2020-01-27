import 'package:flutter/material.dart';
import 'package:qrscanner/src/bloc/bloc.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrscanner/src/funtions/launcher.dart';
import 'package:qrscanner/src/screens/url_directions.dart';
import 'package:qrscanner/src/screens/maps.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRScanner'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text('Delete all scans'),
              IconButton(
                icon: Icon(
                  Icons.delete_forever,
                ),
                onPressed: Bloc.instance.deleteAllScans,
              ),
            ],
          )
        ],
      ),
      body: _callPage(_currentIndex),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionBottom(),
    );
  }

  Widget _callPage(currentIndex) {
    switch (currentIndex) {
      case 0:
        return Maps();
      case 1:
        return Directions();
      default:
        return Maps();
    }
  }

  BottomAppBar _bottomNavigationBar() {
    return BottomAppBar(
      notchMargin: 8.0,
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Colors.white,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.web,
                color: Colors.white,
              ),
              title: Container()),
        ],
      ),
    );
  }

  FloatingActionButton _floatingActionBottom() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: _scanQRCode,
    );
  }

  void _scanQRCode() async {
    String stringQR;
    try {
      stringQR = await BarcodeScanner.scan();
    } catch (e) {
      stringQR = e.toString();
    }
    if (stringQR != null) {
      ScanModel scan = ScanModel(value: stringQR);
      Bloc.instance.insertScan(scan);
      launchURL(context, scan);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrscanner/src/bloc/bloc.dart';

class MyMap extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MyMap> {
  String _mapType = 'streets';
  MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text('Change map type'),
              IconButton(
                icon: Icon(Icons.map),
                onPressed: changeMapType,
              ),
            ],
          )
        ],
      ),
      body: _map(scan),
      floatingActionButton: _floatingActionButton(scan),
    );
  }

  void changeMapType() {
    switch (_mapType) {
      case 'streets':
        _mapType = 'dark';
        break;
      case 'dark':
        _mapType = 'light';
        break;
      case 'light':
        _mapType = 'outdoors';
        break;
      case 'outdoors':
        _mapType = 'satellite';
        break;
      case 'satellite':
        _mapType = 'streets';
        break;
      default:
    }
    setState(() {});
  }

  FloatingActionButton _floatingActionButton(ScanModel scan) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.my_location),
      onPressed: () {
        _mapController.move(scan.latlng(), 12.0);
      },
    );
  }

  FlutterMap _map(ScanModel scan) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: scan.latlng(),
        zoom: 12.0,
      ),
      layers: [_mapLayer(), _markers(scan)],
    );
  }

  TileLayerOptions _mapLayer() {
    return TileLayerOptions(
      urlTemplate:
          'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':
            'pk.eyJ1IjoiY29zc21vcyIsImEiOiJjazVjemZuZjIwNXRnM2ZzZHBlc3J4MTNqIn0.fkBNxXUiZgjH0SUQjJAgjg',
        'id': 'mapbox.$_mapType'
        //streets, dark, light, outdoors, satellite
      },
    );
  }

  MarkerLayerOptions _markers(ScanModel scan) {
    return MarkerLayerOptions(
      markers: [
        Marker(
            width: 100.0,
            height: 100.0,
            point: scan.latlng(),
            builder: (BuildContext context) {
              return Icon(
                Icons.location_on,
                size: 50.0,
                color: Theme.of(context).primaryColor,
              );
            }),
      ],
    );
  }
}

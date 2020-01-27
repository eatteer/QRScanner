import 'package:flutter/material.dart';
import 'package:qrscanner/src/bloc/bloc.dart';
import 'package:qrscanner/src/funtions/launcher.dart';

class Maps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc.instance.selectAllScans();
    return StreamBuilder(
      stream: Bloc.instance.geoScansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) return Container();
        if (snapshot.data.length == 0) {
          return Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  height: 200.0,
                  width: 200.0,
                  image: AssetImage('lib/src/assets/map.png'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'No maps',
                  style: Theme.of(context).textTheme.title,
                )
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                Bloc.instance.deleteScan(snapshot.data[index].id);
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerRight,
                color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.delete, color: Colors.white),
                    Icon(Icons.delete, color: Colors.white),
                  ],
                ),
              ),
              child: ListTile(
                leading: Icon(Icons.map),
                title: Text(
                  snapshot.data[index].value,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchURL(context, snapshot.data[index]),
              ),
            );
          },
        );
      },
    );
  }
}

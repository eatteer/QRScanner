import 'package:flutter/material.dart';
import 'package:qrscanner/src/bloc/bloc.dart';
import 'package:qrscanner/src/funtions/launcher.dart';
import 'package:qrscanner/src/models/scan.dart';

class Directions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc.instance.selectAllScans();
    return StreamBuilder(
      stream: Bloc.instance.urlScansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) return Container();
        if (snapshot.data.length == 0) {
          return Center(
            child: Text(
              'No url directions',
              style: Theme.of(context).textTheme.title,
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
                leading: Icon(Icons.web),
                title: Text(snapshot.data[index].value),
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

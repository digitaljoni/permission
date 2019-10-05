import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission/permission.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool a0 = false, a1 = false, a2 = false, a3 = false, a4 = false, a5 = false, a6 = false, a7 = false, a8 = false;
  bool i0 = false, i1 = false, i2 = false, i3 = false, i4 = false, i5 = false;
  int radioValue = 0;
  PermissionName permissionName = PermissionName.Internet;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Offstage(
                offstage: !Platform.isAndroid,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: a0,
                      onChanged: (v) {
                        setState(() {
                          a0 = v;
                        });
                      },
                    ),
                    Text('Calendar'),
                    Checkbox(
                      value: a1,
                      onChanged: (v) {
                        setState(() {
                          a1 = v;
                        });
                      },
                    ),
                    Text('Camera'),
                    Checkbox(
                      value: a2,
                      onChanged: (v) {
                        setState(() {
                          a2 = v;
                        });
                      },
                    ),
                    Text('Contacts'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isAndroid,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: a3,
                      onChanged: (v) {
                        setState(() {
                          a3 = v;
                        });
                      },
                    ),
                    Text('Microphone'),
                    Checkbox(
                      value: a4,
                      onChanged: (v) {
                        setState(() {
                          a4 = v;
                        });
                      },
                    ),
                    Text('Location'),
                    Checkbox(
                      value: a5,
                      onChanged: (v) {
                        setState(() {
                          a5 = v;
                        });
                      },
                    ),
                    Text('Phone'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isAndroid,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: a6,
                      onChanged: (v) {
                        setState(() {
                          a6 = v;
                        });
                      },
                    ),
                    Text('Sensors'),
                    Checkbox(
                      value: a7,
                      onChanged: (v) {
                        setState(() {
                          a7 = v;
                        });
                      },
                    ),
                    Text('SMS'),
                    Checkbox(
                      value: a8,
                      onChanged: (v) {
                        setState(() {
                          a8 = v;
                        });
                      },
                    ),
                    Text('Storage'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: i0,
                      onChanged: (v) {
                        setState(() {
                          i0 = v;
                        });
                      },
                    ),
                    Text('Internet'),
                    Checkbox(
                      value: i1,
                      onChanged: (v) {
                        setState(() {
                          i1 = v;
                        });
                      },
                    ),
                    Text('Calendar'),
                    Checkbox(
                      value: i2,
                      onChanged: (v) {
                        setState(() {
                          i2 = v;
                        });
                      },
                    ),
                    Text('Camera'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: i3,
                      onChanged: (v) {
                        setState(() {
                          i3 = v;
                        });
                      },
                    ),
                    Text('Contacts'),
                    Checkbox(
                      value: i4,
                      onChanged: (v) {
                        setState(() {
                          i4 = v;
                        });
                      },
                    ),
                    Text('Microphone'),
                    Checkbox(
                      value: i5,
                      onChanged: (v) {
                        setState(() {
                          i5 = v;
                        });
                      },
                    ),
                    Text('Location'),
                  ],
                ),
              ),
              RaisedButton(onPressed: getPermissionsStatus, child: new Text("Get permission status")),
              RaisedButton(onPressed: requestPermissions, child: new Text("Request permissions")),
              RaisedButton(onPressed: Permission.openSettings, child: new Text("Open settings")),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }

  getPermissionsStatus() async {
    List<PermissionName> permissionNames = [];
    if(a1) permissionNames.add(PermissionName.Camera);
    if(a4) permissionNames.add(PermissionName.Location);



    if(i2) permissionNames.add(PermissionName.Camera);
    if(i5) permissionNames.add(PermissionName.Location);
    message = '';
    List<Permissions> permissions = await Permission.getPermissionsStatus(permissionNames);
    permissions.forEach((permission) {
      message += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    setState(() {
      message;
    });
  }

  getSinglePermissionStatus() async {
    var permissionStatus = await Permission.getSinglePermissionStatus(permissionName);
    setState(() {
      message = permissionStatus.toString();
    });
  }

  requestPermissions() async {
    List<PermissionName> permissionNames = [];
    if(a1) permissionNames.add(PermissionName.Camera);
    if(a4) permissionNames.add(PermissionName.Location);

    if(i2) permissionNames.add(PermissionName.Camera);
    if(i5) permissionNames.add(PermissionName.Location);
    message = '';
    var permissions = await Permission.requestPermissions(permissionNames);
    permissions.forEach((permission) {
      message += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    setState(() {
      message;
    });
  }
}

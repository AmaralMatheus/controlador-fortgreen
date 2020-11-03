import 'dart:io';

import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  final String label;
  final File image;
  final Function upload;

  Upload({this.upload, this.image, this.label});

  _UploadState createState() =>
      _UploadState(upload: this.upload, file: this.image, label: this.label);
}

class CooperateModel {}

class _UploadState extends State<Upload> {
  final String label;
  final Function upload;
  File file;

  _UploadState({this.upload, this.label, this.file});

  Widget build(BuildContext context) {
    if (file == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
                20.0, MediaQuery.of(context).size.height * 0.025, 20.0, 0.0),
            child: Text(label,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 2.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                onPressed: () {
                  upload;
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 2 -
                        MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width / 2 -
                        MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Fotografar',
                              style: TextStyle(color: Colors.grey)),
                          Icon(Icons.camera_alt,
                              color: Color.fromARGB(255, 141, 199, 63)),
                        ])),
              ),
              FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  onPressed: () {
                    upload;
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 2 -
                          MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width / 2 -
                          MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Fazer upload',
                                style: TextStyle(color: Colors.grey)),
                            Icon(Icons.file_upload,
                                color: Color.fromARGB(255, 141, 199, 63)),
                          ])))
            ],
          )
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
                20.0, MediaQuery.of(context).size.height * 0.025, 20.0, 0.0),
            child: Text(label,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 2.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                onPressed: () {
                  upload;
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 2 -
                        MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width / 2 -
                        MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Fotografar',
                              style: TextStyle(color: Colors.grey)),
                          Icon(Icons.camera_alt,
                              color: Color.fromARGB(255, 141, 199, 63)),
                        ])),
              ),
              FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  onPressed: () {
                    upload;
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 -
                        MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width / 2 -
                        MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(file), fit: BoxFit.cover),
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ))
            ],
          )
        ],
      );
    }
  }
}

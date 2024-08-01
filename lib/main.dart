import 'dart:convert';
import 'dart:io';

import 'package:async_zip/async_zip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Asynchronous Zip example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: Text('Create Zip file'),
                onPressed: () => _createZipFile(),
              ),
              // ElevatedButton(
              //   child: Text('Read Zip file'),
              //   onPressed: () => _readZipFile(),
              // ),
              // ElevatedButton(
              //   child: Text('Extract Zip file'),
              //   onPressed: () => _extractZipFile(),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('Take note of logging output in the console'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createZipFile() async {
    final tempDir = Directory.systemTemp;
    final archiveFile =
        File(path.join(tempDir.path, 'create-archive-sync.zip'));
    final photoData = await rootBundle.load('assets/images/photo1.png');
    final photoFile = File(path.join(tempDir.path, 'image.png'));
    await photoFile.writeAsBytes(photoData.buffer.asUint8List());

    final writer = ZipFileWriterSync();
    try {
      writer.create(archiveFile);
    } on ZipException catch (ex) {
      print('An error occurred while creating the Zip file: ${ex.message}');
    } finally {
      writer.close();
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



class CounterStorage {

   Future<String> novoarqv() async {

    final path = await _localPath;
    var file = new File('$path/file2a.txt');
    var sink = file.openWrite();
    sink.writeln('FILE ACCESSED1 ${new DateTime.now()}\n');
    sink.writeln('FILE ACCESSED2 ${new DateTime.now()}\n');
    sink.writeln('FILE ACCESSED3 ${new DateTime.now()}\n');
    sink.writeln('FILE ACCESSED4 ${new DateTime.now()}\n');

    // Close the IOSink to free system resources.
    sink.close();
    return "0k";
  }

  Future<String> lerArquivo() async {
    final path = await _localPath;
    var file = new File('$path/file2a.txt');
    Stream<List<int>> inputStream = file.openRead();

    inputStream
        .transform(utf8.decoder)       // Decode bytes to UTF-8.
        .transform(new LineSplitter()) // Convert stream to individual lines.
        .listen((String line) {        // Process results.
      print('$line: ${line.length} bytes');
     },
        onDone: () { print('File is now closed.'); },
        onError: (e) { print(e.toString()); });

    return "0k";
  }

  String pth ;
  String arquivo;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    //final externalDirectory = await getExternalStorageDirectory();
    //final directory =   await getExternalStorageDirectory();
    pth = directory.path;
    return directory.path;
  }

  String getLocalarmazenamento(){
    return this.pth;
  }

  String getArquivo(){
    return this.arquivo;
  }

  String setArquivo(String novoarquivo){
     this.arquivo = novoarquivo;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final nomearquivo = getArquivo();
    return File('$path/textonovo1.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();


      print("Read val: "+contents);


      return contents;//int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return "0";
    }
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    String contents = "";

    if (file.exists() != null ){
      String conte = await readCounter();
      contents = contents  +"\n"+ conte  + "\n" + counter + "\n";
    }
    else
      {
        contents = contents + counter + "\n";
      }

    // Write the file
    return file.writeAsString(contents);
  }
}
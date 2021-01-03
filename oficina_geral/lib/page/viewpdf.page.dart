import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class ViewPdfPage extends StatelessWidget {


  @override
  Widget build(BuildContext context ) {


    return  Scaffold(

      body: new ViewPdfPageful( ),
    );

  }

}


class ViewPdfPageful extends StatefulWidget {



  String text;

  ViewPdfPageful({Key key,   }) : super(key: key);

  @override
  _ViewPdfPagefulState createState() => new _ViewPdfPagefulState();

}

class _ViewPdfPagefulState extends State<ViewPdfPageful> {

  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });

}


  Future<File> createFileOfPdfUrl() async {
    final url = "https://veracruzltda.nyc3.digitaloceanspaces.com/PPR/011671_PPR1920.pdf"; // "http://africau.edu/images/default/sample.pdf";
    // https://veracruzltda.nyc3.digitaloceanspaces.com/INFORME/arinaldoinforme.pdf ;
    // https://veracruzltda.nyc3.digitaloceanspaces.com/COMISSAO/012340_04_2020comisao.pdf
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(
        child: RaisedButton(
          child: Text("Open PDF"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
          ),
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}
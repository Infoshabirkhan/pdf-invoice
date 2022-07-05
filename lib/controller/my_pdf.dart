import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf_invoice/model/invoice.dart';
import 'package:pdf_invoice/widgets/pdf_desgn.dart';

class MyPdf {
  static Future<File> generateNewPdf({required Invoice invoice, required Uint8List signature}) async {
    final pdf = pw.Document();

    var logo = (await rootBundle.load("assets/images/logo.jpeg")).buffer.asUint8List();

    var qr = (await rootBundle.load("assets/images/qr_code.jpg")).buffer.asUint8List();

    pdf.addPage(

      pw.MultiPage(
       footer: (pw.Context context){
         return  PdfDesign.bottomBanner();

      },
          pageFormat: PdfPageFormat.a3,
          margin: const pw.EdgeInsets.all(0),
          build: (pw.Context context) => [




            PdfDesign.topBanner(),

            PdfDesign.invoiceId(invoice: invoice, logo: logo, qr: qr),
            PdfDesign.billedBy(invoice: invoice),




            PdfDesign.tableHeading( ),


            pw.ListView.builder(
                itemCount: invoice.items.length,
                itemBuilder: ( context, index){

                  var item = invoice.items[index];
                  var serialNumber  = index;
                  item['name'];
              return PdfDesign.tableData(items: item, backgroundColor: PdfColors.white, serialNumber : serialNumber);
            }, ),




            PdfDesign.termsAndConditions(invoice: invoice),





            PdfDesign.signature(signature: signature),




          ]),

    );

    var tempDirectory = await getTemporaryDirectory();

    debugPrint('=======================');
    debugPrint('${tempDirectory.path}');
    final file = File('${tempDirectory.path}' '/' + 'example.pdf');

    var newPdf = await file.writeAsBytes(await pdf.save());

    return newPdf;
  }

  static Future openMyFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}

import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_invoice/constants.dart';
import 'package:pdf_invoice/controller/sum_funtion.dart';

import '../model/invoice.dart';

class PdfDesign{


  // ====================  Top banner ===========//
  static pw.Widget topBanner(){
    return     pw.Container(
        margin: const pw.EdgeInsets.only(right: 50),
        width: double.infinity,
        height: 40,
        color: PdfColors.greenAccent);

  }






  // ==================== Date Function ===========//

  static String humanReadableDate(int date){

    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(date);

    return DateFormat('MMM dd, yyy').format(dateTime);
  }









  // ====================  Invoice id QR code and logo ===========//

  static pw.Widget invoiceId({required Invoice invoice, required Uint8List logo ,required Uint8List qr })  {



    var image =   pw.MemoryImage(logo);
    var qrCode =   pw.MemoryImage(qr);

    return    pw.Container(
      height: 120,
      child: pw.Row(children: [
        pw.Expanded(
            child: pw.Container(
              margin: const pw.EdgeInsets.only(left: 50),
              decoration: const pw.BoxDecoration(
              ),
              child:  pw.Image(image),

            )),
        pw.Expanded(
            flex: 2,
            child: pw.Container(
                child: pw.Column(children: [
                  pw.Expanded(
                      child: pw.Text('Invoice',
                          style: const pw.TextStyle(fontSize: 20))),
                  pw.Expanded(
                      child: pw.Text('Invoice ID# 0001',
                          style: const pw.TextStyle(fontSize: 20))),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Row(children: [
                        pw.Expanded(
                            child: pw.Container(
                                child: pw.Column(
                                    children: [
                                      pw.Expanded(child: pw.Align(

                                          alignment: pw.Alignment.center,
                                          child: pw.Text('Invoice Date', style: const pw.TextStyle(fontSize: 14,color: PdfColors.grey)))),

                                      pw.Expanded(child: pw.Text(humanReadableDate(DateTime.now().microsecondsSinceEpoch), )),
                                    ]
                                )
                            )),
                        pw.Expanded(
                            child: pw.Container(
                                child: pw.Column(
                                    children: [


                                        pw.Expanded(child: pw.Align(

                                            alignment: pw.Alignment.center,
                                            child: pw.Text('Due Date', style: const pw.TextStyle(fontSize: 14,color: PdfColors.grey)))),


                                      pw.Expanded(child: pw.Text(humanReadableDate(DateTime.now().microsecondsSinceEpoch), )),
                                    ]
                                )
                            ))
                      ]))
                ]))),
        pw.Expanded(


            child:
            pw.Container(

              child:  pw.Image(qrCode),

            ))
      ])
    );
  }












  // ==================== Billed by  ===========//


  static pw.Widget billedBy({required Invoice invoice}){
    return     pw.Row(
        children: [
          pw.Expanded(
              child: pw.Container(
                  margin: const pw.EdgeInsets.only(left: 50,top: 30),
                  child: pw.Container(
                      height: 220,
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Expanded(child: pw.Text('Billed by', style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 22,

                                color: PdfColors.greenAccent))),



                            pw.Expanded(child: pw.Text(invoice.billByName, style: const pw.TextStyle(
                              fontSize: 18,

                            ))),

                            pw.Expanded(child: pw.Text(invoice.billByOrganization, style: const pw.TextStyle(
                              fontSize: 18,

                            ))),






                            pw.Expanded(child: pw.Text('Address :  ${invoice.billByAddress}', style: const pw.TextStyle(
                              fontSize: 18,

                            ))),


                            pw.Expanded(child: pw.Text('Phone : ${invoice.billByPhone}', style: const pw.TextStyle(
                              fontSize: 18,

                            ))),
                          ]
                      )
                  ))
          ),
          pw.Expanded(

              child: pw.Container(
                  margin: const pw.EdgeInsets.only(left: 50, top: 30),
                  child: pw.Container(
                      height: 220,


                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Expanded(child: pw.Text('Billed to', style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 22,

                                color: PdfColors.greenAccent))),


                            pw.Expanded(child: pw.Text(invoice.billToName, style: const pw.TextStyle(
                              fontSize: 18,

                            ))),


                            pw.Expanded(child: pw.Text(invoice.billToOrganization, style: const pw.TextStyle(
                              fontSize: 18,

                            ))),






                            pw.Expanded(child: pw.Text('Address :  ${invoice.billToAddress} ', style: const pw.TextStyle(
                              fontSize: 18,

                            ))),


                            pw.Expanded(child: pw.Text('Phone : ${invoice.billToPhone}', style: const pw.TextStyle(
                              fontSize: 18,

                            ))),
                          ]
                      )


                  ))
          )
        ]
    );

  }










//    ==================      Table header  =================//

  static pw.Widget tableHeading (){

    return      pw.Container(
        color: PdfColors.greenAccent,
        height: 50,

        child:   pw.Row(
            children: [
              pw.Expanded(

                child: pw.Container(
                    alignment: pw.Alignment.center,
                    height: 50,

                    child: pw.Text('S.No', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold,color: PdfColors.white))

                ),

              ),


              //================================

              pw.Expanded(
                flex: 2,
                child: pw.Container(
                    height: 50,

                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text('Item Name', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold,color: PdfColors.white))

                ),
              ),


              //================================

              pw.Expanded(
                child: pw.Container(
                    height: 50,

                    alignment: pw.Alignment.center,
                    child: pw.Text('Quantity', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold,color: PdfColors.white))
                ),
              ),


              //================================

              pw.Expanded(
                child: pw.Container(
                    height: 50,

                    alignment: pw.Alignment.center,
                    child: pw.Text('item Price', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold,color: PdfColors.white))
                ),
              ),


              //================================

              pw.Expanded(
                child: pw.Container(
                    height: 50,

                    alignment: pw.Alignment.center,
                    child: pw.Text('Total Price', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold,color: PdfColors.white))
                ),
              ),


              //================================



            ]
        )

    );
  }












  //    ==================      Table data  =================//




  static pw.Widget  tableData ({required Map<String, dynamic> items, required PdfColor backgroundColor, required int serialNumber}){


   var name =  items['name'];
  var  quantity =  int.parse(items['quantity']);
  var  price =  int.parse(items['price']);

  var totalPrice = quantity * price;


    return      pw.Container(

      color: backgroundColor,
        height: 50,

        child:   pw.Row(
            children: [
              pw.Expanded(

                child: pw.Container(
                    alignment: pw.Alignment.center,
                    height: 50,

                    child: pw.Text(
                        "${serialNumber + 1}", style: const pw.TextStyle(fontSize: 18, ))

                ),

              ),


              //================================

              pw.Expanded(
                flex: 2,
                child: pw.Container(
                    height: 50,

                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(name, style: const pw.TextStyle(fontSize: 18, ))

                ),
              ),


              //================================

              pw.Expanded(
                child: pw.Container(
                    height: 50,

                    alignment: pw.Alignment.center,
                    child: pw.Text(quantity.toString(), style: const pw.TextStyle(fontSize: 18, ))
                ),
              ),


              //================================

              pw.Expanded(
                child: pw.Container(
                    height: 50,

                    alignment: pw.Alignment.center,
                    child: pw.Text(price.toString(), style: const pw.TextStyle(fontSize: 18, ))
                ),
              ),


              //================================

              pw.Expanded(
                child: pw.Container(
                    height: 50,

                    alignment: pw.Alignment.center,
                    child: pw.Text(totalPrice.toString(), style: const pw.TextStyle(fontSize: 18,))
                ),
              ),


              //================================



            ]
        )

    );
  }











  //    ==================     Terms and Conditions  =================//


  static pw.Widget termsAndConditions ({required Invoice invoice}){


    var totalPrice = SumFuntion.grandTotal();


    var discount = (totalPrice/100) * 15;


    var tax = (discount/100) * 15;

    var subTotal =  (totalPrice -  discount) - tax;

    return   pw.Container(
    margin: const pw.EdgeInsets.only(top: 40),
    height: 300,
    child: pw.Row(
    children: [

    pw.Expanded(child: pw.Container(
    child: pw.Column(
    children: [
    pw.Expanded(
    child:  pw.Container(


    margin: const pw.EdgeInsets.only(left: 50),
    width: double.infinity,


    // color: PdfColors.green,
    child: pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
    pw.Expanded(
  flex: 0,
  child: pw.Text('Description', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold))),
  pw.Expanded(child: pw.Container(

  margin: const pw.EdgeInsets.only(top: 20),
  child: pw.Text(invoice.description, style: const pw.TextStyle(fontSize: 18, color: PdfColors.grey))))

  ]
  )
  ),
  ),




  // ==============================



  pw.Expanded(
  child:  pw.Container(


  margin: const pw.EdgeInsets.only(left: 50),
  width: double.infinity,


  // color: PdfColors.green,
  child: pw.Column(
  crossAxisAlignment: pw.CrossAxisAlignment.start,
  children: [
  pw.Expanded(
  flex: 0,
  child: pw.Text('Terms And Conditions', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold))),
  pw.Expanded(child: pw.Container(

  margin: const pw.EdgeInsets.only(top: 20),
  child: pw.Text(Constants.termsAndConditions, style: const pw.TextStyle(fontSize: 18,color: PdfColors.grey))))

  ]
  )
  ),
  ),

  ]
  )



  )),


  //================ second expanded in row
  pw.Expanded(child: pw.Container(


  decoration: pw.BoxDecoration(
  color: PdfColors.grey100,
  border: pw.Border.all(width: 1, color: PdfColors.grey)
  ),
  margin: const pw.EdgeInsets.only(left: 30, right: 30),

  child: pw.Column(
  children: [
  pw.Expanded(child:  pw.Container(


  padding: const pw.EdgeInsets.only(left: 20),
  alignment: pw.Alignment.centerLeft,
  width: double.infinity,
  color: PdfColors.greenAccent,
  child: pw.Text('Total Summary', style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 18,color: PdfColors.white))



  )),


  // ==================
  pw.Expanded(child:  pw.Container(


  padding: const pw.EdgeInsets.only(left: 20),
  alignment: pw.Alignment.centerLeft,
  width: double.infinity,
  child: pw.Row(
  children: [
  pw.Expanded(child: pw.Text('Total (Exc Tax)', style: const pw.TextStyle(fontSize: 18,color: PdfColors.grey)),

  ),
  pw.Expanded(child: pw.Text(totalPrice.toString(), style: const pw.TextStyle(fontSize: 18,color: PdfColors.grey)
  )
  )




  ]
  )

  ),


  ),



  //==============================



  pw.Expanded(child:  pw.Container(


  padding: const pw.EdgeInsets.only(left: 20),
  alignment: pw.Alignment.centerLeft,
  width: double.infinity,
  child: pw.Row(
  children: [
  pw.Expanded(child: pw.Text('Discount', style: const pw.TextStyle(fontSize: 18,color: PdfColors.grey)),

  ),
  pw.Expanded(child: pw.Text(discount.toStringAsFixed(2), style: const pw.TextStyle(fontSize: 18,color: PdfColors.grey)
  )
  )




  ]
  )

  ),


  ),



  //==============================




  pw.Expanded(child:  pw.Container(


  padding: const pw.EdgeInsets.only(left: 20),
  alignment: pw.Alignment.centerLeft,
  width: double.infinity,
  child: pw.Row(
  children: [
  pw.Expanded(child: pw.Text('Tax', style: const pw.TextStyle(fontSize: 18,color: PdfColors.grey)),

  ),
  pw.Expanded(child: pw.Text(tax.toStringAsFixed(2), style: const pw.TextStyle(fontSize: 18,color: PdfColors.grey)
  )
  )




  ]
  )

  ),


  ),



  //==============================

  pw.Expanded(child:  pw.Container(


  padding: const pw.EdgeInsets.only(left: 20),
  alignment: pw.Alignment.centerLeft,
  width: double.infinity,
  child: pw.Row(
  children: [
  pw.Expanded(child: pw.Text('Sub Total (Inc Tax)', style: const pw.TextStyle(fontSize: 18,color: PdfColors.grey)),

  ),
  pw.Expanded(child: pw.Text(subTotal.toStringAsFixed(2), style: const pw.TextStyle(fontSize: 18, color: PdfColors.grey)
  )
  )




  ]
  )

  ),


  ),



  //==============================




  ]
  )




  )),

  ]
  )
  );
  }







  //    ==============  Signature  ======================//




 static pw.Widget signature ({required Uint8List signature}){


    return    pw.Container(
      margin: const pw.EdgeInsets.only(left: 100),
      width: 200,
      height: 100,
      child: pw.Image(pw.MemoryImage(signature)),

    );

 }









  //    ==============  bottom banner  ======================//


  static pw.Widget bottomBanner (){
    return pw.Container(

        width: double.infinity,
        height: 25,
        color: PdfColors.greenAccent
    );

 }







}
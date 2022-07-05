import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf_invoice/controller/cubit/check_box_cubit.dart';
import 'package:pdf_invoice/controller/cubit/list_cubit.dart';
import 'package:pdf_invoice/model/invoice.dart';
import 'package:pdf_invoice/widgets/my_expandable_widget.dart';
import 'package:pdf_invoice/widgets/my_text_fields.dart';
import 'package:pdf_invoice/widgets/no_validator_fields.dart';

import 'package:pdf_invoice/widgets/signature_pad.dart';
import 'package:signature/signature.dart';

import '../constants.dart';
import '../controller/my_pdf.dart';
import '../controller/sum_funtion.dart';

class DataInputScreen extends StatefulWidget {
  const DataInputScreen({Key? key}) : super(key: key);

  @override
  State<DataInputScreen> createState() => _DataInputScreenState();
}

class _DataInputScreenState extends State<DataInputScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController billByNameController = TextEditingController();
  TextEditingController billByOrganizationController = TextEditingController();
  TextEditingController billByAddressController = TextEditingController();
  TextEditingController billByPhoneController = TextEditingController();

  TextEditingController billToOrganizationController = TextEditingController();
  TextEditingController billToNameController = TextEditingController();
  TextEditingController billToAddressController = TextEditingController();
  TextEditingController billToPhoneController = TextEditingController();

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController termsAndConditionsController = TextEditingController();

  ScrollController scrollController = ScrollController();

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> list = [];

  List<Map<String, dynamic>> getListItems() {
    var items = [
      {
        "Name": itemNameController.text,
        "Quantity": itemQuantityController.text,
        "Price": itemPriceController.text,
      }
    ];

    return items;
  }

  Invoice getInvoice() {
    Invoice invoice = Invoice(
        items: list,
        termsAndConditions: termsAndConditionsController.text,
        invoiceDate: dateController.text,
        billByOrganization: billByOrganizationController.text,
        billByName: billByNameController.text,
        billByAddress: billByAddressController.text,
        billByPhone: billByPhoneController.text,
        billToOrganization: billToOrganizationController.text,
        billToName: billToNameController.text,
        billToAddress: billToAddressController.text,
        billToPhone: billToPhoneController.text,
        itemName: itemNameController.text,
        itemQuantity: itemQuantityController.text,
        itemPrice: itemPriceController.text,
        description: descriptionController.text);

    return invoice;
  }

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  @override
  void initState() {
    super.initState();
    // _controller.addListener(() => debugPrint('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListCubit(0),
        ),
        BlocProvider(
          create: (context) => CheckBoxCubit(false),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Invoice Generator'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(right: 6.sp),
            child: Scrollbar(
              radius: Radius.circular(20.sp),
              thumbVisibility: true,
              controller: scrollController,
              thickness: 8,
              interactive: true,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                padding: EdgeInsets.only(left: 15.sp, right: 9.sp),
                children: [
                  MyExpandableCard(
                      isExpand: true,
                      cardTitle: 'Billed By',
                      children: [
                        myDivider(),
                        MyTextFields(
                            inputType: TextInputType.text,
                            controller: billByOrganizationController,
                            label: 'Organization',
                            hint: 'Organization'),
                        MyTextFields(
                            inputType: TextInputType.text,
                            controller: billByNameController,
                            label: 'Your Name',
                            hint: 'Your Name'),
                        MyTextFields(
                            inputType: TextInputType.text,
                            controller: billByAddressController,
                            label: 'Address',
                            hint: 'Address'),
                        MyTextFields(
                            inputType: TextInputType.number,
                            controller: billByPhoneController,
                            label: 'Phone',
                            hint: 'Phone'),
                      ]),
                  //  ============= Billed to information ===========//////

                  MyExpandableCard(
                      isExpand: false,
                      cardTitle: 'Billed To',
                      children: [

                        myDivider(),


                        MyTextFields(
                            inputType: TextInputType.text,
                            controller: billToOrganizationController,
                            label: 'Organization',
                            hint: 'Organization'),

                        MyTextFields(
                            inputType: TextInputType.text,
                            controller: billToNameController,
                            label: 'Name',
                            hint: 'Name'),
                        MyTextFields(
                            inputType: TextInputType.text,
                            controller: billToAddressController,
                            label: 'Address',
                            hint: 'Address'),
                        MyTextFields(
                            inputType: TextInputType.number,
                            controller: billToPhoneController,
                            label: 'Phone',
                            hint: 'Phone'),
                        // MyTextFields(controller: dateController, label: 'Invoice date', hint: 'Invoice date'),
                      ]),

                  //  ============= item  information ===========//////

                  MyExpandableCard(
                      isExpand: false,
                      cardTitle: 'Items',
                      children: [
                        myDivider(),


                        NoValidatorFields(
                            inputType: TextInputType.text,
                            controller: itemNameController,
                            label: 'Name',
                            hint: 'Name'),
                        NoValidatorFields(
                            inputType: TextInputType.number,
                            controller: itemQuantityController,
                            label: 'Quantity',
                            hint: 'Quantity'),
                        NoValidatorFields(
                            inputType: TextInputType.number,
                            controller: itemPriceController,
                            label: 'Price',
                            hint: 'Price'),
                        // MyTextFields(controller: dateController, label: 'Invoice date', hint: 'Invoice date'),

                        Container(
                          margin: EdgeInsets.only(
                              left: 15.sp, right: 15.sp, top: 15.sp),
                          child: BlocBuilder<ListCubit, int>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '$state' + ' Items added',
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.red),
                                  )),
                                  ElevatedButton(
                                      onPressed: () {
                                        list.add({
                                          'name': itemNameController.text,
                                          'price': itemPriceController.text,
                                          'quantity':
                                              itemQuantityController.text,
                                        });

                                        var quantity =
                                            int.parse(itemPriceController.text);

                                        var price = int.parse(
                                            itemQuantityController.text);
                                        var totalPrice = quantity * price;

                                        debugPrint('==========');
                                        debugPrint(totalPrice.toString());

                                        SumFuntion.total.add(totalPrice);
                                        context.read<ListCubit>().getList(
                                            index: SumFuntion.total.length);

                                        debugPrint(SumFuntion.total.toString());

                                        itemNameController.clear();
                                        itemPriceController.clear();
                                        itemQuantityController.clear();
                                      },
                                      child: const Text('Add item')),
                                ],
                              );
                            },
                          ),
                        )
                      ]),

                  //  ============= Description  ===========//////

                  MyExpandableCard(
                      isExpand: false,
                      cardTitle: 'Description',
                      children: [
                        myDivider(),

                        MyTextFields(
                            inputType: TextInputType.text,
                            controller: descriptionController,
                            label: 'Description',
                            hint: 'Description'),
                      ]),

                  //  ============= Terms and Condition  ===========//////

                  MyExpandableCard(
                      isExpand: false,
                      cardTitle: 'Terms And Conditions ',
                      children: [
                        myDivider(),

                        Container(
                            margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                            child: Text(
                              Constants.termsAndConditions,
                              style: const TextStyle(color: Colors.orange),
                            )),
                        BlocBuilder<CheckBoxCubit, bool>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Checkbox(
                                      value: state,
                                      onChanged: (value) {
                                        context
                                            .read<CheckBoxCubit>()
                                            .getStatus(status: !state);
                                      }),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      'I Accept the Terms and Conditions',
                                      style: TextStyle(fontSize: 14.sp),
                                    )),
                              ],
                            );
                          },
                        ),
                        // MyTextFields(controller: termsAndConditionsController,
                        //     label: 'Terms and Conditions',
                        //     hint: 'Terms and Conditions '),
                      ]),

                  SizedBox(
                    height: 30.sp,
                  ),

                  SignaturePad(
                    controller: _controller,
                    clearFuntion: () {
                      _controller.clear();
                    },
                  ),

                  BlocBuilder<CheckBoxCubit, bool>(
                    builder: (context, state) {
                      var myState = context.read<CheckBoxCubit>().state;
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(20.sp, 45.sp)),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var signature = await _controller.toPngBytes();

                            if (signature == null || signature.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'please provide signature');

                              return;
                            } else {
                              if (myState == false) {
                                Fluttertoast.showToast(
                                    msg:
                                        'Please check the terms and condition');

                                return;
                              } else {
                                if (list.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Please add At least one Item');
                                } else {
                                  final pdf = await MyPdf.generateNewPdf(
                                      invoice: getInvoice(),
                                      signature: signature!);

                                  MyPdf.openMyFile(pdf);
                                }
                              }
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please Complete the from');
                          }

                          debugPrint('=============');
                          //print(pdf.path);

                          debugPrint('================');
                        },
                        child: Text(
                          'Generate PDF',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      );
                    },
                  ),

                  //              // ======      Dates fields =============//
                  //
                  //            Container(
                  //              margin: EdgeInsets.only(top: 20.sp),
                  //              color: Colors.greenAccent,
                  //              child: ExpansionTile(
                  //
                  //
                  //                initiallyExpanded: true,
                  //                title: Text('Dates', style: TextStyle(fontSize: 22.sp),),
                  //              children: [
                  //                Divider(color: Colors.white, height: 2.sp,),
                  //                MyTextFields(controller: dateController, label: 'Invoice date', hint: 'Invoice date'),
                  //
                  //                 ],
                  //
                  //              ),

                  //    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




Widget myDivider(){
  return Container(
    margin: EdgeInsets.only( bottom: 9.sp),
    child: Divider(
      color: Colors.black,
      height: 2.sp,
    ),
  );
}


class Invoice{

  late String invoiceDate;

  late String billByOrganization;
  late String billByName;
  late String billByAddress;
  late String billByPhone;

  late String billToOrganization;
  late String billToName;
  late String billToAddress;
  late String billToPhone;

  late List <Map<String, dynamic>> items;
  late String itemName;
  late String itemQuantity;
  late String itemPrice;

  late String description;

  late String termsAndConditions;

  Invoice({

    required this.invoiceDate,
    required this.billByOrganization,
    required this.billByName,
    required this.billByAddress,
    required this.billByPhone,
    required this.billToOrganization,
    required this.billToName,
    required this.billToAddress,
    required this.billToPhone,
    required this.items,
    required this.itemName,
    required this.itemQuantity,
    required this.itemPrice,
    required this.description,
    required this.termsAndConditions,

      });
}
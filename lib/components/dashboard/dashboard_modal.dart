import 'package:flutter/material.dart';

class DashboardUIModal {
  List<ProductsModal> productList = List<ProductsModal>.empty(growable: true);
  bool? isFirstTime = true;
  bool isListView = true;
  bool isAwaiting = false;
}

class ProductsModal {
  int? id;
  TextEditingController name = TextEditingController(text: "");
  DateTime? launchDate;
  TextEditingController webSite = TextEditingController(text: "");
  double rating = 0.0;
  dynamic logo;

  ProductsModal({this.id, required this.name, this.launchDate, required this.webSite, this.rating = 0.0, this.logo});

  ProductsModal.clone(ProductsModal modal) {
    id = modal.id;
    name = TextEditingController(text: modal.name.text);
    webSite = TextEditingController(text: modal.webSite.text);
    launchDate = modal.launchDate;
    rating = modal.rating;
    logo = modal.logo;
  }

  factory ProductsModal.parseResponse(dynamic data) {
    return ProductsModal(
        name: TextEditingController(text: data["NAME"]),
        webSite: TextEditingController(text: data["WEB_SITE"]),
        id: data["ID"],
        launchDate: DateTime.parse(data["DATE"]),
        logo: data["LOGO"],
        rating: data["RATING"]);
  }

  Map<String, dynamic> getMap() => {"ID": id, "NAME": name.text, "DATE": launchDate.toString(), "WEB_SITE": webSite.text, "RATING": rating, "LOGO": logo};
}

class AddEditProductArguments {
  String title;
  bool? isAdd;
  List<ProductsModal> productsList = List<ProductsModal>.empty(growable: true);
  ProductsModal? addEditProduct;

  AddEditProductArguments(this.title, this.productsList, this.addEditProduct, {this.isAdd});
}

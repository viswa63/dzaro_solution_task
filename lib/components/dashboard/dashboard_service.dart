import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:products/components/dashboard/dashboard_modal.dart';
import 'package:products/util/constants/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  DashboardUIModal modal = DashboardUIModal();

  // Future<bool> getArguments(BuildContext context, DashboardUIModal mdl) async {
  //   final args = ModalRoute.of(context)!.settings.arguments;
  //   try {
  //     if (args != null) {
  //       AddEditProductArguments arguments = args as AddEditProductArguments;

  //       if (arguments.title == StringConstants.addProductTitle) {
  //         mdl.productList.add(arguments.addEditProduct!);
  //       } else {
  //         ProductsModal editedModal = arguments.addEditProduct!;
  //         mdl.productList.removeWhere((element) => element.id == editedModal.id);
  //         mdl.productList.add(getCloneData(arguments.addEditProduct!));
  //       }
  //       print("mdl.productList is ${mdl.productList.length}");
  //       await saveProductsList(mdl.productList);
  //       mdl.isFirstTime = null;
  //       return true;
  //     } else {
  //       mdl.isFirstTime = null;
  //       return false;
  //     }
  //   } catch (e) {
  //     mdl.isFirstTime = null;
  //     return false;
  //   }
  // }

  List<ProductsModal> dummyList() {
    return [
      // ProductsModal(
      //     name: TextEditingController(text: "AstraGen"), launchDate: DateTime(2013), webSite: TextEditingController(text: "www.astragen.in"), rating: 4.2),
      ProductsModal(name: TextEditingController(text: "TCS"), launchDate: DateTime(2013), webSite: TextEditingController(text: "www.astragen.in"), rating: 0.5),
      ProductsModal(
          name: TextEditingController(text: "Wipro"), launchDate: DateTime(2013), webSite: TextEditingController(text: "www.astragen.in"), rating: 1.0),
      ProductsModal(
          name: TextEditingController(text: "Asscentire"), launchDate: DateTime(2013), webSite: TextEditingController(text: "www.astragen.in"), rating: 1.5),
      ProductsModal(
          name: TextEditingController(text: "Infosic"), launchDate: DateTime(2013), webSite: TextEditingController(text: "www.astragen.in"), rating: 2.0),
      ProductsModal(name: TextEditingController(text: "TCS"), launchDate: DateTime(2013), webSite: TextEditingController(text: "www.astragen.in"), rating: 2.5),
    ];
  }

  ProductsModal getCloneData(ProductsModal modal) {
    return ProductsModal.clone(modal);
  }

  Future<void> saveProductsList(List<ProductsModal> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("products", jsonEncode(list.map((e) => e.getMap()).toList()));
  }

  Future<List<ProductsModal>> loadProductsList() async {
    List<ProductsModal> list = List<ProductsModal>.empty(growable: true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<dynamic> tempList = jsonDecode(prefs.getString("products") ?? "[]");

    list = tempList.map((e) => ProductsModal.parseResponse(e)).toList();
    // print(list.map((e) => e.getMap()).toList());
    return list;
  }
}

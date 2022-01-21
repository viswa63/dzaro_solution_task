import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:products/components/dashboard/dashboard_service.dart';
import 'package:products/components/dashboard/helper_widgets/product_rating.dart';
import 'package:products/util/constants/route_constants.dart';
import 'package:products/util/constants/string_constants.dart';
import 'package:products/util/ui/atl_alert_dialog.dart';
import 'package:products/util/ui/atl_avatar.dart';
import 'package:products/util/ui/atl_text.dart';

import 'dashboard_modal.dart';

class DashboardUI extends StatefulWidget {
  const DashboardUI({Key? key}) : super(key: key);

  @override
  _DashboardUIState createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  final DashboardService _service = DashboardService();

  @override
  void initState() {
    _service.modal.productList.add(ProductsModal(name: "AstraGen", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 4.2));
    _service.modal.productList.add(ProductsModal(name: "TCS", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 0.5));
    _service.modal.productList.add(ProductsModal(name: "Wipro", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 1.0));
    _service.modal.productList.add(ProductsModal(name: "Asscentire", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 1.5));
    _service.modal.productList.add(ProductsModal(name: "Infosic", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 2.0));
    _service.modal.productList.add(ProductsModal(name: "TCS", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 2.5));
    _service.modal.productList.add(ProductsModal(name: "TCS", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 3.0));
    _service.modal.productList.add(ProductsModal(name: "TCS", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 3.5));
    _service.modal.productList.add(ProductsModal(name: "TCS", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 4.0));
    _service.modal.productList.add(ProductsModal(name: "TCS", launchDate: DateTime(2013), webSite: "www.astragen.in", rating: 5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool response = false;
        await ATLAlertDialog.getYesOrNoAlertDialog(context, "LogOut", "Do you want to LogOut?", "Yes", "No", (resp) => response = resp);
        return response;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const ATLText(txt: "Dashboard"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(_service.modal.productList.length, (index) => productCard(_service.modal.productList.elementAt(index))),
          ),
        ),
        floatingActionButton: floatingActionBtn(),
      ),
    );
  }

  Widget productCard(ProductsModal product) {
    return Card(
      child: ListTile(
        leading: getProductLogo(product.logo, product.name),
        title: ATLText(
          txt: product.name,
          fontSize: 18,
        ),
        subtitle: ProductRating(
          rating: product.rating,
        ),
        trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
      ),
    );
  }

  Widget getProductLogo(dynamic image, String name) {
    if (image == null) {
      return ATLAvatar(
        avtrType: "TEXT",
        avtrTxt: name.substring(0, 1),
        textFontSize: 25,
      );
    } else {
      return ATLAvatar(
        avtrType: "TEXT",
        avtrTxt: name.substring(0, 1),
        textFontSize: 25,
      );
    }
  }

  FloatingActionButton floatingActionBtn() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.addProduct, arguments: AddEditProductArguments(StringConstants.addProductTitle, _service.modal.productList, null));
      },
      child: const Icon(Icons.add),
    );
  }
}

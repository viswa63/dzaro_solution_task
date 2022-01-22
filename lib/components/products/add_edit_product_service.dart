import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products/components/dashboard/dashboard_modal.dart';
import 'package:products/util/constants/route_constants.dart';
import 'package:products/util/constants/string_constants.dart';
import 'package:products/util/service/common_service.dart';
import 'package:products/util/ui/atl_text.dart';

import 'add_edit_product_modal.dart';

class AddEditProductService {
  AddEditProductUIModal modal = AddEditProductUIModal();

  bool isFieldEmpty(BuildContext context, ProductsModal product, List<ProductsModal> productsList) {
    bool validation = true;
    if (product.name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Please enter product name")));
    } else if (product.launchDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Please select product launch date")));
    } else if (product.webSite.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Please enter product URL")));
    } else if (!CommonService.isTextIsLink(product.webSite.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Please enter valid URL")));
    } else if (product.rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Please select rating of product")));
    } else if (isProductAlreadyPresent(productsList, product)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: ATLText(txt: "${product.name.text} is already present")));
    } else {
      validation = false;
    }
    return validation;
  }

  bool isProductAlreadyPresent(List<ProductsModal> products, ProductsModal product) {
    if (products.map((e) => e.name.text.toUpperCase()).toList().contains(product.name.text.toUpperCase())) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getArguments(BuildContext context, AddEditProductUIModal mdl) async {
    final args = ModalRoute.of(context)!.settings.arguments;
    try {
      if (args != null) {
        AddEditProductArguments arguments = args as AddEditProductArguments;

        if (arguments.title == StringConstants.addProductTitle) {
          mdl.addEditProduct = ProductsModal(name: TextEditingController(text: ""), webSite: TextEditingController(text: ""), rating: 0.0);
        } else {
          mdl.addEditProduct = ProductsModal.clone(arguments.addEditProduct!);
        }

        mdl.actualProducts = arguments.productsList.map((e) => ProductsModal.clone(e)).toList();
        mdl.appBarTitle = arguments.title;

        mdl.isFirstTime = null;
        return true;
      } else {
        Timer(const Duration(microseconds: 0), () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Missing Arguments.")));
          Navigator.pushNamed(context, Routes.dashboard);
        });
        mdl.isFirstTime = null;
        return false;
      }
    } catch (e) {
      Timer(const Duration(microseconds: 0), () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Something went wrong in Route Navigation.")));
        Navigator.pushNamed(context, Routes.dashboard);
      });
      mdl.isFirstTime = null;
      return false;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:products/components/dashboard/dashboard_ui.dart';
import 'package:products/components/products/add_edit_product_ui.dart';

class Routes {
  static const String index = "/";
  static const String dashboard = "/dashboard";
  static const String addEditProduct = "/add-edit-product";
  static const String editProduct = "/edit-product";

  static Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    index: (context) => const DashboardUI(),
    dashboard: (context) => const DashboardUI(),
    addEditProduct: (context) => const AddEditProductUI(),
  };
}

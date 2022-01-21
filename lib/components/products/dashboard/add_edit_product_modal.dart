import 'package:products/components/dashboard/dashboard_modal.dart';

class AddEditProductUIModal {
  List<ProductsModal> actualProducts = List<ProductsModal>.empty(growable: true);
  ProductsModal? addEditProduct;
  String? appBarTitle;
  bool isFirstTime = true;
}

class DashboardUIModal {
  List<ProductsModal> productList = List<ProductsModal>.empty(growable: true);
}

class ProductsModal {
  int? id;
  String name;
  DateTime? launchDate;
  String webSite;
  double rating;
  dynamic logo;

  ProductsModal({this.id, required this.name, this.launchDate, required this.webSite, required this.rating, this.logo});
}

class AddEditProductArguments {
  String title;
  List<ProductsModal> productsList = List<ProductsModal>.empty(growable: true);
  ProductsModal? addEditProduct;

  AddEditProductArguments(this.title, this.productsList, addEditProduct);
}

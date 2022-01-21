import 'package:flutter/material.dart';
import 'package:products/util/constants/string_constants.dart';
import '/components/dashboard/dashboard_modal.dart';
import '/util/constants/route_constants.dart';
import '/components/products/dashboard/add_edit_product_service.dart';
import '/util/ui/atl_text.dart';

class AddEditProductUI extends StatefulWidget {
  const AddEditProductUI({Key? key}) : super(key: key);

  @override
  _AddEditProductUIState createState() => _AddEditProductUIState();
}

class _AddEditProductUIState extends State<AddEditProductUI> {
  final AddEditProductService _service = AddEditProductService();

  @override
  Widget build(BuildContext context) {
    if (_service.modal.isFirstTime) {
      getArguments();
    }
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ATLText(txt: _service.modal.appBarTitle ?? StringConstants.addProductTitle),
        ),
        body: (_service.modal.appBarTitle == StringConstants.addProductTitle) ? addProduct() : editProduct(),
      ),
    );
  }

  Container addProduct() {
    print("Add");
    return Container(
      child: Column(
        children: [
          textField(_service.modal.addEditProduct?.name ?? ""),
          const SizedBox(height: 20),
          textField(_service.modal.addEditProduct?.webSite ?? ""),
          const SizedBox(height: 20),
          textField(_service.modal.addEditProduct?.logo ?? ""),
          const SizedBox(height: 20),
          textField(_service.modal.addEditProduct?.launchDate.toString() ?? ""),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Container editProduct() {
    print("Edit");

    return Container();
  }

  void getArguments() {
    final AddEditProductArguments? args = ModalRoute.of(context)!.settings.arguments as AddEditProductArguments;
    try {
      if (args != null) {
        _service.modal.addEditProduct = args.addEditProduct;
        _service.modal.actualProducts = args.productsList;
        _service.modal.appBarTitle = args.title;
        _service.modal.isFirstTime = false;
        if (!mounted) return;
        setState(() {});
      }
    } catch (e) {
      Navigator.pushNamed(context, Routes.dashboard);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Something went wrong in Route Navigation.")));
    }
  }

  Widget textField(String text) {
    return TextField(
      controller: TextEditingController(text: text),
      onChanged: (txt) {},
    );
  }
}

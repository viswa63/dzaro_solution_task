import 'package:flutter/material.dart';
import '/components/dashboard/dashboard_service.dart';
import '/util/constants/route_constants.dart';
import '/util/constants/string_constants.dart';
import '/util/ui/atl_alert_dialog.dart';
import '/util/ui/atl_avatar.dart';
import '../../util/ui/atl_date_time.dart';
import '/util/ui/atl_text.dart';

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
    loadProducts();

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
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                addProductResponse();
              },
              icon: const Icon(Icons.add),
            ),
            const SizedBox(width: 5)
          ],
        ),
        body: (_service.modal.productList.isEmpty)
            ? const Center(
                child: ATLText(txt: "No Products."),
              )
            : body(),
        floatingActionButton: (MediaQuery.of(context).size.width >= 800) ? floatingActionBtn() : Container(),
      ),
    );
  }

  Widget body() {
    if (_service.modal.isListView) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: List.generate(_service.modal.productList.length, (index) => productCard(_service.modal.productList.elementAt(index))),
          ),
        ],
      );
    } else {
      return Container(
        alignment: Alignment.topCenter,
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 5,
          runSpacing: 5,
          direction: Axis.horizontal,

          children:
              // [
              //   Row(
              //     children:
              List.generate(_service.modal.productList.length, (index) => productCard(_service.modal.productList.elementAt(index))),
          //   )
          // ],
        ),
      );
      // return GridView.count(
      //   crossAxisCount: 3,
      //   crossAxisSpacing: 4.0,
      //   mainAxisSpacing: 8.0,
      //   children: List.generate(_service.modal.productList.length, (index) => productCard(_service.modal.productList.elementAt(index))),
      // );
    }
  }

  Widget productCard(ProductsModal product) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width >= 800) ? 790 : MediaQuery.of(context).size.width - 5,
      child: Card(
        child: ListTile(
          leading: getProductLogo(product.logo, product.name.text),
          title: ATLText(
            txt: product.name.text,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          subtitle: Row(
            children: [
              ATLText(
                txt: (product.rating.toStringAsFixed(1)),
                color: Colors.black,
              ),
              Icon(
                Icons.star,
                size: 20,
                color: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
              const SizedBox(width: 20),
              ATLText(
                txt: ATLDateTimeFormat.getConvertedDate("dmy", product.launchDate!) ?? "NA",
                color: Colors.black,
              ),
              const SizedBox(width: 5),
              const Icon(Icons.date_range),
            ],
          ),
          trailing: SizedBox(
            width: 100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          updateProductResponse(product);
                        },
                        splashRadius: 5,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        )),
                    IconButton(
                        onPressed: () async {
                          ATLAlertDialog.getYesOrNoAlertDialog(context, "Delete ${product.name.text}", "Do you really want to delete", "Yes", "No", (resp) {
                            if (resp) {
                              _service.modal.productList.removeWhere((e) => e.name.text == product.name.text);
                              if (!mounted) return;
                              setState(() {});
                              _service.saveProductsList(_service.modal.productList);
                            }
                          });
                        },
                        splashRadius: 5,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
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

  Row floatingActionBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            _service.modal.isListView = true;
            if (!mounted) return;
            setState(() {});
          },
          heroTag: const Key("List"),
          child: const Icon(Icons.view_list),
          backgroundColor: (_service.modal.isListView) ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.2),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          onPressed: () {
            _service.modal.isListView = false;
            if (!mounted) return;
            setState(() {});
          },
          heroTag: const Key("Grid"),
          child: const Icon(Icons.window),
          backgroundColor: (!_service.modal.isListView) ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ],
    );
  }

  void loadProducts() async {
    // bool isArgumentsPresent = await _service.getArguments(context, _service.modal);
    // if (isArgumentsPresent) {
    //   if (!mounted) return;
    //   setState(() {});
    // }

    _service.modal.productList = await _service.loadProductsList();
    _service.modal.isAwaiting = false;

    if (!mounted) return;
    setState(() {});
  }

  void addProductResponse() async {
    final resp = await Navigator.pushNamed(context, Routes.addEditProduct,
        arguments: AddEditProductArguments(StringConstants.addProductTitle, _service.modal.productList, null));
    _service.modal.isAwaiting = true;
    setState(() {});
    if (resp != null) {
      AddEditProductArguments arguments = resp as AddEditProductArguments;
      if (arguments.isAdd ?? false) {
        _service.modal.productList.add(arguments.addEditProduct!);
      }
      await _service.saveProductsList(_service.modal.productList);
      _service.modal.isAwaiting = false;

      if (!mounted) return;
      setState(() {});
    }
  }

  void updateProductResponse(ProductsModal product) async {
    List<ProductsModal> list = [];
    list.addAll(_service.modal.productList.map((e) => _service.getCloneData(e)).toList());
    list.removeWhere((element) => element.id == product.id);
    final resp = await Navigator.pushNamed(context, Routes.addEditProduct, arguments: AddEditProductArguments(StringConstants.editProductTitle, list, product));

    _service.modal.isAwaiting = true;
    setState(() {});
    if (resp != null) {
      AddEditProductArguments arguments = resp as AddEditProductArguments;
      if (!(resp.isAdd ?? false)) {
        ProductsModal editedModal = arguments.addEditProduct!;
        _service.modal.productList.removeWhere((element) => element.id == editedModal.id);
        _service.modal.productList.add(_service.getCloneData(arguments.addEditProduct!));
      }
      await _service.saveProductsList(_service.modal.productList);
      _service.modal.isAwaiting = false;

      if (!mounted) return;
      setState(() {});
    }
  }
}

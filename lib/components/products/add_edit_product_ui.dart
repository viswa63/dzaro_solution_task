import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import '/components/dashboard/helper_widgets/product_rating.dart';
import '/util/constants/string_constants.dart';
import '/util/service/common_service.dart';
import '/util/ui/atl_button.dart';
import '../../util/ui/atl_date_time.dart';
import '/components/dashboard/dashboard_modal.dart';
import '/util/constants/route_constants.dart';
import 'add_edit_product_service.dart';
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
    if (_service.modal.isFirstTime ?? false) {
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
        body: Padding(padding: const EdgeInsets.all(5.0), child: (addEditProduct())),
      ),
    );
  }

  Row addEditProduct() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.topCenter,
          width: (MediaQuery.of(context).size.width >= 620)
              ? 600
              : MediaQuery.of(context).size.width - 10, // (constraints.maxWidth >= 610) ? 600 : constraints.maxWidth,
          child: Card(
            elevation: 3,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(child: textField(_service.modal.addEditProduct?.name, "Product Name")),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(child: pickerButton())
                    ],
                  ),
                  const SizedBox(height: 20),
                  textField(_service.modal.addEditProduct?.webSite, "Web Site URL"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const ATLText(txt: "Add Rating : "),
                      const SizedBox(
                        width: 20,
                      ),
                      ProductRating(
                        rating: _service.modal.addEditProduct?.rating ?? 0,
                        starCount: 5,
                        onChange: (rating) {
                          _service.modal.addEditProduct?.rating = rating;
                          if (!mounted) return;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ATLButton(
                    btnText: (_service.modal.appBarTitle == StringConstants.addProductTitle) ? StringConstants.btnAdd : StringConstants.btnUpdate,
                    onPressed: () {
                      bool areFiledsEmpty = _service.isFieldEmpty(context, _service.modal.addEditProduct!, _service.modal.actualProducts);
                      if (!areFiledsEmpty) {
                        if (_service.modal.appBarTitle == StringConstants.addProductTitle) {
                          List<int> ids = _service.modal.actualProducts.map((e) => e.id ?? 0).toList();
                          int id = (ids.isNotEmpty) ? ids.reduce(max) : 0;
                          _service.modal.addEditProduct?.id = id + 1;

                          Navigator.of(context).pop(AddEditProductArguments("ADD", _service.modal.actualProducts, _service.modal.addEditProduct, isAdd: true));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Product added successfully")));
                        } else {
                          Navigator.of(context).pop(AddEditProductArguments("ADD", _service.modal.actualProducts, _service.modal.addEditProduct, isAdd: false));

                          // Navigator.pushNamed(context, Routes.dashboard,
                          //     arguments: AddEditProductArguments("", _service.modal.actualProducts, _service.modal.addEditProduct!));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: ATLText(txt: "Product updated successfully")));
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textField(TextEditingController? text, String hintText) {
    return TextField(
      controller: text,
      decoration: InputDecoration(hintText: hintText, labelText: hintText),
      onChanged: (txt) {},
    );
  }

  Widget pickerButton() {
    return Card(
      elevation: 0,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            DateTime? date =
                await CommonService.getDateFromDatePicker(context, DateTime.now(), DateTime(2020), DateTime(DateTime.now().year + 5), "Select Launch Date");
            if (date != null) {
              _service.modal.addEditProduct!.launchDate = date;
              if (!mounted) return;
              setState(() {});
            }
          },
          child: Stack(children: [
            Container(
              // margin: (widget.title != null) ? EdgeInsets.all(AgButtonConstants.margin) : null,
              height: 40,
              // decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(5)),
              margin: (_service.modal.addEditProduct?.launchDate != null) ? const EdgeInsets.all(3.0) : null,
              decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Center(
                          child: ATLText(
                              txt: (_service.modal.addEditProduct?.launchDate == null)
                                  ? "Launch Date"
                                  : ATLDateTimeFormat.getConvertedDate("dmy", _service.modal.addEditProduct?.launchDate)!))),
                  SizedBox(
                    width: 30,
                    child: Icon(
                      Icons.date_range,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            if (_service.modal.addEditProduct?.launchDate != null)
              Positioned(
                  top: -5,
                  left: 10,
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const ATLText(txt: "Launch Date"))),
          ]),
        ),
      ),
    );
  }

  void getArguments() async {
    bool isArgumentsPresent = await _service.getArguments(context, _service.modal);
    if (isArgumentsPresent) {
      if (!mounted) return;
      setState(() {});
    }
  }
}

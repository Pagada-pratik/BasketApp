import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mybasket247/controllers/compare/compare_products_controller.dart';

import '../../../utils/ars_progress_dialog.dart';
import '../../../utils/custom_loading.dart';
import '../../models/products_model.dart';

class CompareProductsView extends StatefulWidget {
  final int productId;
  const CompareProductsView({super.key, required int this.productId});

  @override
  State<CompareProductsView> createState() => _CompareProductsViewState();
}

class _CompareProductsViewState extends State<CompareProductsView> {
  CompareProductsController compareProductsController = Get.put(CompareProductsController());

  final List<String> attributeList = [
    'Sku',
    'Availability',
    'Weight',
    'Dimensions',
    'Color',
    'UWCF Colors',
    'UWCF Sizes',
    'hard-drive',
    'processor-model',
    'ram',
    'resolution',
    'screen-size',
    'size',
    'sound-stype',
    'wireless',
    'Side',
    'Brand',
    'Price',
  ];


  @override
  void initState() {
    super.initState();
    compareProductsController.productIDs.add(widget.productId.toString());
    compareProductsController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await compareProductsController.getCompareProductsApiResponse(
          context, compareProductsController.productID.toString());
      compareProductsController.isDataSuccess.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/Arrow - Left.svg",
            height: 26,
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.bodyLarge!.color!,
              BlendMode.srcIn,
            ),
          ),
        ),
        title: const Text("Compare Products"),
      ),

      body: Obx(() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: const FixedColumnWidth(120), // Attribute name column
              for (int i = 0; i < compareProductsController.products.length; i++) i + 1: const FixedColumnWidth(180),
            },
            children: [
              // Remove Buttons Row
              TableRow(
                children: [
                  const SizedBox(), // Empty top-left cell
                  // ...compareProductsController.products.map((_) => _buildRemoveButton()).toList(),
                  ...compareProductsController.products
                      .asMap()
                      .entries
                      .map((entry) => _buildRemoveButton(() {
                    compareProductsController.productIDs.remove(entry.value.id.toString());
                    compareProductsController.products.removeAt(entry.key);
                    if(compareProductsController.productIDs.isEmpty){
                      Navigator.pop(context);
                    }
                  })).toList(),
                ],
              ),
              // Product Image & Title Header
              TableRow(
                children: [
                  _buildDescriptionLabelCell("Description"),
                  ...compareProductsController.products.map((product) => _buildProductHeader(product)).toList(),
                ],
              ),
              // Dynamic attribute rows
              for (var attr in attributeList)
                TableRow(
                  children: [
                    _buildLabelCell(attr),
                    ...compareProductsController.products.map((product) => _buildValueCell(attr, product)).toList(),
                  ],
                ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildRemoveButton(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            'Remove',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }


  Widget _buildDescriptionLabelCell(String label) {
    return Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.all(14),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  /*Widget _buildProductHeader(ProductsModel product) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            color: Colors.grey.shade300,
            child: (product.images.first?.isEmpty ?? true)
                ? const Icon(Icons.image_not_supported)
                : Image.network(product.image!),
          ),
          const SizedBox(height: 8),
          Text(
            product.name ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            product.price ?? '',
            style: const TextStyle(
                color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          if (product.price != null && product.price!.isNotEmpty)
            Text(
              product.price!,
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
        ],
      ),
    );
  }*/

  Widget _buildProductHeader(ProductsModel product) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            color: Colors.grey.shade300,
            child: product.images.isEmpty
                ? const Icon(Icons.image_not_supported)
                // : Image.network(product.images[0].src),
                : Image.network(product.images.first.src),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
              product.price.isEmpty ? "€0.00" :"€${product.price}",
            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  Widget _buildLabelCell(String label) {
    return Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.all(14),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  /*Widget _buildValueCell(String attr, ProductsModel product) {
    var value = '';
    Color? valueColor;

    switch (attr) {
      case 'Sku':
        value = product.sku ?? '';
        break;
      case 'Availability':
        value = product.availability ?? '';
        valueColor = (product.availability?.toLowerCase().contains('in stock') ?? false)
            ? Colors.green
            : Colors.red;
        break;
      case 'Price':
        value = product.price ?? '';
        break;
      default:
        value = product.attributes?[attr.toLowerCase()] ?? '-';
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        value,
        style: TextStyle(
          color: valueColor ?? Colors.black,
        ),
      ),
    );
  }*/

  Widget _buildValueCell(String attr, ProductsModel product) {
    String value = '';
    Color? valueColor;

    switch (attr) {
      case 'Sku':
        value = product.sku;
        break;
      case 'Availability':
        value = product.stockStatus.toLowerCase() == 'instock' ? 'In stock' : 'Out of stock';
        valueColor = product.stockStatus.toLowerCase() == 'instock' ? Colors.green : Colors.red;
        break;
      case 'Weight':
        value = product.weight.isEmpty ? '-' : "${product.weight} kg";
        break;
      case 'Dimensions':
        // value = "${product.dimensions.length} x ${product.dimensions.width} x ${product.dimensions.height}";
        value = "N/A";
        break;
      case 'Color':
        value = "";
        break;
      case 'UWCF Colors':
        value = "";
        break;
      case 'UWCF Sizes':
        value = "";
        break;
      case 'hard-drive':
        value = "";
        break;
      case 'processor-model':
        value = "";
        break;
      case 'ram':
        value = "";
        break;
      case 'resolution':
        value = "";
        break;
      case 'screen-size':
        value = "";
        break;
      case 'size':
        value = "";
        break;
      case 'sound-stype':
        value = "";
        break;
      case 'wireless':
        value = "";
        break;
      case 'Side':
        value = "";
        break;
      case 'Brand':
        value = "";
        break;
      case 'Price':
        value = product.price.isEmpty ? "€0.00" :"€${product.price}";
        break;
      default:
        value = '-';
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        value,
        style: TextStyle(
          color: valueColor ?? Colors.black,
        ),
      ),
    );
  }

}

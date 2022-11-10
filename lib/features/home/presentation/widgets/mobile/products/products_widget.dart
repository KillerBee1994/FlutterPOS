import 'package:flutter/material.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';

import 'product_item_widget.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget(
      {Key? key, required this.products, required this.onTapProduct})
      : super(key: key);

  final List<Product> products;
  final Function(Product product) onTapProduct;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.25;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        childAspectRatio: (itemWidth / itemHeight),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 2,
        children: products
            .map(
              (Product product) => GestureDetector(
                onTap: () {
                  onTapProduct(product);
                },
                child: ProductItemWidget(
                  productName: product.name,
                  productImage: faker.image.loremPicsum.image(),
                  productPrice: product.price,
                  productSalePrice: product.salePrice,
                  product: product,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

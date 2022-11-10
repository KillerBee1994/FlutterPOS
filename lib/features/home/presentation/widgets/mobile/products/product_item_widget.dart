import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/data/models/product.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    this.productSalePrice,
    required this.product,
  }) : super(key: key);

  final String productImage;
  final String productName;
  final double productPrice;
  final double? productSalePrice;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      //height: 4280,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 253, 253),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.2),
            child: Image.network(
              productImage,
            ),
          ),
          if (!product.available!)
            Container(
              width: double.infinity,
              color: Color.fromARGB(255, 241, 3, 3),
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Text(
                "Item Sedang Kosong",
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      height: 1.50),
                ),
              ),
            ),
          const Divider(
            height: 1,
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11.0),
            child: Row(
              children: <Widget>[
                Text(
                  productName,
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 39, 38, 38),
                      fontSize: 8,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    if (productSalePrice != null && productSalePrice! > 0)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            productPrice.toStringAsFixed(5),
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0),
                                decoration: TextDecoration.lineThrough,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '  - Dollar',
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Color.fromARGB(255, 251, 1, 1),
                                fontSize: 9,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          productSalePrice != null && productSalePrice! > 0
                              ? '${productSalePrice?.toStringAsFixed(2)}'
                              : productPrice.toStringAsFixed(2),
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '   Dollar',
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore: prefer_const_constructors
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/widgets/web/cart_item_product_widget.dart';
import 'package:thepos/features/carts/presentation/widgets/web/cart_item_widget.dart';
import 'package:thepos/features/customer/presentation/controllers/customer_controller.dart';
import 'package:thepos/features/customer/presentation/widgets/model/item_dropdown_list.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  var cartsController = Get.find<CartsController>();
  final CustomerController customerController = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(
        () => Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            color: Colors.white,
            // height: 100,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cartsController.listCarts.map((cart) {
                      final index = cartsController.listCarts.indexOf(cart);

                      return GestureDetector(
                          onTap: () {
                            cartsController.changeCart(index);
                          },
                          child: CartItemWidget(
                              title: cart.keyCart,
                              isSelected: cartsController.selectedCart !=
                                      null &&
                                  cartsController.selectedCart.value == index));
                    }).toList(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffF79624),
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      // color: const Color(0xff178F49) ,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Container(
                    height: 45,
                    child: DropdownSearch<DropListItem>(
                      // Instead of this
                      //
                      // favoriteItemsAlignment: MainAxisAlignment.center,
                      // mode: Mode.DIALOG,
                      //
                      // add this
                      popupProps: const PopupProps.dialog(
                        favoriteItemProps: FavoriteItemProps(
                            favoriteItemsAlignment: MainAxisAlignment.center),
                      ),

                      // Instead of this
                      //
                      // dropdownSearchDecoration: InputDecoration(
                      //   disabledBorder: InputBorder.none,
                      //   hintText: dropdownCityName,
                      //   hintStyle: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 12,
                      //   ),
                      // ),
                      //
                      // add this
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          hintText: 'Pilih',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),

                      onChanged: (DropListItem? customer) {
                        if (customer != null) {
                          if (customer.isFooter())
                            customerController.showDialogAddCustomer();
                          else
                            cartsController.setSelectedCustomer(customer);
                        }
                      },
                      selectedItem: cartsController
                          .listCarts[cartsController.selectedCart.value]
                          .customer,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/edit.svg",
                      width: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'keranjang',
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          // style: TextStyle(
                          //   fontFamily: 'Cairo',
                          //   fontSize: 30,
                          //   color: const Color(0xff000000),
                          //   fontWeight: FontWeight.w600,
                          // ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                            color: Color(0xff178f49),
                          ),
                          child: Text(
                            '${cartsController.listCarts[cartsController.selectedCart.value].cartItems.length}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 20,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // cartsController.clearCarts();
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                        "assets/svg/delet.svg",
                        width: 25,
                      ),
                    ),
                  ],
                ),
                // Expanded(
                //   child: ListView.separated(
                //     scrollDirection: Axis.vertical,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: cartsController
                //         .listCarts[cartsController.selectedCart.value]
                //         .cartItems
                //         .length,
                //     itemBuilder: (context, index) {
                //       var item = cartsController
                //           .listCarts[cartsController.selectedCart.value]
                //           .cartItems[index];
                //      return CartItemProductWidget(
                //        item: item,
                //        refresh: () {
                //          setState(() {});
                //        },
                //      );
                //     },
                //     separatorBuilder: (context, index) {
                //       return Divider();
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      cartsController.pay();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff178f49), // background
                      onPrimary: const Color(0xffF79624),
                      // foreground
                    ),
                    child: cartsController.isPayLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: 55,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'pembayaran',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${cartsController.invoiceTotal}',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  'Dollar',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customDropDown(BuildContext context, DropListItem? item) {
    if (item == null || item.isFooter()) {
      return Container(
        child: Text(
          "Pilih",
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              color: Color(0xff3e4040),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    return Container(
      child: Text(item.getCustomer()!.mobile_no),
    );
  }

  Widget _customPopupItemBuilder(
      BuildContext context, DropListItem? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: item!.isFooter()
          ? Text(
              'Tambah',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: const Color(0xff178F49),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )
          : ListTile(
              selected: isSelected,
              title: Text(item.getCustomer()!.mobile_no),
            ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/controller/users/cart_user_controller.dart';
import 'package:udsaholoan/constant/component/button_custom.dart';
import 'package:udsaholoan/constant/component/theme.dart';

class CartUserPage extends StatelessWidget {
  CartUserPage({super.key});

  final cartUserC = Get.put(CartUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 14),
            Center(
              child: Text(
                "Keranjang",
                style: darkTitleText.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: cartUserC.quantityOfTheCart(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.blue,
                                  ),
                                );
                              } else if (snapshot.data!.docs.isEmpty) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 100),
                                  child: const Center(
                                    child: Text(
                                      "Keranjang Masih Kosong",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              print('docs : ${snapshot.data!.docs}');
                              print(
                                  'lsit docs : ${snapshot.data!.docs.isEmpty}');

                              var dataQuantityCart = snapshot.data!.docs;
                              return SizedBox(
                                height: 344,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: dataQuantityCart.length,
                                  itemBuilder: (context, index) {
                                    var quantityCart = dataQuantityCart[index];

                                    if (quantityCart['id'] ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid) {
                                      int totalCartPrice = 0;

                                      for (var doc in snapshot.data!.docs) {
                                        int price = doc['price'];
                                        int quantity = doc['quantity'];
                                        totalCartPrice += price * quantity;
                                        print(totalCartPrice);
                                      }

                                      cartUserC.subTotal.value = totalCartPrice;
                                      print(cartUserC.subTotal.value);

                                      cartUserC.updateSubTotal(totalCartPrice);
                                      cartUserC.addSubtotal(
                                          value: totalCartPrice);
                                      print(
                                          'Ini di totalItemPrice updateSubtotal nya : $totalCartPrice');
                                      print(
                                          'Ini di updateSubtotal nya : ${cartUserC.subTotal.value}');
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: quantityCart['photo'] !=
                                                        ''
                                                    ? Image.network(
                                                        quantityCart['photo'],
                                                        width: 88,
                                                        height: 88,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        "assets/contoh.png",
                                                        width: 88,
                                                        height: 88,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              const SizedBox(
                                                width: 8.0,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(quantityCart[
                                                            'namaProduk']),
                                                        GestureDetector(
                                                          onTap: () {
                                                            print(quantityCart
                                                                .id);
                                                            cartUserC
                                                                .deleteFromKeranjang(
                                                              doc: quantityCart
                                                                  .id,
                                                            );
                                                            cartUserC
                                                                .removeItemAndUpdateTotal(
                                                                    totalCartPrice);
                                                            cartUserC
                                                                .removeSubtotal(
                                                                    value:
                                                                        totalCartPrice);

                                                            print(
                                                                'Ini di totalItemPrice removeButton : $totalCartPrice');
                                                            print(
                                                                'Ini di removeButton : ${cartUserC.subTotal.value}');
                                                          },
                                                          child: Image.asset(
                                                            "assets/trashIcon.png",
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 9.0,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Ukuran :',
                                                          style:
                                                              greyText.copyWith(
                                                                  fontSize: 10),
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          quantityCart[
                                                              'whatASize'],
                                                          style:
                                                              greyText.copyWith(
                                                                  fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 9.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Rp.${quantityCart['price']}",
                                                          style: darkTitleText
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 137,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Total Item : ${quantityCart['quantity']}",
                                                                style: darkTitleText.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              const SizedBox(),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              );
                            }),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: greyColor.withOpacity(0.5),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Subtotal',
                                      style: greyText,
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: cartUserC.pembayaranSubtotal(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: Colors.blue,
                                              ),
                                            );
                                          }

                                          var dataPembayaranSubtotal =
                                              snapshot.data!.data();
                                          var subTotal = dataPembayaranSubtotal
                                              as Map<String, dynamic>;
                                          print(cartUserC.subTotal.value);
                                          print(subTotal['subtotal']);
                                          return Text(
                                            'Rp.${subTotal['subtotal']}',
                                            style: darkTitleText.copyWith(
                                                fontWeight: FontWeight.bold),
                                          );
                                        }),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery Fees",
                                      style: greyText,
                                    ),
                                    Text(
                                      "FREE",
                                      style: darkTitleText.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Discount",
                                      style: greyText,
                                    ),
                                    Text(
                                      "Rp.0",
                                      style: darkTitleText.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Container(
                                  height: 1,
                                  color: greyColor,
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total",
                                      style: greyText,
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: cartUserC.pembayaranSubtotal(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: Colors.blue,
                                              ),
                                            );
                                          }
                                          var dataPembayaranSubtotal =
                                              snapshot.data!.data();
                                          var subTotal = dataPembayaranSubtotal
                                              as Map<String, dynamic>;
                                          return Text(
                                            "Rp.${subTotal['subtotal']}",
                                            style: darkTitleText.copyWith(
                                                fontWeight: FontWeight.bold),
                                          );
                                        }),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        ButtonCustom(ontap: () {}, title: 'Pembayaran'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

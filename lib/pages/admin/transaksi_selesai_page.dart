import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udsaholoan/constant/component/custom_row_transaksi.dart';
import 'package:udsaholoan/constant/extension/date_time_ext.dart';
import 'package:udsaholoan/core.dart';

class TransaksiSelesaiPage extends StatelessWidget {
  final transaksiC = Get.find<DashboardAdminController>();

  TransaksiSelesaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: transaksiC.streamTransaksi('Selesai'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.blue,
                ),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "Belum Ada Transaksi",
                  style: darkTitleText,
                ),
              );
            }

            var dataRiwayatBelanja = snapshot.data!.docs;

            return ListView.separated(
              shrinkWrap: true,
              itemCount: dataRiwayatBelanja.length,
              separatorBuilder: (context, index) => Container(
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
              itemBuilder: (context, index) {
                var kelolaRiwayat = dataRiwayatBelanja[index];
                Timestamp timestamp = kelolaRiwayat['timestamp'];
                DateTime dateTime = timestamp.toDate();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Invoice",
                                style: titleText,
                              ),
                              Text(
                                "UD Sihaloan",
                                style: titleText,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          const HorizontalLine(),
                          const SizedBox(height: 5.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder(
                                future: transaksiC.getNamaPembeli(
                                    idUser: kelolaRiwayat['id']),
                                builder: (context, snapshot) {
                                  var namaPengguna =
                                      snapshot.data?['nama_pengguna'];
                                  var email = snapshot.data?['email'];
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Kepada :",
                                          style: darkTitleText.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Loading ...',
                                          style: darkTitleText,
                                        ),
                                      ],
                                    );
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kepada :",
                                        style: darkTitleText.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        namaPengguna,
                                        style: darkTitleText,
                                      ),
                                      Text(
                                        email,
                                        style: darkTitleText,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Tanggal :',
                                    style: darkTitleText.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    dateTime.toFormattedTime(),
                                    style: darkTitleText,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Status :',
                                    style: darkTitleText.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    kelolaRiwayat['statusBelanja'],
                                    style: darkTitleText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Image.network(
                            kelolaRiwayat['photo'],
                            width: 88,
                            height: 88,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10.0),
                          const HorizontalLine(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomRowTransaksi(
                            title: 'Nama Produk',
                            dataTransaksi: kelolaRiwayat['namaProduk'],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Warna',
                                style: darkTitleText.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(
                                    int.parse(
                                      kelolaRiwayat['whatAColor'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CustomRowTransaksi(
                            title: 'Ukuran',
                            dataTransaksi: kelolaRiwayat['whatASize'],
                          ),
                          CustomRowTransaksi(
                            title: 'Nomor HP Pembeli',
                            dataTransaksi: kelolaRiwayat['nohp_pembeli'],
                          ),
                          CustomRowTransaksi(
                            title: 'Jumlah Pembelian Produk',
                            dataTransaksi: kelolaRiwayat['quantity'].toString(),
                          ),
                          CustomRowTransaksi(
                            title: 'Total Pesanan',
                            dataTransaksi:
                                formatCurrency.format(kelolaRiwayat['price']),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const HorizontalLine(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

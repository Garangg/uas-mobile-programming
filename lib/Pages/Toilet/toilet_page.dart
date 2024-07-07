import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_laravel/Models/toilet_model.dart';
import 'package:flutter_laravel/Pages/Toilet/addtoilet_page.dart';
import 'package:flutter_laravel/Pages/Toilet/toiletdetail_page.dart';
import 'package:flutter_laravel/ViewModels/toilet_vm.dart';
import 'package:google_fonts/google_fonts.dart';

class ToiletPage extends StatefulWidget {
  const ToiletPage({super.key});

  @override
  State<ToiletPage> createState() => _ToiletPageState();
}

class _ToiletPageState extends State<ToiletPage> {
  toiletVM vm = toiletVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.orange[200],
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.orange[200],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<ToiletModel>>(
        future: toiletVM.getToilets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            var toilets = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Daftar Toilet",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: toilets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ToiletDetailPage(
                                  id: toilets[index].id,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                toilets[index].name,
                                style: GoogleFonts.poppins(),
                              ),
                              trailing: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Konfirmasi'),
                                          content: const Text(
                                              'Apakah Anda yakin ingin menghapus data toilet ini?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                toiletVM.deleteToilet(
                                                    toilets[index].id);
                                                Navigator.of(context).pop();
                                                setState(() {});
                                              },
                                              child: const Text('Hapus'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.delete_rounded)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[200],
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddToiletPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

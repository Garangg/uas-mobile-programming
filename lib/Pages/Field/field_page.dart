import 'package:flutter/material.dart';
import 'package:flutter_laravel/Models/field_model.dart';
import 'package:flutter_laravel/Pages/Field/addfield_page.dart';
import 'package:flutter_laravel/Pages/Field/fielddetail_page.dart';
import 'package:flutter_laravel/ViewModels/field_vm.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:google_fonts/google_fonts.dart';

class FieldPage extends StatefulWidget {
  const FieldPage({Key? key}) : super(key: key);

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  FieldVM vm = FieldVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.orange[200],
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            margin: const EdgeInsets.all(
                4), // Adjust the margin to control the size
            decoration: BoxDecoration(
              color:
                  Colors.orange[200], // Adjust the background color as needed
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
      body: FutureBuilder<List<FieldModel>>(
        future: FieldVM.getFields(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No fields available'));
          } else {
            var fields = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Daftar Lapangan",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: fields.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FieldDetailPage(
                                    id: fields[index].id,
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
                                  fields[index].name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.red[100],
                                          title: const Text('Konfirmasi'),
                                          content: const Text(
                                              'Apakah Anda yakin ingin menghapus data lapangan ini?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Batal',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                FieldVM.deleteField(
                                                        fields[index].id)
                                                    .then((value) {
                                                  showToast(
                                                      'Data Lapangan berhasil dihapus',
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.red[400],
                                                      textStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .white));
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                });
                                              },
                                              child: const Text('Hapus',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 202, 55, 45))),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.delete_rounded,
                                      color: Colors.black, size: 20),
                                ),
                              ),
                            ),
                          ));
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
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AddFieldPage(),
            ),
          );
        },
        backgroundColor: Colors.orange[200],
        child: const Icon(Icons.add),
      ),
    );
  }
}

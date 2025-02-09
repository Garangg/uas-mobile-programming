import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_laravel/Models/laboratorium_model.dart';
import 'package:flutter_laravel/Pages/Laboratorium/addlaboratorium_page.dart';
import 'package:flutter_laravel/Pages/Laboratorium/laboratoriumdetail_page.dart';
import 'package:flutter_laravel/ViewModels/laboratorium_vm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class LaboratoriumPage extends StatefulWidget {
  const LaboratoriumPage({super.key});

  @override
  State<LaboratoriumPage> createState() => _LaboratoriumPageState();
}

class _LaboratoriumPageState extends State<LaboratoriumPage> {
  LaboratoriumVM vm = LaboratoriumVM();

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
      body: FutureBuilder<List<LaboratoriumModel>>(
        future: LaboratoriumVM.getLaboratoriums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            var laboratoriums = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Daftar Laboratorium",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: laboratoriums.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LaboratoriumDetailPage(
                                    id: laboratoriums[index].id,
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
                                title: Text(laboratoriums[index].name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),),
                                trailing: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.red[100],
                                          title: const Text('Konfirmasi'),
                                          content: const Text(
                                              'Apakah Anda yakin ingin menghapus data laboratorium ini?'),
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
                                                LaboratoriumVM
                                                        .deleteLaboratorium(
                                                            laboratoriums[index]
                                                                .id)
                                                    .then((value) {
                                                  showToast(
                                                      'Data Laboratorium berhasil dihapus',
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.red[400],
                                                      textStyle: const TextStyle(
                                                          color: Colors.white));
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
                                      size: 20, color: Colors.black),
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
        backgroundColor: Colors.orange[200],
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddLaboratoriumPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

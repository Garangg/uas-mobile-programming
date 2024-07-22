import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_laravel/Models/toilet_model.dart';
import 'package:flutter_laravel/Pages/Toilet/toilet_page.dart';
import 'package:flutter_laravel/ViewModels/toilet_vm.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';

class EditToiletPage extends StatefulWidget {
  final ToiletModel toilet;

  const EditToiletPage({Key? key, required this.toilet}) : super(key: key);

  @override
  _EditToiletPageState createState() => _EditToiletPageState();
}

class _EditToiletPageState extends State<EditToiletPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lengthController;
  late TextEditingController _widthController;
  late TextEditingController _descriptionController;
  late TextEditingController _floorLocationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.toilet.name);
    _lengthController =
        TextEditingController(text: widget.toilet.length.toString());
    _widthController =
        TextEditingController(text: widget.toilet.width.toString());
    _descriptionController =
        TextEditingController(text: widget.toilet.description);
    _floorLocationController =
        TextEditingController(text: widget.toilet.floorLocation);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _descriptionController.dispose();
    _floorLocationController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final updatedToilet = ToiletModel(
        id: widget.toilet.id,
        name: _nameController.text,
        length: int.parse(_lengthController.text),
        width: int.parse(_widthController.text),
        floorLocation: _floorLocationController.text,
        description: _descriptionController.text,
        createdAt: widget.toilet.createdAt,
        updatedAt: DateTime.now(),
      );

      try {
        await toiletVM.updateToilet(updatedToilet).then((value) {
          showToast('Data toilet berhasil diubah',
              context: context,
              backgroundColor: Colors.blue[300],
              textStyle: GoogleFonts.poppins(color: Colors.white));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ToiletPage(),
            ),
          );
        });
      } catch (error) {
        print("Error updating toilet: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.orange[200],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ToiletPage()));
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Toilet',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 20,
                            offset: const Offset(
                                0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan nama';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 20,
                            offset: const Offset(
                                0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _lengthController,
                        decoration: const InputDecoration(
                          labelText: 'Panjang',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan panjang';
                          } else if (int.tryParse(value) == null) {
                            return 'Masukkan angka yang valid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 20,
                            offset: const Offset(
                                0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _widthController,
                        decoration: const InputDecoration(
                          labelText: 'Lebar',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan lebar';
                          } else if (int.tryParse(value) == null) {
                            return 'Masukkan angka yang valid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 20,
                            offset: const Offset(
                                0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan deskripsi';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 20,
                            offset: const Offset(
                                0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _floorLocationController,
                        decoration: const InputDecoration(
                          labelText: 'Lokasi Lantai',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan lokasi lantai';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 113, 161, 224),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text(
                  'Update Toilet',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

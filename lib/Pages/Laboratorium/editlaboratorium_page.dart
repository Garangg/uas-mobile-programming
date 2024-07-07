import 'package:flutter/material.dart';
import 'package:flutter_laravel/Models/laboratorium_model.dart';
import 'package:flutter_laravel/Pages/Laboratorium/laboratorium_page.dart';
import 'package:flutter_laravel/ViewModels/laboratorium_vm.dart';
import 'package:google_fonts/google_fonts.dart';

class EditLaboratoriumPage extends StatefulWidget {
  final LaboratoriumModel laboratorium;

  const EditLaboratoriumPage({Key? key, required this.laboratorium})
      : super(key: key);

  @override
  _EditLaboratoriumPageState createState() => _EditLaboratoriumPageState();
}

class _EditLaboratoriumPageState extends State<EditLaboratoriumPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lengthController;
  late TextEditingController _widthController;
  late TextEditingController _descriptionController;
  late TextEditingController _capacityController;
  late TextEditingController _floorLocationController;
  late DateTime _createdAt;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.laboratorium.name);
    _lengthController =
        TextEditingController(text: widget.laboratorium.length.toString());
    _widthController =
        TextEditingController(text: widget.laboratorium.width.toString());
    _descriptionController =
        TextEditingController(text: widget.laboratorium.description);
    _capacityController =
        TextEditingController(text: widget.laboratorium.capacity);
    _floorLocationController =
        TextEditingController(text: widget.laboratorium.floorLocation);
    _createdAt = widget.laboratorium.createdAt;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _descriptionController.dispose();
    _capacityController.dispose();
    _floorLocationController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final updatedLaboratorium = LaboratoriumModel(
        id: widget.laboratorium.id,
        name: _nameController.text,
        length: int.parse(_lengthController.text),
        width: int.parse(_widthController.text),
        description: _descriptionController.text,
        capacity: _capacityController.text,
        floorLocation: _floorLocationController.text,
        createdAt: _createdAt,
        updatedAt: DateTime.now(),
      );

      try {
        await LaboratoriumVM.updateLaboratorium(updatedLaboratorium);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LaboratoriumPage(),
          ),
        );
      } catch (error) {
        // Handle or log error
        print("Error updating laboratorium: $error");
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
                        builder: (context) => const LaboratoriumPage()));
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
              "Edit Laboratorium",
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
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
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
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _lengthController,
                        decoration: InputDecoration(
                          labelText: 'Length',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the length';
                          } else if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
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
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _widthController,
                        decoration: InputDecoration(
                          labelText: 'Width',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the width';
                          } else if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
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
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
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
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _capacityController,
                        decoration: InputDecoration(
                          labelText: 'Capacity',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the capacity';
                          } else if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
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
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _floorLocationController,
                        decoration: InputDecoration(
                          labelText: 'Floor Location',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the floor location';
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
                  'Update Laboratorium',
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

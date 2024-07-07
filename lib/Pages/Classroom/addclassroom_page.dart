import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_laravel/Models/classroom_model.dart';
import 'package:flutter_laravel/Pages/Classroom/classroom_page.dart';
import 'package:flutter_laravel/ViewModels/classroom_vm.dart';
import 'package:google_fonts/google_fonts.dart';

class AddClassroomPage extends StatefulWidget {
  const AddClassroomPage({Key? key}) : super(key: key);

  @override
  _AddClassroomPageState createState() => _AddClassroomPageState();
}

class _AddClassroomPageState extends State<AddClassroomPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _floorLocationController =
      TextEditingController();
  final TextEditingController _userRoomController = TextEditingController();
  DateTime _createdAt = DateTime.now();
  DateTime _updatedAt = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _descriptionController.dispose();
    _capacityController.dispose();
    _floorLocationController.dispose();
    _userRoomController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final classroom = ClassroomModel(
        id: 0,
        name: _nameController.text,
        length: int.parse(_lengthController.text),
        width: int.parse(_widthController.text),
        description: _descriptionController.text,
        capacity: _capacityController.text,
        floorLocation: _floorLocationController.text,
        userRoom: _userRoomController.text,
        createdAt: _createdAt,
        updatedAt: _updatedAt,
      );

      try {
        await classroomVM.createClassroom(classroom);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ClassroomPage(),
          ),
        );
      } catch (error) {
        // Handle or log error
        print("Error creating classroom: $error");
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ClassroomPage()));
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
              'Add Classroom',
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
                        controller: _userRoomController,
                        decoration: InputDecoration(
                          labelText: 'User Room',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the user room';
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
                    Color.fromARGB(255, 113, 224, 119),
                  )),
                  onPressed: _submitForm,
                  child: const Text(
                    'Add Classroom',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

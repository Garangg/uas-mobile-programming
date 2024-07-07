import 'package:flutter/material.dart';
import 'package:flutter_laravel/Models/field_model.dart';
import 'package:flutter_laravel/Pages/Field/field_page.dart';
import 'package:flutter_laravel/ViewModels/field_vm.dart';
import 'package:google_fonts/google_fonts.dart';

class EditFieldPage extends StatefulWidget {
  final FieldModel field;

  const EditFieldPage({Key? key, required this.field}) : super(key: key);

  @override
  _EditFieldPageState createState() => _EditFieldPageState();
}

class _EditFieldPageState extends State<EditFieldPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lengthController;
  late TextEditingController _widthController;
  late TextEditingController _descriptionController;
  late DateTime _createdAt;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.field.name);
    _lengthController = TextEditingController(text: widget.field.length.toString());
    _widthController = TextEditingController(text: widget.field.width.toString());
    _descriptionController = TextEditingController(text: widget.field.description);
    _createdAt = widget.field.createdAt;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final updatedField = FieldModel(
        id: widget.field.id,
        name: _nameController.text,
        length: int.parse(_lengthController.text),
        width: int.parse(_widthController.text),
        description: _descriptionController.text,
        createdAt: _createdAt,
        updatedAt: DateTime.now(),
      );

      try {
        await FieldVM.updateField(updatedField);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const FieldPage(),
          ),
        );
      } catch (error) {
        // Handle or log error
        print("Error updating field: $error");
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FieldPage()));
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
            "Edit Field",
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
                'Update Field',
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

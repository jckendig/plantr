import 'package:flutter/cupertino.dart';

class NewPlantScreen extends StatefulWidget {
  final Function
      addPlantCallback; // Callback to pass plant data to the main screen

  const NewPlantScreen({super.key, required this.addPlantCallback});

  @override
  State<NewPlantScreen> createState() => _NewPlantScreenState();
}

class _NewPlantScreenState extends State<NewPlantScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to get user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Call the callback function to add the plant
      widget.addPlantCallback(_nameController.text, _descriptionController.text,
          'assets/transparent-cartoon-plants-succulent-plant-free-music-free-mus-5edb68f1ca8e24.7611070815914375538297.jpg'
          // You can change this to accept user image input later
          );
      Navigator.pop(context); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Add New Plant'),
        trailing: GestureDetector(
          onTap:
              _submitForm, // Submit the form when the 'Add' button is pressed
          child: const Icon(CupertinoIcons.check_mark),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CupertinoTextFormFieldRow(
                controller: _nameController,
                placeholder: 'Plant Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a plant name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CupertinoTextFormFieldRow(
                controller: _descriptionController,
                placeholder: 'Plant Description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // You could add an image picker here for uploading plant images
            ],
          ),
        ),
      ),
    );
  }
}

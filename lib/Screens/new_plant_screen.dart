import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class NewPlantScreen extends StatefulWidget {
  final Function
      addPlantCallback; // Callback to pass plant data to the main screen

  const NewPlantScreen({super.key, required this.addPlantCallback});

  @override
  State<NewPlantScreen> createState() => _NewPlantScreenState();
}

class _NewPlantScreenState extends State<NewPlantScreen> {
  final _formKey = GlobalKey<FormState>();

  final String plantAsset =
      'assets/transparent-cartoon-plants-succulent-plant-free-music-free-mus-5edb68f1ca8e24.7611070815914375538297.jpg';

  // Controllers to get user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  String? _selectedAssetImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery); // Can also use ImageSource.camera
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedAssetImage = null; // Reset asset image selection
      });
    }
  }

  // Function to select an asset image
  void _selectAssetImage(String assetImage) {
    setState(() {
      _selectedAssetImage = assetImage;
      _selectedImage = null; // Reset uploaded image selection
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String imageUrl =
          _selectedAssetImage ?? (_selectedImage?.path ?? plantAsset);
      // Call the callback function to add the plant
      widget.addPlantCallback(
          _nameController.text, _descriptionController.text, imageUrl
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
              // Image picker button
              Row(
                children: [
                  CupertinoButton.filled(
                    onPressed: _pickImage,
                    child: const Text('Upload Photo'),
                  ),
                  const SizedBox(width: 16),
                  if (_selectedImage != null)
                    Image.file(_selectedImage!, width: 100, height: 100),
                ],
              ),
              const SizedBox(height: 16),
              // List of predefined asset images
              const SizedBox(
                height: 16,
                child: Text(
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    'Or select a default image:'),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  GestureDetector(
                    onTap: () => _selectAssetImage(plantAsset),
                    child: Image.asset(plantAsset, width: 80, height: 80),
                  ),
                  GestureDetector(
                    onTap: () =>
                        _selectAssetImage('assets/transparent-plant.png'),
                    child: Image.asset('assets/transparent-plant.png',
                        width: 80, height: 80),
                  ),
                  GestureDetector(
                    onTap: () => _selectAssetImage(plantAsset),
                    child: Image.asset(plantAsset, width: 80, height: 80),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_selectedAssetImage != null)
                Image.asset(_selectedAssetImage!, width: 100, height: 100),
            ],
            // You could add an image picker here for uploading plant images
          ),
        ),
      ),
    );
  }
}

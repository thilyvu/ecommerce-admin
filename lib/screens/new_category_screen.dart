import 'package:ecommerce_admin/controllers/controllers.dart';
import 'package:ecommerce_admin/models/models.dart';
import 'package:ecommerce_admin/services/database_service.dart';
import 'package:ecommerce_admin/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class NewCategoryScreen extends StatelessWidget {
  NewCategoryScreen({Key? key}) : super(key: key);
  final CategoryController categoryController =  Get.find<CategoryController>();
  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a category'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  ImagePicker _picker = ImagePicker();
                  final XFile? _image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No image was selected')),
                    );
                  }
                  if (_image != null) {
                    await storage.uploadCategoryImage(_image);
                    var imageURL = await storage.getDownloadURL(_image.name);
                    categoryController.newCategory.update(
                        'imageUrl', (_) => imageURL,
                        ifAbsent: () => imageURL);
                  }
                },
                child: SizedBox(
                  height: 65,
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              ImagePicker _picker = ImagePicker();
                              final XFile? _image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (_image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('No image was selected')),
                                );
                              }
                              if (_image != null) {
                                await storage.uploadCategoryImage(_image);
                                var imageURL =
                                    await storage.getDownloadURL(_image.name);
                                categoryController.newCategory.update(
                                    'imageUrl', (_) => imageURL,
                                    ifAbsent: () => imageURL);
                              }
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                            )),
                        const Text(
                          'Add an image',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Category Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextFormField('Category ID', 'id', categoryController),
              _buildTextFormField('Category Name', 'name', categoryController),


              ElevatedButton(
                  onPressed: () async {
                    // ignore: avoid_print
                    print(categoryController.newCategory);
                    // database.addCategory(
                    //   Category(
                    //     id: int.parse(categoryController.newCategory['id']),
                    //     name: categoryController.newCategory['name'],
                    //     imageUrl: categoryController.newCategory['imageUrl'],
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(primary: (Colors.black)),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      
    );
  }


  TextFormField _buildTextFormField(
          String hintText, String name, CategoryController categoryController) =>
      TextFormField(
        decoration: InputDecoration(hintText: hintText),
        onChanged: (value) {
          categoryController.newCategory
              .update(name, (_) => value, ifAbsent: () => value);
        },
      );
}

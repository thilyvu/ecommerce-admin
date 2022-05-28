import 'package:ecommerce_admin/controllers/product_controller.dart';
import 'package:ecommerce_admin/models/models.dart';
import 'package:ecommerce_admin/services/database_service.dart';
import 'package:ecommerce_admin/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);
  final ProductController productController = Get.find();
  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a product'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => Column(
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
                    await storage.uploadImage(_image);
                    var imageURL = await storage.getDownloadURL(_image.name);
                    productController.newProduct.update(
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
                                await storage.uploadImage(_image);
                                var imageURL =
                                    await storage.getDownloadURL(_image.name);
                                productController.newProduct.update(
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
                'Product Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextFormField('Product ID', 'id', productController),
              _buildTextFormField('Product Name', 'name', productController),
              _buildTextFormField(
                  'Product Description', 'description', productController),
              _buildTextFormField(
                  'Product Category', 'category', productController),
              const SizedBox(
                height: 10,
              ),
              _buildSlider(
                  'Price', 'price', productController, productController.price),
              _buildSlider('Quantity', 'quantity', productController,
                  productController.quantity),
              const SizedBox(
                height: 10,
              ),
              _buildCheckBox('Recommend', 'isRecommend', productController,
                  productController.isRecommend),
              _buildCheckBox('Popular', 'isPopular', productController,
                  productController.isPopular),
              ElevatedButton(
                  onPressed: () async {
                    // ignore: avoid_print
                    print(productController.newProduct);
                    database.addProduct(
                      Product(
                        id: int.parse(productController.newProduct['id']),
                        name: productController.newProduct['name'],
                        category: productController.newProduct['category'],
                        imageUrl: productController.newProduct['imageUrl'],
                        description:
                            productController.newProduct['description'],
                        isRecommend:
                            productController.newProduct['isRecommend'],
                        isPopular: productController.newProduct['isPopular'],
                        price: productController.newProduct['price'],
                        quantity:
                            productController.newProduct['quantity'].toInt(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(primary: (Colors.black)),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCheckBox(String title, String name,
      ProductController productController, bool? controllerValue) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          onChanged: (value) {
            productController.newProduct
                .update(name, (_) => value, ifAbsent: () => value);
          },
          checkColor: Colors.black,
          activeColor: Colors.black12,
        ),
      ],
    );
  }

  Row _buildSlider(String title, String name,
      ProductController productController, double? controllerValue) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            min: 0,
            max: 100,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct
                  .update(name, (_) => value, ifAbsent: () => value);
            },
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField(
          String hintText, String name, ProductController productController) =>
      TextFormField(
        decoration: InputDecoration(hintText: hintText),
        onChanged: (value) {
          productController.newProduct
              .update(name, (_) => value, ifAbsent: () => value);
        },
      );
}

import 'package:ecommerce_admin/controllers/product_controller.dart';
import 'package:ecommerce_admin/models/product_model.dart';
import 'package:ecommerce_admin/screens/new_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => NewProductScreen());
              },
              child: SizedBox(
                height: 65,
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.to(() => NewProductScreen());
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          )),
                      const Text(
                        'Add New Product',
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
            Expanded(
                child: Obx(
              () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 210,
                      child: ProductCard(
                        product: productController.products[index],
                        index: index,
                      ),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  ProductCard({Key? key, required this.product, required this.index})
      : super(key: key);
  final ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.description,
              style: const TextStyle(fontSize: 12),
            ),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: product.price,
                              min: 0,
                              max: 100,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              onChanged: (value) {
                                productController.updateProductPrice(
                                    index, product, value);
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductPrice(
                                    product, 'price', value);
                              },
                            ),
                          ),
                          // ignore: unnecessary_string_interpolations
                          Text(
                            product.price.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Text(
                              'QTy',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: product.quantity.toDouble(),
                              min: 0,
                              max: 100,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              onChanged: (value) {
                                productController.updateProductQuantity(
                                    index, product, value.toInt());
                              },
                               onChangeEnd: (value) {
                                productController.saveNewProductQuantity(
                                    product, 'quantity', value.toInt());
                              },
                            ),
                          ),
                          // ignore: unnecessary_string_interpolations
                          Text(
                            '\$${product.quantity.toInt()}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

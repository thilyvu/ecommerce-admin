import 'package:ecommerce_admin/controllers/controllers.dart';
import 'package:ecommerce_admin/models/category_model.dart';
import 'package:ecommerce_admin/screens/new_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => NewCategoryScreen());
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
                            Get.to(() => NewCategoryScreen());
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          )),
                      const Text(
                        'Add New Category',
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
                  itemCount: categoryController.catagories.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 210,
                      child: CategoryCard(
                        category: categoryController.catagories[index],
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

class CategoryCard extends StatelessWidget {
  final Category category;
  final int index;
  CategoryCard({Key? key, required this.category, required this.index})
      : super(key: key);
  final CategoryController categoryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
       semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.network(
                    category.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

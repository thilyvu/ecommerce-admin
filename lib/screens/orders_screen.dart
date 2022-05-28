import 'package:ecommerce_admin/controllers/order_controller.dart';
import 'package:ecommerce_admin/models/models.dart';
import 'package:ecommerce_admin/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);
  final OrderController orderController = Get.put(OrderController());
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => ListView.builder(
                itemCount: orderController.pendingOrders.length,
                itemBuilder: (BuildContext context, int index) {
                  return OrderCard(
                      order: orderController.pendingOrders[index],
                      listProducts: productController.products);
                }),
          ))
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final List<Product> listProducts;
  final OrderController orderController = Get.find();
  OrderCard({Key? key, required this.order, required this.listProducts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var products = listProducts
        .where((product) => order.productIds.contains(product.id))
        .toList();
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order ID: ${order.id}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd-mm-yy').format(order.createdAt),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              products[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 285,
                                child: Text(
                                  products[index].description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('Delivery Fee',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('${order.deliveryFee}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('${order.total}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  !order.isAccepted
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              minimumSize: const Size(150, 40)),
                          onPressed: () {
                            orderController.updateOrder(
                                order, 'isAccepted', !order.isAccepted);
                          },
                          child: const Text(
                            'Accept',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              minimumSize: const Size(150, 40)),
                          onPressed: () {
                            orderController.updateOrder(
                                order, 'isDelivered', !order.isDelivered);
                          },
                          child: const Text(
                            'Deliver',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: const Size(150, 40)),
                    onPressed: () {
                      orderController.updateOrder(
                          order, 'isCanceled', !order.isAccepted);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/models/models.dart';


class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<List<Product>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Category>> getCategories() {
    return _firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
    });
  }
  Stream<List<Order>> getOrders() {
    return _firebaseFirestore
        .collection('orders')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }
    Stream<List<Order>> getPendingOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('isCanceled', isEqualTo: false)
        .where('isDelivered', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }
  Future<void> addCategory(Category category) {
    return _firebaseFirestore.collection('categories').add(category.toMap());
  }
  Future<void> updateField(Product product, String field, dynamic newValue) {
    return _firebaseFirestore.collection('products')
    .where('id', isEqualTo: product.id)
    .get().then((querySnapshot) => {
      querySnapshot.docs.first.reference.update({field: newValue})
    } );
  }

    Future<void> updateOrder(Order order, String field, dynamic newValue) {
    return _firebaseFirestore.collection('orders')
    .where('id', isEqualTo: order.id)
    .get().then((querySnapshot) => {
      querySnapshot.docs.first.reference.update({field: newValue})
    } );
  }
}

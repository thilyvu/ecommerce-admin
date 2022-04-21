import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String category;
  final String imageUrl;
  final String description;
  double price;
  final bool isRecommend;
  final bool isPopular;
  int quantity;
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
    this.price = 0,
    required this.isRecommend,
    required this.isPopular,
    this.quantity = 0,
  });

  Product copyWith({
    int? id,
    String? name,
    String? category,
    String? imageUrl,
    String? description,
    double? price,
    bool? isRecommend,
    bool? isPopular,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      isRecommend: isRecommend ?? this.isRecommend,
      isPopular: isPopular ?? this.isPopular,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'category': category});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'description': description});
    result.addAll({'price': price});
    result.addAll({'isRecommend': isRecommend});
    result.addAll({'isPopular': isPopular});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory Product.fromSnapshot(DocumentSnapshot snap) {
    return Product(
      id: snap.data().toString().contains('id') ? snap['id']?.toInt() ?? 0 : 0,
      name:  snap.data().toString().contains('name') ? snap['name'] ?? '' : '',
      category: snap.data().toString().contains('category') ? snap['category'] ?? '' :'',
      imageUrl:snap.data().toString().contains('imageUrl') ? snap['imageUrl'] ?? '' :'',
      description:snap.data().toString().contains('description') ? snap['description'] ?? '' :'',
      price: snap.data().toString().contains('price') ? snap['price']?.toDouble() ?? 0.0 : 0.0,
      isRecommend: snap.data().toString().contains('isRecommend')  ? snap['isRecommend'] ?? false : false,
      isPopular:  snap.data().toString().contains('isPopular') ? snap['isPopular'] ?? false : false,
      quantity: snap.data().toString().contains('quantity') ? snap['quantity']?.toInt() ?? 0 :0,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Product(id: $id, name: $name, category: $category, imageUrl: $imageUrl, description: $description, price: $price, isRecommend: $isRecommend, isPopular: $isPopular, quantity: $quantity)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      category,
      imageUrl,
      description,
      price,
      isRecommend,
      isPopular,
      quantity,
    ];
  }

  @override
  bool get stringify => true;

   static List<Product> products = [
     Product(
        id: 1,
        name: 'Soft Drink #1',
        category: 'Soft Drinks',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3gYAebxhLdG3_1DHqhAbTA1E18Iqt9CEQyQ&usqp=CAU',
        description: 'orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
        price: 20,
        quantity: 10,
        isRecommend: true,
        isPopular: true
        ),
     Product(
        id: 2,
        name: "Soft Drink #2",
        category: 'Soft Drinks',
        description: 'orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
        imageUrl: 'https://cdn.tgdd.vn/2021/05/content/3.6-800x450.jpg',
        price: 10,
        quantity: 10,
        isRecommend: false,
        isPopular: true),
     Product(
        id: 3,
        name: "Soft Drink #3",
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
        category: 'Soft Drinks',
        imageUrl: 'https://cf.shopee.vn/file/1bfb741a4fa152269d65bc220e215469',
        price: 15,
        quantity: 10,
        isRecommend: true,
        isPopular: false),
     Product(
        id: 4,
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
        name: 'Smoothies #1',
        category: 'Smoothies',
        imageUrl:
            'https://cdn.nguyenkimmall.com/images/companies/_1/Content/tin-tuc/gia-dung/10-cach-lam-smoothie-ngon-dep-heathy-cho-nang-eo-thon-h1.jpg',
        price: 12,
        quantity: 10,
        isRecommend: true,
        isPopular: false),
     Product(
        id: 5,
        name: 'Smoothies #2',
        category: 'Smoothies',
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, ',
        imageUrl:
            'https://monngonmoingay.com/wp-content/uploads/2021/11/Smoothies-tra-sua-dau-800.jpg',
        price: 14,
        quantity: 10,
        isRecommend: true,
        isPopular: true),
    Product(
        id: 6,
        name: 'Smoothies #3',
        category: 'Smoothies',
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
        imageUrl:
            'https://chefjob.vn/wp-content/uploads/2020/07/thuc-uong-smoothie-la-gi.jpg',
        price: 13,
        quantity: 10,
        isRecommend: false,
        isPopular: true)
  ];
}

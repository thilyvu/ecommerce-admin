import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  Category copyWith({
    int? id,
    String? name,
    String? imageUrl,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'imageUrl': imageUrl});
  
    return result;
  }

  factory Category.fromSnapshot(DocumentSnapshot snap) {
    return Category(
      id:  snap.data().toString().contains('id') ? snap['id']?.toInt() ?? 0 : 0,
      name:  snap.data().toString().contains('name') ? snap['name'] ?? '' : '',
      imageUrl:snap.data().toString().contains('imageUrl') ? snap['imageUrl'] ?? '' :'',
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Category(id: $id, name: $name, imageUrl: $imageUrl)';

  @override
  List<Object> get props => [id, name, imageUrl];

  @override
  bool get stringify => true;

}

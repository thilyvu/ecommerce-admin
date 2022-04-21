import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final int customerId;
  final List<int> productIds;
  final double deliveryFee;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isCanceled;
  final bool isDelivered;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.customerId,
    required this.productIds,
    required this.deliveryFee,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isCanceled,
    required this.isDelivered,
    required this.createdAt,
  });

  Order copyWith({
    int? id,
    int? customerId,
    List<int>? productIds,
    double? deliveryFee,
    double? subtotal,
    double? total,
    bool? isAccepted,
    bool? isCanceled,
    bool? isDelivered,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isCanceled: isCanceled ?? this.isCanceled,
      isDelivered: isDelivered ?? this.isDelivered,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'customerId': customerId});
    result.addAll({'productIds': productIds});
    result.addAll({'deliveryFee': deliveryFee});
    result.addAll({'subtotal': subtotal});
    result.addAll({'total': total});
    result.addAll({'isAccepted': isAccepted});
    result.addAll({'isCanceled': isCanceled});
    result.addAll({'isDelivered': isDelivered});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});

    return result;
  }

  factory Order.fromSnapshot(DocumentSnapshot snap) {
    return Order(
      id: snap.data().toString().contains('id') ? snap['id']?.toInt() ?? 0 : 0,
      customerId: snap.data().toString().contains('customerId')
          ? snap['customerId']?.toInt() ?? 0
          : 0,
      productIds: snap.data().toString().contains('productIds')
          ? List<int>.from(snap['productIds'])
          : [],
      deliveryFee: snap.data().toString().contains('deliveryFee')
          ? snap['deliveryFee']?.toDouble() ?? 0.0
          : 0.0,
      subtotal: snap.data().toString().contains('subtotal')
          ? snap['subtotal']?.toDouble() ?? 0.0
          : 0.0,
      total: snap.data().toString().contains('total')
          ? snap['total']?.toDouble() ?? 0.0
          : 0.0,
      isAccepted: snap.data().toString().contains('isAccepted')
          ? snap['isAccepted'] ?? false
          : false,
      isCanceled: snap.data().toString().contains('isCanceled')
          ? snap['isCanceled'] ?? false
          : false,
      isDelivered: snap.data().toString().contains('isDelivered')
          ? snap['isDelivered'] ?? false
          : false,
      createdAt: snap.data().toString().contains('createdAt')
          ? snap['createdAt'].toDate() ??  DateTime.now()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, productIds: $productIds, deliveryFee: $deliveryFee, subtotal: $subtotal, total: $total, isAccepted: $isAccepted,isCanceled: $isCanceled, isDelivered: $isDelivered, createdAt: $createdAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      customerId,
      productIds,
      deliveryFee,
      subtotal,
      total,
      isAccepted,
      isCanceled,
      isDelivered,
      createdAt,
    ];
  }

  static List<Order> orders = [
    Order(
        id: 1,
        customerId: 2345,
        productIds: const [1, 2],
        deliveryFee: 10,
        subtotal: 20,
        total: 30,
        isAccepted: false,
        isCanceled: false,
        isDelivered: false,
        createdAt: DateTime.now()),
    Order(
        id: 2,
        customerId: 23,
        productIds: const [1, 2, 3],
        deliveryFee: 10,
        subtotal: 30,
        total: 30,
        isAccepted: false,
        isCanceled: false,
        isDelivered: false,
        createdAt: DateTime.now()),
  ];
}

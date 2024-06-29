import 'package:dayshez_pt/models/individual_order.dart';
import 'package:dayshez_pt/utils.dart';

enum OrderStatus { success, show, noShow, error, undefined }

class Order {
  String? name;
  String? pathImage;
  String? subCompany;
  String? location;
  double? price;
  int? numArticles;
  int? id;
  DateTime? date;
  OrderStatus? status;
  List<IndivudualOrder>? orders;

  Order(
      {required this.id,
      required this.name,
      required this.pathImage,
      required this.subCompany,
      required this.date,
      required this.status,
      required this.price,
      required this.numArticles,
      required this.location,
      this.orders});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json['id'],
      name: json['name_company'],
      pathImage: json['image'],
      subCompany: json['subCompany_name'],
      date: DateTime.parse(json['created_at']),
      status: setStatus(json['status']),
      price: json['price'].toDouble(),
      numArticles: json['orders'].length,
      location: json['location'],
      orders: setIndividualOrders(json['orders']));

  static List<Order> fromPostgrestFilterBuilder(
          List<Map<String, dynamic>> orders) =>
      orders.map((order) {
        return Order(
            id: order['id'],
            name: order['name_company'],
            pathImage: order['image'],
            subCompany: order['subCompany_name'],
            date: DateTime.parse(order['created_at']),
            status: setStatus(order['status']),
            price: order['price'].toDouble(),
            numArticles: order['orders'].length,
            location: order['location'],
            orders: setIndividualOrders(order['orders']));
      }).toList();
}

OrderStatus setStatus(String status) {
  switch (status) {
    case STATUS_COMPLETE:
      return OrderStatus.success;
    case STATUS_ERROR:
      return OrderStatus.error;
    case STATUS_SHOW:
      return OrderStatus.show;
    case STATUS_NO_SHOW:
      return OrderStatus.noShow;
    default:
      return OrderStatus.undefined;
  }
}

String getStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.success:
      return STATUS_COMPLETE;
    case OrderStatus.error:
      return STATUS_ERROR;
    case OrderStatus.show:
      return STATUS_SHOW;
    case OrderStatus.noShow:
      return STATUS_NO_SHOW;
    default:
      return STATUS_UNDEFINED;
  }
}

List<IndivudualOrder> setIndividualOrders(List indOrders) {
  List<IndivudualOrder> orders = [];
  if (indOrders.isEmpty) {
    return [];
  } else {
    for (var element in indOrders) {
      Map<String, dynamic> oderes = element;
      orders.addAll(oderes.entries.map((order) {
        return IndivudualOrder(
            name: order.key,
            amount: order.value['quantity'],
            originalPrice: order.value['originalPrice'].toDouble(),
            priceDiscount: order.value['priceDiscount'].toDouble());
      }).toList());
    }
    return orders;
  }
}

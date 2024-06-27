import 'package:dayshez_pt/models/individual_order.dart';
import 'package:dayshez_pt/utils.dart';

enum OrderStatus { success, loading, error }

class Order {
  String? name;
  String? pathImage;
  String? company;
  String? iconPath;
  String? location;
  double? price;
  int? numArticles;
  DateTime? date;
  OrderStatus? status;
  List<IndivudualOrder>? orders;

  Order(
      {required this.name,
      required this.pathImage,
      required this.company,
      required this.date,
      required this.status,
      required this.iconPath,
      required this.price,
      required this.numArticles,
      required this.location,
      this.orders});
}

List<Order> orders = [
  Order(
      name: 'Habibi',
      pathImage: habibi,
      company: 'Dyshez Direct',
      date: DateTime(2024, 06, 13),
      status: OrderStatus.success,
      iconPath: item1,
      price: 480.00,
      numArticles: 3,
      location: 'Benito Juárez #213',
      orders: [
        IndivudualOrder(
            name: 'Pizza italiana',
            originalPrice: 320,
            priceDiscount: 240,
            amount: 2),
        IndivudualOrder(
            name: 'Rebanada de pastel de chocolate',
            originalPrice: 410,
            priceDiscount: 340,
            amount: 3),
        IndivudualOrder(
            name: 'Refresco de 1lt',
            originalPrice: 52,
            priceDiscount: 40,
            amount: 1)
      ]),
  Order(
      name: 'Boston´s Pizza',
      pathImage: bostonsPizza,
      company: 'Promo Live',
      date: DateTime(2024, 06, 24),
      status: OrderStatus.error,
      iconPath: item2,
      price: 500.00,
      numArticles: 3,
      location: 'Plan de Ayála #101',
      orders: [
        IndivudualOrder(
            name: 'Pizza italiana',
            originalPrice: 320,
            priceDiscount: 240,
            amount: 2),
        IndivudualOrder(
            name: 'Rebanada de pastel de chocolate',
            originalPrice: 410,
            priceDiscount: 340,
            amount: 3),
        IndivudualOrder(
            name: 'Refresco de 1lt',
            originalPrice: 52,
            priceDiscount: 40,
            amount: 1)
      ])
];

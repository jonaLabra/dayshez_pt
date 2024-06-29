import 'package:dayshez_pt/models/individual_order.dart';
import 'package:dayshez_pt/utils.dart';

class MathOperations {
  double total = 0.0;

  double getTotalArticle(List<IndivudualOrder>? orders) {
    for (var price in orders!) {
      total += price.originalPrice!.toDouble();
    }
    return total;
  }

  double getTotalPaid() {
    double totalPaid = ((total - discountPrice) + sendPrice + tipPrice);
    return totalPaid;
  }
}

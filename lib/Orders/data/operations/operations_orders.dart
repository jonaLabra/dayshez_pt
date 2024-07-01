import 'package:dayshez_pt/Orders/domain/entities/individual_order.dart';
import 'package:dayshez_pt/core/utils.dart';

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

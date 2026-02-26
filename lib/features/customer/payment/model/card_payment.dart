import 'package:e_commerce/features/customer/payment/domain/brand.dart';

class CardPayment {
  final String id;
  final String cardHolderName;
  final String last4;
  final String expMonth;
  final String expYear;
  final Brand brand;
  final bool active;

  const CardPayment({
    required this.id,
    required this.cardHolderName,
    required this.last4,
    required this.expMonth,
    required this.expYear,
    required this.brand,
    required this.active,
  });

  String get hiddenNumber => "**** **** **** $last4";

  String get expirationDate => "$expMonth/$expYear";

  CardPayment copyWith({
    String? id,
    String? cardHolderName,
    String? last4,
    String? expMonth,
    String? expYear,
    Brand? brand,
    bool? active,
  }) {
    return CardPayment(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      last4: last4 ?? this.last4,
      expMonth: expMonth ?? this.expMonth,
      expYear: expYear ?? this.expYear,
      brand: brand ?? this.brand,
      active: active ?? this.active,
    );
  }
}

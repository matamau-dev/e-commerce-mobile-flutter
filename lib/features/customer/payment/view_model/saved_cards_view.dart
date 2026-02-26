import 'package:e_commerce/features/customer/payment/domain/brand.dart';
import 'package:e_commerce/features/customer/payment/model/card_payment.dart';

final List<CardPayment> misTarjetasFalsas = [
  const CardPayment(
    id: "1",
    cardHolderName: "MAURICIO Visa.",
    last4: "4242",
    expMonth: "12",
    expYear: "29",
    brand: Brand.visa,
    active: true,
  ),

  const CardPayment(
    id: "2",
    cardHolderName: "MAURICIO Mastercard.",
    last4: "8888",
    expMonth: "05",
    expYear: "30",
    brand: Brand.mastercard,
    active: false,
  ),
  const CardPayment(
    id: "3",
    cardHolderName: "MAURICIO AMEX.",
    last4: "8888",
    expMonth: "05",
    expYear: "30",
    brand: Brand.amex,
    active: false,
  ),
  const CardPayment(
    id: "4",
    cardHolderName: "MAURICIO OTHER.",
    last4: "8888",
    expMonth: "05",
    expYear: "30",
    brand: Brand.other,
    active: false,
  ),
];

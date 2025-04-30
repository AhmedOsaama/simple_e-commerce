import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:simple_ecommerce/core/api_keys.dart';

import '../../features/checkout/data/models/payment_models/EphemeralKey.dart';
import '../../features/checkout/data/models/payment_models/PaymentIntent.dart' as model;
import '../../features/checkout/data/models/payment_models/PaymentIntentInput.dart';

class StripeService {
  Future<model.PaymentIntent> createPaymentIntent(PaymentIntentInput paymentIntentInput) async {
    var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'), body: paymentIntentInput.toJson(), headers: {
      "content-type": Headers.formUrlEncodedContentType,
        "Authorization": "Bearer ${ApiKeys.stripeSecretKey}"
    });
    log("Response: ${response.body}");

    var paymentIntent = model.PaymentIntent.fromJson(jsonDecode(response.body));
    return paymentIntent;
  }

  Future<void> initPaymentSheet({required String paymentIntentClientSecret, required String customerEphemeralKeySecret, required String customerId}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            customerId: customerId,
            customerEphemeralKeySecret: customerEphemeralKeySecret,
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: "Ahmed"));
  }

  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment(PaymentIntentInput paymentIntentInput) async {
    var paymentIntent = await createPaymentIntent(paymentIntentInput);
    var ephemeralKey = await createEphemeralKey(paymentIntentInput.customerId);
    log(paymentIntent.toJson().toString());
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntent.clientSecret!,
        customerEphemeralKeySecret: ephemeralKey.secret!,
        customerId: 'cus_Pt8oZDyGcyDHJB'
    );
    await displayPaymentSheet();
  }

  Future<EphemeralKey> createEphemeralKey(String customerId) async {
    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/ephemeral_keys'),
        body: {
          'customer': customerId,
        },
        headers: {
          // "content-type": Headers.jsonContentType,
      "Authorization": "Bearer ${ApiKeys.stripeSecretKey}",
      "Stripe-Version": "2023-10-16"
    });

    // var response = await apiService.post(
    //     url: 'https://api.stripe.com/v1/ephemeral_keys',
    //     stripeVersion: "2023-10-16",
    //     body: {
    //       'customer': customerId,
    //     },
    //     token: ApiKeys.stripeSecretKey);

    var ephemeralKey = EphemeralKey.fromJson(jsonDecode(response.body));
    return ephemeralKey;
  }
}

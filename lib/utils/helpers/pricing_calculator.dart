import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PricingCalculator {
  /// -- Calculate Price Based On Tax & Shipping
  static Future<Map<String, String>> calculatePriceBreakdown(
      double productPrice, String location) async {
    double taxRate = await getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = await getShippingCost(location);
    double totalPrice = productPrice + taxAmount + shippingCost;

    return {
      'tax': taxAmount.toStringAsFixed(2),
      'shipping': shippingCost.toStringAsFixed(2),
      'total': totalPrice.toStringAsFixed(2),
    };
  }

  /// -- Calculate Shipping Cost
  static Future<String> calculateShippingCost(
      double productPrice, String location) async {
    double shippingCost = await getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// -- Calculate tax
  static Future<String> calculateTax(
      double productPrice, String location) async {
    double taxRate = await getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static Future<double> getTaxRateForLocation(String location) async {
    // You can use services like:
    // 1. Avalara (https://www.avalara.com/us/en/products/calculations/avatax-calculator.html)
    // 2. TaxJar (https://www.taxjar.com/api/)
    // 3. Vertex (https://www.vertexinc.com/solutions/products/vertex-o-series/)

    try {
      final apiKey = dotenv.env['TAXJAR_API_KEY'];
      final client = http.Client();
      final response = await client.get(
        Uri.parse('https://api.taxjar.com/v2/rates/${location}'),
        headers: {
          'Authorization': 'Token token="$apiKey"',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['rate']['combined_rate'];
      }

      return 0.10;
    } catch (e) {
      return 0.10;
    }
  }

  static Future<double> getShippingCost(String location) async {
    try {
      final apiKey = dotenv.env['SHIPPO_API_KEY'] ?? '';
      final client = http.Client();
      final response = await client.post(
        Uri.parse('https://api.goshippo.com/shipments/'),
        headers: {
          'Authorization': 'ShippoToken $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'address_from': {
            'zip': '78756',
            'country': 'US',
          },
          'address_to': {
            'zip': location,
            'country': 'US',
          },
          'parcels': [
            {'weight': 1.0, 'mass_unit': 'lb'}
          ],
          'async': false
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rate = data['rates'][0];
        return double.parse(rate['amount']);
      }

      return 5.00;
    } catch (e) {
      return 5.00;
    }
  }

  /// -- Sum all cart values and return total amount
  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  // }
}

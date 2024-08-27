import 'package:banquetbookz_vendor/Providers/auth.dart';
import 'package:banquetbookz_vendor/models/new_subscriptionplan.dart';
import 'package:banquetbookz_vendor/providers/authprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:banquetbookz_vendor/utils/bbapi.dart';
import 'package:http/http.dart' as http;

class SubscriptionRepository {
  final Ref ref;
  SubscriptionRepository(this.ref);

  final String _baseUrl = 'http://93.127.172.164:8080/api/subscription-plans/';

  Future<List<SubscriptionPlan>> fetchSubscriptionPlans() async {
    try {
      final authState = ref.watch(authprovider); // Accessing the AuthNotifier
      final token = authState.token;

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token', // Use the token from AuthNotifier
        },
      );

      print('Access Token for Subscription screen: $token');
      print('Response Body: ${response.body}');
      print('Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print('Full Response: $jsonResponse');

        List<SubscriptionPlan> subscriptionPlans = [];

        jsonResponse.forEach((key, value) {
          List<dynamic> plansJson = value as List<dynamic>;
          subscriptionPlans.addAll(
            plansJson.map((data) => SubscriptionPlan.fromJson(data)).toList(),
          );
        });

        if (subscriptionPlans.isEmpty) {
          print('No subscription data found');
        }

        return subscriptionPlans;
      } else {
        print('Error fetching subscriptions: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return SubscriptionRepository(ref);
});

final subscriptionPlansProvider =
    FutureProvider<List<SubscriptionPlan>>((ref) async {
  final repository = ref.read(subscriptionRepositoryProvider);
  return repository.fetchSubscriptionPlans();
});

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sales_app/services/constant.dart';
import '../models/item.dart';

class ItemService {
  String baseUrlItems = '$baseUrl/items';

  Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse(baseUrlItems));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Item> items = body.map((dynamic item) => Item.fromJson(item)).toList();
      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> createItem(Item item) async {
    final response = await http.post(
      headers: <String, String>{ 
        'Content-Type': 'application/json; charset=UTF-8', 
      },
      Uri.parse(baseUrlItems),
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 200) {
      print(response.body);
      // return Item.fromJson(json.decode(response.body));
      return;
    } else {
      throw Exception('Failed to create item');
    }
  }

  Future<Item> updateItem(String id, Item item) async {
    final response = await http.put(
      Uri.parse('$baseUrlItems/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.parse('$baseUrlItems/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}

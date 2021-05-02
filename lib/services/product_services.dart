part of 'services.dart';

class ProductServices {
  static Future<List<Product>> getproduct() async {
    String _url =
        "https://ranting.twisdev.com/index.php/rest/items/search/api_key/teampsisthebest/";
    var apiResult = await http.post(_url);
    var data = json.decode(apiResult.body);
    return data
        .map<Product>((item) => Product(
            id: item['id'],
            title: item["title"],
            location: item["location_name"],
            merchant: item["added_user_name"],
            photo: item["default_photo"]["img_path"],
            price: int.parse(item["price"]),
            ishalal: item["is_halal"],
            category: item["category"]["cat_name"],
            stock: item["stock"],
            weight: item["weight"]))
        .toList();
  }
}

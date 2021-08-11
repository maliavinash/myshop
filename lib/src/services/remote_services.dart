import 'package:http/http.dart' as http;
import 'package:myshop/src/models/product.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<Product> fetchProducts() async {
    var response = await client.get(Uri.parse(
        'https://stark-spire-93433.herokuapp.com/json'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
import 'package:get/state_manager.dart';
import 'package:myshop/src/models/product.dart';
import 'package:myshop/src/services/remote_services.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = List<Category>().obs;
  var rankingList = List<Ranking>().obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        categoryList.value = products.categories;
        rankingList.value = products.rankings;
      }
    } finally {
      isLoading(false);
    }
  }
}

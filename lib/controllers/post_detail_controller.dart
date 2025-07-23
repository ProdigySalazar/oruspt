import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostDetailController extends GetxController {
  final int postId;

  PostDetailController(this.postId);

  RxBool isLoading = true.obs;
  RxString title = ''.obs;
  RxString body = ''.obs;
  RxString? error;

  @override
  void onInit() {
    super.onInit();
    fetchPostDetail();
  }

  Future<void> fetchPostDetail() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'),
        headers: {'Accept': 'application/json', 'User-Agent': 'FlutterApp/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        title.value = data['title'];
        body.value = data['body'];
        isLoading.value = false;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      error = e.toString().obs;
      isLoading.value = false;
    }
  }
}

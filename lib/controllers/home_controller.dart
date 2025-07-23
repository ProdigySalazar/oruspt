import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oruspt/models/PostModel.dart';

class HomeController extends GetxController {
  RxList<dynamic> allPosts = <dynamic>[].obs;
  RxList<dynamic> filteredPosts = <dynamic>[].obs;

  RxInt currentPage = 0.obs;
  RxInt rowsPerPage = 10.obs;
  RxString searchTerm = ''.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Accept': 'application/json', 'User-Agent': 'FlutterApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        allPosts.value = data;
        applyFilter();
        isLoading.value = false;
      } else {
        throw Exception('Error en la respuesta: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      Get.defaultDialog(
        title: 'Error',
        content: Text('No se pudieron cargar los datos.\n$e'),
      );
    }
  }

  void applyFilter() {
    final term = searchTerm.value.toLowerCase();
    filteredPosts.value = allPosts.where((post) {
      return post['title'].toString().toLowerCase().contains(term) ||
          post['body'].toString().toLowerCase().contains(term);
    }).toList();
    currentPage.value = 0;
  }

  List<PostModel> getCurrentPagePostModels() {
    final startIndex = currentPage.value * rowsPerPage.value;
    final endIndex = (startIndex + rowsPerPage.value) > filteredPosts.length
        ? filteredPosts.length
        : (startIndex + rowsPerPage.value);

    return filteredPosts.sublist(startIndex, endIndex).map<PostModel>((post) {
      return PostModel(
        id: post['id'],
        title: post['title'],
        body: post['body'],
      );
    }).toList();
  }

  void showBodyDialog(BuildContext context, String fullBody) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contenido completo',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                fullBody,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.indigo.shade50,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cerrar',
                    style: GoogleFonts.montserrat(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

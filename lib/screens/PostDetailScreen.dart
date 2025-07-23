import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruspt/controllers/post_detail_controller.dart';
import 'package:oruspt/widgets/MyLoaderWidget.dart';
import 'package:oruspt/widgets/PostDetailCard.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  const PostDetailScreen({super.key, required this.postId});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostDetailController(postId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black87,
              size: 22,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        title: Text(
          '📖 Detalle del Post',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Opacity(
                  opacity: 0.06,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 160,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: MyLoaderWidget());
                }

                if (controller.error != null) {
                  return Center(
                    child: Text(
                      'Error: ${controller.error!.value}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.red.shade700,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.90),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: PostDetailCard(
                      title: controller.title.value,
                      body: controller.body.value,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

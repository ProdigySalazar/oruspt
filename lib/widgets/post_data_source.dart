import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruspt/controllers/home_controller.dart';
import 'package:oruspt/models/PostModel.dart';
import 'package:oruspt/screens/PostDetailScreen.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PostDataSource extends DataGridSource {
  final List<PostModel> posts;

  PostDataSource({required this.posts}) {
    _rows = posts
        .map(
          (post) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'ID', value: post.id),
              DataGridCell<String>(columnName: 'Título', value: post.title),
              DataGridCell<String>(
                columnName: 'Body',
                value: post.body.length > 10
                    ? post.body.substring(0, 10)
                    : post.body,
              ),
              DataGridCell<int>(columnName: 'Detalle', value: post.id), // 👁️
            ],
          ),
        )
        .toList();
  }

  late final List<DataGridRow> _rows;

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final id = row.getCells()[0].value;
    final post = posts.firstWhere((p) => p.id == id);
    final controller = Get.find<HomeController>();

    return DataGridRowAdapter(
      cells: [
        _buildTextCell(id.toString(), alignment: Alignment.center),
        _buildTextCell(
          post.title.length > 10
              ? '${post.title.substring(0, 10)}...'
              : post.title,
        ),
        GestureDetector(
          onTap: () => controller.showBodyDialog(Get.context!, post.body),
          child: _buildTextCell(
            post.body.length > 10
                ? '${post.body.substring(0, 10)}...'
                : post.body,
            color: Colors.indigo,
          ),
        ),
        Center(
          child: IconButton(
            icon: const Icon(
              Icons.remove_red_eye,
              color: Colors.indigo,
              size: 18,
            ),
            tooltip: 'Ver detalle',
            onPressed: () {
              Get.to(() => PostDetailScreen(postId: id));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextCell(
    String text, {
    Color? color,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: GoogleFonts.montserrat(
          fontSize: 13,
          color: color ?? Colors.grey.shade900,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruspt/controllers/home_controller.dart';
import 'package:oruspt/widgets/post_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Mytable extends StatelessWidget {
  const Mytable({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Opacity(
                  opacity: 0.06,
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                  ),
                ),
              ),
            ),

            Obx(
              () => SfDataGrid(
                rowHeight: 50,
                headerRowHeight: 50,
                gridLinesVisibility: GridLinesVisibility.vertical,
                headerGridLinesVisibility: GridLinesVisibility.horizontal,
                columnWidthMode: ColumnWidthMode.fill,
                columnWidthCalculationRange:
                    ColumnWidthCalculationRange.allRows,
                source: PostDataSource(
                  posts: controller.getCurrentPagePostModels(),
                ),
                columns: [
                  _buildHeaderColumn(
                    'ID',
                    alignment: Alignment.center,
                    width: 50,
                  ),
                  _buildHeaderColumn('Título', alignment: Alignment.centerLeft),
                  _buildHeaderColumn('Body', alignment: Alignment.centerLeft),
                  _buildHeaderColumn(
                    '',
                    alignment: Alignment.center,
                    width: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridColumn _buildHeaderColumn(
    String label, {
    required Alignment alignment,
    double? width,
  }) {
    final Widget cell = Container(
      alignment: alignment,
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        label.isNotEmpty ? label : '👁️',
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.grey.shade800,
        ),
      ),
    );

    if (width != null) {
      return GridColumn(columnName: label, width: width, label: cell);
    } else {
      return GridColumn(columnName: label, label: cell);
    }
  }
}

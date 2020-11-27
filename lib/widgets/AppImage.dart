import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:flutter/cupertino.dart';

class AppImage extends StatelessWidget {
  final String sourceName;

  AppImage(this.sourceName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage(ChooseCategory.PACKAGE_NAME+sourceName+".png"))
    );
  }
}

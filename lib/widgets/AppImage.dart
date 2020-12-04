import 'package:expense_manager/choose_category/choose_category.dart';
import 'package:flutter/cupertino.dart';

class AppImage extends StatelessWidget {
  final String sourceName;

  AppImage(this.sourceName);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
        height: 30,
      child: Image(image: AssetImage(ChooseCategory.PACKAGE_NAME+sourceName+".png"))
    );
  }
}

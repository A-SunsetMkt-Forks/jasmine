import 'package:flutter/material.dart';
import 'package:jasmine/basic/commons.dart';
import 'package:jasmine/basic/methods.dart';

const _propertyName = "auto_clean";
late String autoClean;

Map<String, String> _nameMap = {
  (3600 * 24).toString(): "一天",
  (3600 * 24 * 7).toString(): "一周",
  (3600 * 24 * 30).toString(): "一月",
  (3600 * 24 * 30 * 12).toString(): "一年",
};

Future initAutoClean() async {
  autoClean = await methods.loadProperty(_propertyName);
  if (autoClean.isEmpty) {
    autoClean = (3600 * 24 * 7).toString();
    await methods.saveProperty(_propertyName, autoClean);
  }
}

String autoCleanName() {
  return _nameMap[autoClean] ?? "-";
}

Future chooseAutoClean(BuildContext context) async {
  String? choose = await chooseMapDialog(context,
      title: "选择自动清理时间",
      values: _nameMap.map((key, value) => MapEntry(value, key)));
  if (choose != null) {
    await methods.saveProperty(_propertyName, choose);
    autoClean = choose;
  }
}

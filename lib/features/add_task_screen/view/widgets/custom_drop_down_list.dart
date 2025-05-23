import 'package:flutter/material.dart';
import 'package:todoapp/core/widgets/custom_svg.dart';

DropdownMenuItem customDropDownList({
  required String iconPath,
  required Color icontainerIconBGC,
  required String textType,
  required int itemValue,
}) {
  return DropdownMenuItem(
    value: itemValue,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 28,
            height: 28,
            // padding: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: icontainerIconBGC,
            ),
            child: CustomSvg(assetPath: iconPath, width: 26, height: 26),
          ),
        ),
        Text(
          textType,
          style: TextStyle(color: Color.fromARGB(255, 10, 10, 10)),
        ),
      ],
    ),
  );
}

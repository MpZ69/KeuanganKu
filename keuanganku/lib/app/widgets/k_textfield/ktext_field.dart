import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/k_typedef.dart';

class KTextField extends StatelessWidget {
  const KTextField({
    super.key,
    required this.fieldController,
    required this.fieldName,
    required this.prefixIconColor,
    this.icon,
    this.keyboardType,
    this.readOnly,
    this.onTap,
    this.textHint
  }
  );

  final String fieldName;
  final String? textHint;
  final IconData? icon;
  final Color prefixIconColor;
  final TextEditingController fieldController;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function()? onTap;

  KFormWidget fieldUsername(){
    return TextFormField(
      controller: fieldController,
      keyboardType: keyboardType,
      readOnly: readOnly?? false,
      onTap: onTap,
      style: const TextStyle(
        fontFamily: "QuickSand_Medium",
      ),
      decoration: InputDecoration(
          hintText: textHint ?? "Ketik ${fieldName.toLowerCase()}...",
          labelText: fieldName,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon, color: prefixIconColor,),
          labelStyle: const TextStyle(color: KColors.primary)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  
      SingleChildScrollView(
        child: fieldUsername()
      );
  }
}
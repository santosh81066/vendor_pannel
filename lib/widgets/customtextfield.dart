import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.labelText,
      this.hintText,
      this.width,
      this.onPressed,
      this.textController,
      this.applyDecoration = true,
      this.validator,
      this.suffixIcon,
      this.readOnly = false,
      this.secureText = false,
      this.prefix,
      this.prefixIcon,
      this.keyBoardType,
      this.filled,
      this.onChanged,
      this.filledColor,
      this.onSuffixIconTap,
      this.focusNode, // Add onChanged callback
      });

  final String? labelText;
  final String? hintText;
  final bool secureText;
  final bool readOnly;
  final double? width;
  final VoidCallback? onPressed;
  final TextEditingController? textController;
  final bool applyDecoration;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? prefix;
  final IconData? prefixIcon;
  final TextInputType? keyBoardType;
  final bool? filled;
  final Color? filledColor;
  final FocusNode? focusNode;
  final VoidCallback? onSuffixIconTap;
  final Function(String)? onChanged; // Add onChanged property

  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(
            width: width ?? screenWidth,
          child: TextFormField(
            focusNode: focusNode,
            obscureText: secureText,
            readOnly: readOnly,
            keyboardType: keyBoardType,
            onTap: onPressed,
            controller: textController,

            onChanged: onChanged, // Use onChanged callback
            cursorColor: const Color(0XFF330099),
            decoration: applyDecoration
                ? InputDecoration(
                    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                    filled: filled, // Don't forget to set this to true
                    fillColor: filledColor, // Use the shade of grey you prefer

                    prefixText: prefix,
                    prefixStyle: const TextStyle(color: Color(0XFF330099)),
                    suffixIcon:suffixIcon != null? InkWell(
            onTap: onSuffixIconTap,
            child: suffixIcon!,
          ) : null,
                     // Check for null
                    labelText: labelText,
                    hintText: hintText,
                    hintStyle: const TextStyle(color: Color(0xFFb4b4b4)),
                    labelStyle: const TextStyle(
                      color: Color(0xFFCCCCCC),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFF6418c3),
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 238, 237, 237),
                        width: 2.0,
                      ),
                    ),
                    focusColor: Colors.white,
                  )
                : InputDecoration(labelText: labelText),
            style: const TextStyle(color: Color(0XFF6418C3)),
            validator: validator,
          ),
        ),
      ],
    );
  }
}

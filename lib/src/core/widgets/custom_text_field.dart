import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../utils/app_constants.dart';
import 'custom_text.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.textEditingController,
    this.focusNode,
    this.title,
    this.titleStyle,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputTextStyle,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.minLines,
    this.validator,
    this.hintText = 'Type here',
    this.hintStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.isPassword = false,
    this.readOnly = false,
    this.isEnable = true,
    this.isRequired = false,
    this.maxLength,
    this.borderRadius,
    this.fillColor = Colors.white,
    this.borderColor,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
    this.height,
    this.isCollapsed,
    this.isDense,
    this.inputFormatters,
    this.onTap,
  });

  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String? title;
  final TextStyle? titleStyle;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final int? minLines;
  final double? borderRadius;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FormFieldValidator? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool? isEnable;
  final bool? isRequired;
  final EdgeInsetsGeometry contentPadding;
  final bool readOnly;
  final double? height;
  final int? maxLength;
  final bool? isCollapsed;
  final bool? isDense;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;
  final double _radius = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Row(
            children: [
              Text(
                widget.title!,
                style:
                    widget.titleStyle ??
                    Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.kTextColor,
                    ),
              ),
              if (widget.isRequired == true)
                const CustomText('*', color: AppColors.kRedColor),
            ],
          ),
          space8H,
        ],
        SizedBox(
          height: widget.height,
          child: TextFormField(
            textAlign: widget.textAlign,
            onTap: widget.onTap,
            enabled: widget.isEnable,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: widget.inputFormatters,
            onFieldSubmitted: widget.onFieldSubmitted,
            readOnly: widget.readOnly,
            controller: widget.textEditingController,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            cursorColor: AppColors.kPrimaryColor,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            style:
                widget.inputTextStyle ??
                Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.kTextColor),
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            obscureText: widget.isPassword ? _obscure : false,
            validator: (v) {
              final trimmed = v?.trim();
              if (widget.validator != null) return widget.validator!(trimmed);
              if (widget.isRequired == true &&
                  (trimmed == null || trimmed.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              fillColor: widget.fillColor,
              filled: true,
              isCollapsed: widget.isCollapsed,
              isDense: widget.isDense,
              errorMaxLines: 2,
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ??
                  Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.kTextColor.withValues(alpha: 0.5),
                  ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(
                        _obscure
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        size: 20,
                        color: AppColors.kTextColor,
                      ),
                    )
                  : widget.suffixIcon,
              disabledBorder: _border(
                widget.borderColor ?? AppColors.kAccentColor,
              ),
              border: _border(widget.borderColor ?? AppColors.kAccentColor),
              enabledBorder: _border(
                widget.borderColor ?? AppColors.kAccentColor,
              ),
              focusedBorder: _border(
                widget.borderColor ?? AppColors.kPrimaryColor,
                width: 1,
              ),
              errorBorder: _border(AppColors.kRedColor, width: 1),
              focusedErrorBorder: _border(AppColors.kRedColor, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? _radius),
        borderSide: BorderSide(color: color, width: width),
      );
}

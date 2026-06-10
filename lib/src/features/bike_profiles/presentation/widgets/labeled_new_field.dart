
import '../../../../src_export.dart';

class LabeledInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<dynamic>? validator;

  const LabeledInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textEditingController: controller,
      hintText: hint,
      title: label,
      isRequired: true, // This triggers the built-in "This field is required" logic
      validator: validator,
      inputTextStyle: const TextStyle(
        fontSize: 13,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
      fillColor: Colors.transparent,
      hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white.withOpacity(0.5)),
    );
  }
}
part of 'widget.dart';

class CustomPasswordFormField extends StatefulWidget {
  final TextEditingController? editingController;

  const CustomPasswordFormField({super.key, this.editingController});

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.passwordTitleForm,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.editingController,
          obscureText: isObscure,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.hintTextForm(
                  AppLocalizations.of(context)!.passwordTitleForm),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                    isObscure ? MdiIcons.eyeOffOutline : MdiIcons.eyeOutline),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.textFormCannotBeEmpty(
                  AppLocalizations.of(context)!.passwordTitleForm);
            }
            if (value.length < 7) return AppLocalizations.of(context)!.passwordMinimumDigit;
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

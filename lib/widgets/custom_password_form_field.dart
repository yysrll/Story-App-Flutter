part of 'widget.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
  });

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
        const Text(
          'Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: isObscure,
          decoration: InputDecoration(
              hintText: 'Masukkan password',
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
              return 'Password tidak boleh kosong';
            }
            if (value.length < 7) return 'Password minimal 6 huruf';
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

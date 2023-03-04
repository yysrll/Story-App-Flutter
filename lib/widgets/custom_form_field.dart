part of 'widget.dart';

class CustomFormField extends StatelessWidget {

  final String title;
  final TextEditingController? editingController;

  const CustomFormField({
    super.key,
    required this.title,
    this.editingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: editingController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Masukkan ${title.toLowerCase()}'
          ),
          validator: (String? value) {
            if(value == null || value.isEmpty) {
              return '$title tidak boleh kosong';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
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
            hintText: AppLocalizations.of(context)!.hintTextForm(title.toLowerCase())
          ),
          validator: (String? value) {
            if(value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.textFormCannotBeEmpty(title);
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
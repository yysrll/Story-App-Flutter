part of 'screen.dart';

class AddStoryScreen extends StatefulWidget {
  final Function() onSubmit;

  const AddStoryScreen({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Add Story',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: context.watch<StoryProvider>().imagePath == null
                    ? const Icon(
                        Icons.image,
                        size: 100,
                      )
                    : _showImage(),
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: formKey,
              child: CustomFormField(
                title: 'Deskripsi',
                editingController: descController,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () => _onGalleryView(),
                      icon: const Icon(MdiIcons.image),
                      label: const Text('Gallery'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () => _onCameraView(),
                      icon: const Icon(MdiIcons.camera),
                      label: const Text('Camera'),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 50,
              child: context.read<StoryProvider>().isUploadLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _uploadStory();
                        }
                      },
                      child: const Text('Submit')),
            ),
            const SizedBox(height: 32)
          ],
        ),
      ),
    );
  }

  _onGalleryView() async {
    final provider = context.read<StoryProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<StoryProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.watch<StoryProvider>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }

  _uploadStory() async {
    final scaffold = ScaffoldMessenger.of(context);
    final prov = context.read<StoryProvider>();
    final imagePath = prov.imagePath;
    final image = prov.imageFile;
    if (imagePath == null || image == null) {
      scaffold.showSnackBar(const SnackBar(content: Text("Gambar tidak boleh kosong")));
      return;
    }

    final fileName = image.name;
    final bytes = await image.readAsBytes();
    final description = descController.text;

    await Utils().compressImage(bytes);
    final result = await prov.uploadStory(bytes, fileName, description);
    if (result) {
      widget.onSubmit();
      prov.getStories();
    } else {
      scaffold.showSnackBar(SnackBar(content: Text(prov.message)));
    }
  }

  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }
}

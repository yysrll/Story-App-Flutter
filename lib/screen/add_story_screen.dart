part of 'screen.dart';

class AddStoryScreen extends StatefulWidget {
  final Function() onSubmit;
  final Function() onPickLocation;

  const AddStoryScreen(
      {super.key, required this.onSubmit, required this.onPickLocation});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();

  double? latitude;
  double? longitude;
  String? infoLocation;

  void getMyLocation() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("service tidak ada");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("permission ditolak");
        return;
      }
    }

    locationData = await location.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;

    getInfoLocation();
  }

  void getInfoLocation() async {
    final info = await geo.placemarkFromCoordinates(latitude!, longitude!);
    setState(() {
      infoLocation = "${info[0].locality}, ${info[0].country}";
    });
  }

  @override
  void initState() {
    super.initState();
    getMyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: AppLocalizations.of(context)!.addStory,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.location,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      infoLocation ??
                          AppLocalizations.of(context)!.locationNotFound,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      widget.onPickLocation();
                      final dataFromMapPicker = await context
                          .read<PageLocationManager<String>>()
                          .waitForResult();
                      latitude = dataFromMapPicker.latitude;
                      longitude = dataFromMapPicker.longitude;
                      getInfoLocation();
                    },
                    icon: const Icon(Icons.location_pin))
              ],
            ),
            const SizedBox(height: 8),
            Form(
              key: formKey,
              child: CustomFormField(
                title: AppLocalizations.of(context)!.descriptionTitleForm,
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
                      label: Text(AppLocalizations.of(context)!.gallery),
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
                      label: Text(AppLocalizations.of(context)!.camera),
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
                      child: Text(AppLocalizations.of(context)!.submit)),
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
      scaffold.showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.imageCannotBeEmpty)));
      return;
    }

    final fileName = image.name;
    final bytes = await image.readAsBytes();
    final description = descController.text;

    final imageBytes = await Utils().compressImage(bytes);
    final result = await prov.uploadStory(imageBytes, fileName, description,
        latitude: latitude, longitude: longitude);
    if (result) {
      widget.onSubmit();
      prov.pageItems = 1;
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

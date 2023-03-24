part of 'screen.dart';

class MapPickerScreen extends StatefulWidget {
  final Function() onSelectLocation;
  const MapPickerScreen({
    super.key,
    required this.onSelectLocation,
  });

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  LatLng? selectedLocation;
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  String infoLocation = "";

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: AppLocalizations.of(context)!.chooseLocation,
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            initialCameraPosition: CameraPosition(
              zoom: 18,
              target: dicodingOffice,
            ),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            onLongPress: (LatLng latLng) {
              onLongPressGoogleMap(latLng);
            },
            zoomControlsEnabled: false,
            myLocationEnabled: true,
          ),
          if (selectedLocation != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 16,
                        offset: Offset.zero,
                        color: Colors.grey.withOpacity(0.5)),
                  ],
                ),
                child: Column(
                  children: [
                    Text(infoLocation),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.onSelectLocation();
                        context
                            .read<PageLocationManager<String>>()
                            .returnData(selectedLocation!);
                      },
                      child: Text(AppLocalizations.of(context)!.chooseLocation),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    setState(() {
      infoLocation = AppLocalizations.of(context)!.loading;
    });
    defineMarker(latLng);
    getInfoLocation(latLng);
    selectedLocation = latLng;

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void defineMarker(LatLng latLng) {
    final marker = Marker(
      markerId: const MarkerId("markerId"),
      position: latLng,
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void getInfoLocation(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    setState(() {
      infoLocation = "${info[0].locality}, ${info[0].country}";
    });
  }
}

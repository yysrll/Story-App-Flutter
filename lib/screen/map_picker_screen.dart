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
              child: ElevatedButton(
                onPressed: () {
                  widget.onSelectLocation();
                  context
                      .read<PageLocationManager<String>>()
                      .returnData(selectedLocation!);
                },
                child: Text(AppLocalizations.of(context)!.chooseLocation),
              ),
            ),
        ],
      ),
    );
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    defineMarker(latLng);
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
}

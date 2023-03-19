part of 'screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Map",
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 18,
          target: dicodingOffice,
        ),
      ),
    );
  }
}

part of 'screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final List<Story> stories = [];
  Story? selectedStory;

  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);

  void addMarker() async {
    final res = await context.read<StoryProvider>().getStoriesWithLocation();
    stories.addAll(res);
    for (var story in stories) {
      final position = LatLng(story.lat!.toDouble(), story.lon!.toDouble());
      markers.add(Marker(
          markerId: MarkerId(story.id),
          position: position,
          onTap: () {
            mapController
                .animateCamera(CameraUpdate.newLatLngZoom(position, 18));
            setState(() {
              selectedStory = story;
            });
          }));
    }

    final bound = boundFromStories(stories);
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bound, 50),
    );
    setState(() {});
  }

  LatLngBounds boundFromStories(List<Story> stories) {
    double? x0, x1, y0, y1;
    for (var story in stories) {
      final lat = story.lat!.toDouble();
      final lon = story.lon!.toDouble();
      if (x0 == null) {
        x0 = x1 = lat;
        y0 = y1 = lon;
      } else {
        if (lat > x1!) x1 = lat;
        if (lat < x0) x0 = lat;
        if (lat > y1!) y1 = lon;
        if (lat < y0!) y0 = lon;
      }
    }
    return LatLngBounds(
      southwest: LatLng(x0!, y0!),
      northeast: LatLng(x1!, y1!),
    );
  }

  @override
  void initState() {
    super.initState();
    addMarker();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: AppLocalizations.of(context)!.map,
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
            zoomControlsEnabled: false,
          ),
          if (selectedStory != null)
            Positioned(
              right: 16,
              left: 16,
              bottom: 16,
              child: PlaceMark(
                story: selectedStory!,
              ),
            )
          else
            const SizedBox(),
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: "zoom-in",
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomIn());
                  },
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton.small(
                  heroTag: "zoom-out",
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.zoomOut());
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

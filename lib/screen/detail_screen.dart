part of 'screen.dart';

class DetailScreen extends StatefulWidget {
  final Story story;
  const DetailScreen({
    super.key,
    required this.story,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late GoogleMapController mapController;
  late LatLng position;
  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    if (widget.story.lat != null) {
      position = LatLng(
        widget.story.lat! as double,
        widget.story.lon! as double,
      );
      markers.add(Marker(
        markerId: MarkerId(widget.story.id),
        position: position,
        onTap: () {
          mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 18));
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: AppLocalizations.of(context)!.story,
        body: (widget.story.lat != null)
            ? detailWithMap(context)
            : detailWithoutMap(context));
  }

  Widget detailWithMap(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          initialCameraPosition: CameraPosition(
            zoom: 18,
            target: position,
          ),
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          zoomControlsEnabled: false,
        ),
        Positioned(
          right: 16,
          left: 16,
          bottom: 16,
          child: PlaceMark(
            story: widget.story,
          ),
        )
      ],
    );
  }

  Widget detailWithoutMap(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/placeholder_image.jpeg',
            image: widget.story.photoUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.blue,
            ),
            child: Text(
              AppLocalizations.of(context)!
                  .createdAtByName(widget.story.createdAt, widget.story.name),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, left: 16, bottom: 32),
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Text(
              widget.story.description.trim(),
            ),
          ),
        ],
      ),
    );
  }
}

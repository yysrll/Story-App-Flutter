part of 'widget.dart';

class PlaceMark extends StatelessWidget {
  final Story story;
  const PlaceMark({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32),
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
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder_image.jpeg',
              image: story.photoUrl,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            Text(
              story.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              story.createdAt,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              story.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ));
  }
}

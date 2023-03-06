part of 'screen.dart';

class DetailScreen extends StatelessWidget {
  final Story story;
  const DetailScreen({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: AppLocalizations.of(context)!.story,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder_image.jpeg',
              image: story.photoUrl,
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
                AppLocalizations.of(context)!.createdAtByName(story.createdAt, story.name),
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
                story.description.trim(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

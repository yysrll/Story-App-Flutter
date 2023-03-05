part of 'widget.dart';

class StoryCard extends StatelessWidget {
  final Story story;
  final Function onTap;

  const StoryCard({
    Key? key,
    required this.story,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/placeholder_image.jpeg',
            image: story.photoUrl,
            width: MediaQuery.of(context).size.width,
            height: 300,
            fit: BoxFit.fill,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 16, bottom: 6, left: 16),
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                text: '${story.name}   ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: story.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 8, left: 16),
            child: Text(
              story.createdAt,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

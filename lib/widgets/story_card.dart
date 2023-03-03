part of 'widget.dart';

class StoryCard extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;

  const StoryCard({
    Key? key,
    required this.title,
    required this.description,
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
          ClipRRect(
            child: Image.network(
              "https://picsum.photos/200/300",
              width: MediaQuery.of(context).size.width,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, right: 16, bottom: 6, left: 16),
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                text: '$title   ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: description,
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
              '2 Maret 2023 18:12',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

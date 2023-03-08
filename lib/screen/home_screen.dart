part of 'screen.dart';

class HomeScreen extends StatefulWidget {
  final Function() onLogout;
  final Function(Story) onDetail;
  final Function() onPost;

  const HomeScreen({
    Key? key,
    required this.onLogout,
    required this.onDetail,
    required this.onPost,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      context.read<StoryProvider>().getStories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: AppLocalizations.of(context)!.home,
      action: [
        const FlagIcon(),
        IconButton(
            onPressed: () async {
              final scaffoldMessengerState = ScaffoldMessenger.of(context);
              widget.onLogout();
              final dataFromDialog =
                  await context.read<PageManager<String>>().waitForResult();
              scaffoldMessengerState
                  .showSnackBar(SnackBar(content: Text(dataFromDialog)));
            },
            icon: const Icon(MdiIcons.logout))
      ],
      floatingActiopnButton: FloatingActionButton(
        onPressed: () => widget.onPost(),
        child: const Icon(MdiIcons.plus),
      ),
      body: _body(),
    );
  }

  Consumer<StoryProvider> _body() {
    return Consumer<StoryProvider>(builder: (context, prov, _) {
      if (prov.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (prov.state == ResultState.hasData) {
        return ListView.builder(
            itemCount: prov.stories.length,
            itemBuilder: (context, i) {
              return StoryCard(
                story: prov.stories[i],
                onTap: () {
                  widget.onDetail(prov.stories[i]);
                },
              );
            });
      } else {
        return Center(child: Text(prov.message));
      }
    });
  }
}

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
    context.read<StoryProvider>().getStories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Beranda",
      action: [
        IconButton(
            onPressed: () async {
              final authRead = context.read<AuthProvider>();
              final result = await authRead.logout();
              if (result) {
                widget.onLogout();
              }
            },
            icon: const Icon(MdiIcons.logout))
      ],
      floatingActiopnButton: FloatingActionButton(
        onPressed: () => widget.onPost(),
        child: const Icon(MdiIcons.plus),
      ),
      body: Consumer<StoryProvider>(builder: (context, prov, _) {
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
      }),
    );
  }
}

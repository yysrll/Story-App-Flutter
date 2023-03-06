part of 'screen.dart';

class HomeScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Beranda",
      action: [
        IconButton(
            onPressed: () async {
              final authRead = context.read<AuthProvider>();
              final result = await authRead.logout();
              if (result) {
                onLogout();
              }
            },
            icon: const Icon(MdiIcons.logout))
      ],
      floatingActiopnButton: FloatingActionButton(
        onPressed: () => onPost(),
        child: const Icon(MdiIcons.plus),
      ),
      body: ChangeNotifierProvider(
        create: (context) => StoryProvider(),
        child: Consumer<StoryProvider>(builder: (context, prov, _) {
          if (prov.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (prov.state == ResultState.hasData) {
            return ListView.builder(
                itemCount: prov.stories.length,
                itemBuilder: (context, i) {
                  return StoryCard(
                    story: prov.stories[i],
                    onTap: () {
                      onDetail(prov.stories[i]);
                    },
                  );
                });
          } else {
            return Center(child: Text(prov.message));
          }
        }),
      ),
    );
  }
}

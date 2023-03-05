part of 'screen.dart';

class HomeScreen extends StatelessWidget {
  final Function() onLogout;
  final Function(Story) onDetail;
  const HomeScreen({
    Key? key,
    required this.onLogout,
    required this.onDetail,
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

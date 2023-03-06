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
      title: AppLocalizations.of(context)!.home,
      action: [
        const FlagIcon(),
        IconButton(
            onPressed: () {
              _showLogoutDialog();
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

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.logoutConfirmation),
          actions: <Widget>[
            context.watch<AuthProvider>().isLoadingLogout
                ? const CircularProgressIndicator()
                : TextButton(
                    child: Text(AppLocalizations.of(context)!.logout),
                    onPressed: () async {
                      final scaffoldMessengerState =
                          ScaffoldMessenger.of(context);
                      final authRead = context.read<AuthProvider>();
                      final navigator = Navigator.of(context);
                      final result = await authRead.logout();
                      if (result) {
                        widget.onLogout();
                      } else {
                        scaffoldMessengerState.showSnackBar(
                            SnackBar(content: Text(authRead.message)));
                      }
                      navigator.pop();
                    },
                  ),
          ],
        );
      },
    );
  }
}

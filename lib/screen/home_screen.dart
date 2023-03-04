part of 'screen.dart';

class HomeScreen extends StatelessWidget {
  final Function() onLogout;
  const HomeScreen({
    Key? key,
    required this.onLogout,
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
      body: ListView.builder(
          itemBuilder: (context, i) {
            return StoryCard(
              title: "title $i",
              onTap: () {},
              description:
                  'description sahjsg asbvhas d sadhiasj dsjbf jbdsjbf djbjsd jsdbfjdsbfj jdsbf JAHKGs AAJGS ASJHD AJJ nadsnln adsjbn djsah ;jbladj;',
            );
          },
          itemCount: 5),
    );
  }
}

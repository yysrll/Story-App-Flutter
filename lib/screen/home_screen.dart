part of 'screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Beranda",
      action: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            icon: const Icon(MdiIcons.logout))
      ],
      body: ListView.separated(
          itemBuilder: (context, i) {
            return StoryCard(
              title: "title $i",
              onTap: () {},
              description:
                  'description sahjsg asbvhas d sadhiasj dsjbf jbdsjbf djbjsd jsdbfjdsbfj jdsbf JAHKGs AAJGS ASJHD AJJ nadsnln adsjbn djsah ;jbladj;',
            );
          },
          separatorBuilder: (context, i) {
            return SizedBox();
          },
          itemCount: 5),
    );
  }
}

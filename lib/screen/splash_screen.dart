part of 'screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 5), () async {
      // var isLogin = await checkIsLoggedIn();
      // if (isLogin) {
      //   to(const HomeScreen());
      // } else {
      //   to(const LoginScreen());
      // }

        // to(const LoginScreen());
    // });
    super.initState();
  }

  // void to(Widget widget) {
  //   Navigator.of(context)
  //       .pushReplacement(MaterialPageRoute(builder: (context) => widget));
  // }
  //
  // Future<bool> checkIsLoggedIn() async {
  //   return context.read<AuthProvider>().isLoggedIn;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Ceritaku',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator()
            ],
          ))),
    ));
  }
}

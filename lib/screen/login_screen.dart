part of 'screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Icon(
                Icons.camera_alt_outlined,
                size: 52,
              ),
              const Text(
                "Ceritaku",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    const CustomFormField(
                      title: "Email",
                    ),
                    const CustomPasswordFormField(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // if (formKey.currentState!.validate()) {
                          //
                          // }
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Belum memiliki akun?",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                        },
                        child: const Text("Register"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

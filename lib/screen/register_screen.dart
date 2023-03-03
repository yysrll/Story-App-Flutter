part of 'screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                      title: "Nama",
                    ),
                    const CustomFormField(
                      title: "Email",
                    ),
                    const CustomPasswordFormField(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //
                          }
                        },
                        child: const Text("Register"),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Sudah memiliki akun?",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        child: const Text("Login"),
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

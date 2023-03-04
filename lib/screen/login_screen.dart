part of 'screen.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;
  const LoginScreen({
    Key? key,
    required this.onLogin,
    required this.onRegister,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    CustomFormField(
                      title: "Email",
                      editingController: emailController,
                    ),
                    CustomPasswordFormField(
                        editingController: passwordController),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: context.watch<AuthProvider>().isLoadingLogin
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final scaffoldMessenger =
                                        ScaffoldMessenger.of(context);
                                    final authRead =
                                        context.read<AuthProvider>();
                                    final result = await authRead.login(
                                        emailController.text,
                                        passwordController.text);

                                    if (result) {
                                      print('onLogin cuy');
                                      widget.onLogin();
                                    } else {
                                      final message = authRead.message;
                                      scaffoldMessenger.showSnackBar(
                                          SnackBar(content: Text(message)));
                                    }
                                  }
                                },
                                child: const Text("Login"),
                              )),
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
                          widget.onRegister();
                          print('register cuk');
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

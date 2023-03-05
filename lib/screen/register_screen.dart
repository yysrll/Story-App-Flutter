part of 'screen.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onRegister;
  final Function() onLogin;

  const RegisterScreen({
    Key? key,
    required this.onRegister,
    required this.onLogin,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                      title: "Nama",
                      editingController: nameController,
                    ),
                    CustomFormField(
                      title: "Email",
                      editingController: emailController,
                    ),
                    CustomPasswordFormField(
                      editingController: passwordController,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: context.watch<AuthProvider>().isLoadingRegister
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final scaffoldMessenger =
                                      ScaffoldMessenger.of(context);
                                  final pageManager =
                                      context.read<PageManager<String>>();
                                  final authRead = context.read<AuthProvider>();
                                  final result = await authRead.register(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text);
                                  if (result) {
                                    widget.onRegister();
                                    pageManager.returnData(authRead.message);
                                  } else {
                                    scaffoldMessenger.showSnackBar(SnackBar(
                                        content: Text(authRead.message)));
                                  }
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
                        onPressed: () => widget.onLogin(),
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

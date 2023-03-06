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
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: const TextStyle(
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
                      title: AppLocalizations.of(context)!.emailTitleForm,
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
                                      widget.onLogin();
                                    } else {
                                      final message = authRead.message;
                                      scaffoldMessenger.showSnackBar(
                                          SnackBar(content: Text(message)));
                                    }
                                  }
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .loginTextButton),
                              )),
                    const SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)!.doesntHaveAnAccount,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () async {
                          final scaffoldMessengerState =
                              ScaffoldMessenger.of(context);
                          widget.onRegister();

                          final dataFromRegister = await context
                              .read<PageManager<String>>()
                              .waitForResult();
                          scaffoldMessengerState.showSnackBar(
                              SnackBar(content: Text(dataFromRegister)));
                        },
                        child: Text(AppLocalizations.of(context)!.registerTextButton),
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

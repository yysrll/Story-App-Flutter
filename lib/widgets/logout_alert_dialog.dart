part of 'widget.dart';

class LogoutAlertDialog extends Page {
  final Function() onLogoutSuccess;
  final Function() onLogoutFailed;

  const LogoutAlertDialog(
      {required this.onLogoutSuccess, required this.onLogoutFailed});

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
      context: context,
      settings: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.logoutConfirmation),
          actions: <Widget>[
            context.watch<AuthProvider>().isLoadingLogout
                ? const CircularProgressIndicator()
                : TextButton(
                    child: Text(AppLocalizations.of(context)!.logout),
                    onPressed: () async {
                      final pageManager = context.read<PageManager<String>>();
                      final authRead = context.read<AuthProvider>();
                      final local = AppLocalizations.of(context)!;
                      final result = await authRead.logout();
                      if (result) {
                        onLogoutSuccess();
                        pageManager.returnData(local.logoutSuccess);
                      } else {
                        onLogoutFailed();
                        pageManager.returnData(authRead.message);
                      }
                    },
                  ),
          ],
        );
      },
    );
  }
}

part of 'widget.dart';

class FlagIcon extends StatelessWidget {
  const FlagIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(
          Icons.flag,
          color: Colors.white,
        ),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = Localization.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            onTap: () {
              final prov =
                  Provider.of<LocalizationProvider>(context, listen: false);
              prov.setLocale(locale);
            },
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}

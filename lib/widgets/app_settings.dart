import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/shared_provider.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {

  int pushCount = 0;
  static const int NUMBER_OF_CLICKS_TO_RESET = 5;

  void resetStorage(StorageService storage){
    if( pushCount >= NUMBER_OF_CLICKS_TO_RESET) {
      //OK, reset values
      storage.clear(); // ;-;

      Fluttertoast.showToast(msg: "L'application a été remise à zéro!", toastLength: Toast.LENGTH_LONG);

      pushCount = 0;
      Navigator.pop(context);
    }else{
      //Show toast
      final remainingClicks = NUMBER_OF_CLICKS_TO_RESET - pushCount;

      Fluttertoast.showToast(
        msg: "Appuyez encore $remainingClicks fois pour tout supprimer.",
        toastLength: Toast.LENGTH_SHORT
      );
      pushCount++;
    }
  }

  @override
  Widget build(BuildContext context) {
    StorageService storage = StorageService();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Padding(padding: EdgeInsets.all(10.0)),
        const Text("Paramètres de l'application.", textScaler: TextScaler.linear(1.3)),
        const Padding(padding: EdgeInsets.all(20.0)),
        const Text(
          "Ce bouton permet de réinitialiser toute l'application.\nATTENTION: Il ne sera pas possible de restaurer les données!",
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            resetStorage(storage);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text(
            "Remettre l'application à zéro",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

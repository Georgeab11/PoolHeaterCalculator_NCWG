import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:poolheatercalculator/localization.dart';
//import 'package:flutter_launch/flutter_launch.dart';

//void launchWhatsApp(){
//  phone: "5534992016545",
//  message: "Hello",
//}
class ContactView extends StatelessWidget {
  static const pathName = "contact";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: Text(
            '${AppLocalizations.of(context).translate("contact_us")}',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'NCWG | Sintra',
                style: new TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Av. Pedro Alvares Cabral \n"
                "Centro Empresarial Sintra Estoril V,\n"
                "WH E4 \n"
                "2710-263 Sintra\n\n",
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              FlatButton(
                color: Colors.grey[600],
                onPressed: () => launch("tel://+351211339701"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone, color: Colors.white),
                    Text(
                      "    +351 211 339 701",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.grey[600],
                onPressed: () => launch("tel://+351211339627"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone, color: Colors.white),
                    Text(
                      "   +351 211 339 627",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.grey[600],
                onPressed: () => FlutterOpenWhatsapp.sendSingleMessage(
                    "+351 911 528 469", "Hello"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/whatsapp.png'),
                    Text(
                      "   WhatsApp +351 911 528 469 ",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.grey[600],
                onPressed: () => sendEmail('Hello there'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email, color: Colors.white),
                    Text(
                      "   encomendas@ncwg.pt",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
//              FlatButton(
//                color: Colors.grey[600],
//                onPressed: () async {
//                  await url_launch.launchWathsApp(
//                      phone: "5534992016545", message: "Hello");
//                },
//                child: Text('WhatsApp'),
//              ),
            ],
          ),
        ),
      ),
    );
  }

//   void launchWhatsApp({
//    phone: "5534992016545",
//    message: "Hello",
//  }) async {
//    String url() {
//      if (Platform.isIOS) {
//        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
//      } else {
//        return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
//      }
//    }
//
//    if (await canLaunch(url())) {
//      await launch(url());
//    } else {
//      throw 'Could not launch ${url()}';
//    }
//  }

  Future<void> sendEmail(String body) async {
    final Email email = Email(
      body: body,
      subject: 'Feedback for App',
      recipients: ['encomendas@ncwg.pt'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}

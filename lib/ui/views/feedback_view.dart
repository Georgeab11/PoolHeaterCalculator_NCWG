import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';
import 'package:poolheatercalculator/ui/widgets/custom_widgets.dart';
import 'package:poolheatercalculator/localization.dart';

class FeedBackView extends StatelessWidget {
  static const pathName = "feedback";
  TextEditingController feedbackController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: Text(
            'Feedback',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MobiTextFormField(
                controller: feedbackController,
                minLines: 10,
                label:
                    '${AppLocalizations.of(context).translate("write_feedback_here")}',
              ),
              MobiButton(
                onPressed: () async {
                  await sendEmail(feedbackController.text);
                  Navigator.pop(context);
                },
                color: kButtonColor,
                textColor: Colors.black,
                text: "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }

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

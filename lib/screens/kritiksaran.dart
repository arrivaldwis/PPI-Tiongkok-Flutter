import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import '../smtp_server/email.dart';

// Define a Custom Form Widget
class Feedback extends StatefulWidget {
  const Feedback({Key key}) : super(key: key);

  @override
  _ksFormState createState() => _ksFormState();
}

class _ksFormState extends State<Feedback> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final nametextController = TextEditingController();
  final phonetextController = TextEditingController();
  final emailtextController = TextEditingController();
  final messagetextController = TextEditingController();

  bool _messageSent = false;
  bool _autoValidate = false;
  bool _formWasEdited = false;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nametextController.dispose();
    phonetextController.dispose();
    emailtextController.dispose();
    messagetextController.dispose();
    super.dispose();
  }

  void _showSnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(message),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  String _validateName(String value) {
    _messageSent = false;
    _formWasEdited = true;
    if (value.isEmpty) return 'Masukan nama Anda';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) return 'Harap gunakan huruf Alfabet';
    return null;
  }

  String _validateMessage(String value) {
    _messageSent = false;
    _formWasEdited = true;
    if (value.isEmpty) return 'Masukan pesan Anda';
    return null;
  }

  String _validateEmail(String value) {
    _messageSent = false;
    _formWasEdited = true;
    if (value.isEmpty) {
      // The form is empty
      return "Masukan Email Anda";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email tidak valid';
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || _messageSent == true || form.validate()) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Form ini belum lengkap'),
              content: const Text('Anda yakin meninggalkan form ini?'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('YA'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: const Text('TIDAK'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        //App Bar
        title: new Text(
          'Kritik dan Saran',
          style: new TextStyle(
            fontSize:
                Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new SafeArea(
          top: true,
          bottom: true,
          child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              onWillPop: _warnUserAboutInvalidData,
              child: new ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: 'Nama Anda',
                      labelText: 'Nama *',
                    ),
                    onSaved: (String value) {
                      nametextController.text = value;
                    },
                    validator: _validateName,
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.phone),
                      hintText: 'Nomer Telepon Anda',
                      labelText: 'Nomer Telepon',
                    ),
                    keyboardType: TextInputType.phone,
                    onSaved: (String value) {
                      phonetextController.text = value;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.email),
                      hintText: 'Alamat Email Anda',
                      labelText: 'E-mail *',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String value) {
                      emailtextController.text = value;
                    },
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.textsms),
                      hintText: 'Isi Pesan Anda',
                      labelText: 'Isi Pesan *',
                    ),
                    onSaved: (String value) {
                      messagetextController.text = value;
                    },
                    maxLines: 3,
                    validator: _validateMessage,
                  ),
                  const SizedBox(height: 24.0),
                  Center(
                    child: RaisedButton(
                      child: const Text('KIRIM'),
                      padding: const EdgeInsets.all(2.0),
                      color: Theme.of(context).accentColor,
                      elevation: 5.0,
                      textColor: Colors.white,
                      splashColor: Theme.of(context).accentColor,
                      onPressed: _validateInputs,
                    ),
                  ),
                  Text('* Harus di isi',
                      style: Theme.of(context).textTheme.caption),
                  const SizedBox(height: 24.0),
                ],
              ))),
    );
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _showSnackBar("Ada kesalahan! Silahkan periksa kembali");
      _autoValidate = true; // Start validating on every change.
    } else {
      form.save();
      _SendEmail();
      _showSnackBar("Pesan Terkirim");
      //clear textfield after send the message
      form.reset();
      _autoValidate = false; // Start validating on every change.
      _messageSent = true;
    }
  }

  void _SendEmail() {
    // Create our message.
    final message = new Message()
      ..from =
          new Address('mobile.apps@ppitiongkok.org', nametextController.text)
      ..recipients.add('mobile.apps@ppitiongkok.org')
      ..subject =
          '[Form Kritik dan Saran] Dari ${nametextController.text} <${emailtextController.text}> ${new DateTime.now()}'
      ..text = messagetextController.text +
          '\n\n\n\nDari : ' +
          nametextController.text +
          '\nNomer Telepon : ' +
          phonetextController.text +
          '\nEmail : ' +
          emailtextController.text +
          '\nDiterima : ${new DateTime.now()}' +
          '\n\nEmail Ini Berasal Dari Form Kritik dan Saran di PPIT Mobile App';
    //Send using email account in smtp_server configuration
    send(message, email('mobile.apps@ppitiongkok.org', 'testeradmin'));
  }
}

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import '../smtp_server/email.dart';

// Define a Custom Form Widget
class Support extends StatefulWidget {
  @override
  _ksFormState createState() => _ksFormState();
}

class _ksFormState extends State<Support>  {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final nametextController = TextEditingController();
  final phonetextController = TextEditingController();
  final emailtextController = TextEditingController();
  final texttextController = TextEditingController();

  bool _autoValidate = false;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nametextController.dispose();
    phonetextController.dispose();
    emailtextController.dispose();
    texttextController.dispose();
    super.dispose();
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
            Theme
                .of(context)
                .platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme
            .of(context)
            .platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new SafeArea(
          top: true,
          bottom: true,
          child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Masukan Nama Anda',
                      labelText: 'Nama',
                    ),
                    controller: nametextController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Masukan Nomor Telepon Anda',
                      labelText: 'Telepon',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    controller: phonetextController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Masukan Email Anda',
                      labelText: 'Email',
                    ),
                    onSaved: (String value) {
                      value = emailtextController.text;
                    },
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailtextController,
                  ),
                  new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.textsms),
                        hintText: 'Masukan Pesan Anda',
                        labelText: 'Isi Pesan',
                      ),
                      keyboardType: TextInputType.text,
                      controller: texttextController,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Kirim'),
                        onPressed: () {
                          _validateInputs();
                        },
                      )),
                ],
              ))),
    );
  }

  String _validateEmail(String value) {
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


  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
        form.save();
        _SendEmail();
        _showSnackBar("Pesan Terkirim");
      } else {
      _showSnackBar("Data Tidak Valid!");
      setState(() => _autoValidate = true);
    }
  }

  void _SendEmail(){
    // Create our message.
    final message = new Message()
      ..from = new Address ('mobile.apps@ppitiongkok.org', nametextController.text)
      ..recipients.add('mobile.apps@ppitiongkok.org')
      ..subject =  'Kritik atau Saran Dari ${nametextController.text} <${emailtextController.text}> ${new DateTime.now()}'
      ..text =  texttextController.text + '\n\n\n\nDari : ' + nametextController.text +
          '\nNomer Telepon : ' + phonetextController.text + '\nEmail : ' + emailtextController.text +
          '\nDiterima : ${new DateTime.now()}' +
          '\n\nEmail Ini Berasal Dari Form Kritik dan Saran di PPIT Mobile App';
    //Send using email account in smtp_server configuration
    send(message, email('mobile.apps@ppitiongkok.org', 'testeradmin'));

    //clear textfield after send the message
    nametextController.clear();
    phonetextController.clear();
    emailtextController.clear();
    texttextController.clear();
  }

  void _showSnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(message),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}



import 'package:flutter/material.dart';
import 'package:ppi_tiongkok/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'dart:io';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController controllerNickname;
  TextEditingController controllerAboutMe;
  TextEditingController controllerPosition;

  SharedPreferences prefs;

  String id = '';
  String nickname = '';
  String aboutMe = '';
  String position = '';
  String photoUrl = '';
  String approvImgUrl = '';
  bool approval = false;

  bool isLoading = false;
  File avatarImageFile;
  File approvalImageFile;

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    readLocal();
    _checkEmailVerification();
    _checkAccountApproval();
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _checkAccountApproval() async {
    bool _checkApproval = await Firestore.instance
        .collection('users')
        .document(id)
        .get()
        .then((data) async {
      await prefs.getBool('approval');
    });
    if (!_checkApproval) {
      _showVerifyApproval();
    }
  }

  void _resentVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verifikasi Akunmu"),
          content: new Text("Tolong Verifikasi akunmu di emailmu"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Kirim Lagi"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Lewati"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyApproval() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: new Text("Akun belum di Approved"),
            content: new Text("Tolong tunggu approval dari tim kami"));
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verifikasi Akunmu"),
          content: new Text(
              "Link Untuk Verifikasi Akunmu telah di kirim di emailmu"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Lewati"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    aboutMe = prefs.getString('aboutMe') ?? '';
    position = prefs.getString('position') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    approvImgUrl = prefs.getString('approvImgUrl') ?? '';
//    approval = prefs.getBool('approval') ?? '';

    controllerNickname = new TextEditingController(text: nickname);
    controllerAboutMe = new TextEditingController(text: aboutMe);
    controllerPosition = new TextEditingController(text: position);

    // Force refresh input
    setState(() {});
  }

  Future getImageAvatar() async {
    File avatarImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (avatarImage != null) {
      setState(() {
        avatarImageFile = avatarImage;
        isLoading = true;
      });
    }
    uploadFileAvatar();
  }

  Future getImageApproval() async {
    File approvalImage =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (approvalImage != null) {
      setState(() {
        approvalImageFile = approvalImage;
        isLoading = true;
      });
    }
    uploadFileApproval();
  }

  Future uploadFileAvatar() async {
    String fileName = id;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTaskAvatar = reference.putFile(avatarImageFile);
    StorageTaskSnapshot storageTaskSnapshot;
    uploadTaskAvatar.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          photoUrl = downloadUrl;
          Firestore.instance.collection('users').document(id).setData({
            'nickname': nickname,
            'aboutMe': aboutMe,
            'position': position,
            'photoUrl': photoUrl,
            'approvImgUrl': approvImgUrl,
            'approval': approval
          }).then((data) async {
            await prefs.setString('photoUrl', photoUrl);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Foto Profil Berhasil di Upload");
          }).catchError((err) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: err.toString());
          });
        }, onError: (err) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'This file is not an image');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'This file is not an image');
      }
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: err.toString());
    });
  }

  Future uploadFileApproval() async {
    String fileName = id + ' - ' + 'approval';
    StorageReference referenceApproval =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTaskApproval =
        referenceApproval.putFile(approvalImageFile);
    StorageTaskSnapshot storageTaskSnapshotApproval;
    uploadTaskApproval.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshotApproval = value;
        storageTaskSnapshotApproval.ref.getDownloadURL().then((downloadUrl) {
          approvImgUrl = downloadUrl;
          Firestore.instance.collection('users').document(id).setData({
            'nickname': nickname,
            'aboutMe': aboutMe,
            'position': position,
            'photoUrl': photoUrl,
            'approvImgUrl': approvImgUrl,
            'approval': approval
          }).then((data) async {
            await prefs.setString('approvImgUrl', approvImgUrl);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Bukti Pembayaran Berhasil di Upload");
          }).catchError((err) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: err.toString());
          });
        }, onError: (err) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'This file is not an image');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'This file is not an image');
      }
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: err.toString());
    });
  }

  void handleUpdateData() async {
    setState(() {
      isLoading = true;
    });

    FirebaseUser firebaseUser = await widget.auth.getCurrentUser();

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          'nickname': nickname,
          'aboutMe': aboutMe,
          'position': position,
          'photoUrl': photoUrl,
          'approvImgUrl': approvImgUrl,
          'approval': approval,
          'id': firebaseUser.uid
        });

        // Write data to local
        await prefs.setString('id', firebaseUser.uid);
        await prefs.setString('nickname', nickname);
        await prefs.setString('photoUrl', photoUrl);
        await prefs.setString('aboutMe', aboutMe);
        await prefs.setString('position', position);
        await prefs.setString('approvImgUrl', approvImgUrl);
        await prefs.setBool('approval', approval);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
        await prefs.setString('position', documents[0]['position']);
        await prefs.setString('approvImgUrl', documents[0]['approvImgUrl']);
        await prefs.setBool('approval', documents[0]['approval']);
      }
      Fluttertoast.showToast(msg: "Data Anda Berhasil di Upload");
      this.setState(() {
        isLoading = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Gagal");
      this.setState(() {
        isLoading = false;
      });
    }

    Firestore.instance.collection('users').document(id).updateData({
      'nickname': nickname,
      'aboutMe': aboutMe,
      'position': position,
      'photoUrl': photoUrl,
      'approvImgUrl': approvImgUrl,
      'approval': approval
    }).then((data) async {
      await prefs.setString('nickname', nickname);
      await prefs.setString('aboutMe', aboutMe);
      await prefs.setString('position', position);
      await prefs.setString('photoUrl', photoUrl);
      await prefs.setString('approvImgUrl', approvImgUrl);
      await prefs.setBool('approval', approval);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Avatar
              Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      (avatarImageFile == null)
                          ? (photoUrl != ''
                              ? Material(
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.red),
                                          ),
                                          width: 90.0,
                                          height: 90.0,
                                          padding: EdgeInsets.all(20.0),
                                        ),
                                    imageUrl: photoUrl,
                                    width: 90.0,
                                    height: 90.0,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(45.0)),
                                  clipBehavior: Clip.hardEdge,
                                )
                              : Icon(
                                  Icons.account_circle,
                                  size: 90.0,
                                  color: Colors.grey,
                                ))
                          : Material(
                              child: Image.file(
                                avatarImageFile,
                                width: 90.0,
                                height: 90.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                      IconButton(
                        tooltip: 'Upload Foto Profil',
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.red.withOpacity(0.5),
                        ),
                        onPressed: getImageAvatar,
                        padding: EdgeInsets.all(30.0),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.grey,
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
              ),

              // Input
              Column(
                children: <Widget>[
                  // Nickname
                  Container(
                    child: Theme(
                      data:
                          Theme.of(context).copyWith(primaryColor: Colors.red),
                      child: TextField(
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.person),
                          hintText: 'Nama Anda',
                          labelText: 'Nama *',
                        ),
                        controller: controllerNickname,
                        onChanged: (value) {
                          nickname = value;
                        },
                      ),
                    ),
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  ),

                  // Position
                  Container(
                    child: Theme(
                      data:
                          Theme.of(context).copyWith(primaryColor: Colors.red),
                      child: TextField(
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.format_list_numbered),
                          hintText: 'Posisi',
                          labelText: 'Posisi *',
                        ),
                        controller: controllerPosition,
                        onChanged: (value) {
                          position = value;
                        },
                      ),
                    ),
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  ),

                  // Aboutme
                  Container(
                    child: Theme(
                      data:
                          Theme.of(context).copyWith(primaryColor: Colors.red),
                      child: TextField(
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.edit),
                          hintText: 'Tentang Anda',
                          labelText: 'Tentang *',
                        ),
                        controller: controllerAboutMe,
                        onChanged: (value) {
                          aboutMe = value;
                        },
                        maxLines: 3,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              // Approval Img
              Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      (approvalImageFile == null)
                          ? (approvImgUrl != ''
                              ? Material(
                                  child: new CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.red),
                                          ),
                                          width: 200.0,
                                          height: 200.0,
                                          padding: EdgeInsets.all(20.0),
                                        ),
                                    imageUrl: approvImgUrl,
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.payment,
                                  size: 200.0,
                                  color: Colors.grey,
                                ))
                          : Material(
                              child: Image.file(
                                approvalImageFile,
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                      IconButton(
                        tooltip: 'Upload Bukti Pembayaran',
                        icon: Icon(
                          Icons.payment,
                          color: Colors.red.withOpacity(0.5),
                        ),
                        onPressed: getImageApproval,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.grey,
                        iconSize: 60.0,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(70.0),
                      ),
                    ],
                  ),
                ),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
              ),

              // Button
              Container(
                child: FlatButton(
                  onPressed: handleUpdateData,
                  child: Text(
                    'Kirim',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  color: Colors.red,
                  highlightColor: new Color(0xff8d93a0),
                  splashColor: Colors.transparent,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                ),
                margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
              ),

              // Button
              Container(
                child: FlatButton(
                  onPressed: _signOut,
                  child: Text('Sign Out'),
                  color: Colors.grey,
                ),
              )
            ],
          ),
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
        ),

        // Loading
        Positioned(
          child: isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                  ),
                  color: Colors.white.withOpacity(0.8),
                )
              : Container(),
        ),
      ],
    );
  }
}

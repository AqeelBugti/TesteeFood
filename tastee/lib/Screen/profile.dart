import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tastee/Model/user.dart';
import './homepage.dart';
import '../Wigets/RaisedButton.dart';
import '../Wigets/MyTextFromField.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool profileCondition = false;
  File cameraImage;
  User userData;
  bool gender = false;
  var uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getImage() async {
    final getImage = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      cameraImage = File(getImage.path);
    });
  }

  Future<String> _uploadFile(File _image) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/${userData.imagePath}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot task = await uploadTask.onComplete;
    final String _imageUrl = (await task.ref.getDownloadURL());

    return _imageUrl;
  }

  var imageUrl;
  void userDataUpdate() async {
    cameraImage != null
        ? imageUrl = await _uploadFile(cameraImage)
        : Container();
    Firestore.instance.collection("user").document(uid).updateData({
      "UserName": fullName.text,
      "UserEmail": email.text,
      "UserAddress": address.text,
      "UserNumber": int.parse(contactNumber.text),
      "UserGender": gender ? "Female" : "Male",
      "UserImageUrl": cameraImage == null ? userData.image : imageUrl,
    });
  }

  String userImage;

  RegExp regex = new RegExp(Profile.pattern);

  final GlobalKey<ScaffoldState> _myKey = GlobalKey<ScaffoldState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController fullName = TextEditingController();

  TextEditingController contactNumber = TextEditingController();

  TextEditingController address = TextEditingController();

  void getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
  }

  Widget _raisedButton(context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: MyRaisedutton(
        buttonText: 'Update',
        textColor: Colors.white,
        myColor: Theme.of(context).primaryColor,
        whenPress: () {
          snackBarValidation();
          // print(snackBarValidation);
        },
      ),
    );
  }

  Widget _circleWidet() {
    return Padding(
      padding: EdgeInsets.only(top: 65, left: 150),
      child: CircleAvatar(
        maxRadius: 70,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          maxRadius: 66,
          backgroundColor: Colors.blue,
          backgroundImage: cameraImage == null
              ? NetworkImage(userData.image)
              : FileImage(cameraImage),
        ),
      ),
    );
  }

  Widget _editedIcon() {
    return Container(
      padding: EdgeInsets.only(top: 144, left: 130),
      child: Align(
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              getImage();
            },
          ),
        ),
      ),
    );
  }

  Widget _myfalseContainer({String fieldName, Function whenPress}) {
    return GestureDetector(
      onTap: whenPress,
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 5),
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 13),
        height: 60,
        width: double.infinity,
        child: Text(
          fieldName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        decoration: BoxDecoration(
            color: Color(0xfffef6fa), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void snackBarValidation() {
    if (email.text.isEmpty && password.text.isEmpty) {
      _myKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Both field are empty"),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    } else if (email.text.isEmpty || email.text.trim() == null) {
      _myKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is Empty"),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    if (regex.hasMatch(email.text) == false) {
      _myKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Please enter valid emai',
          ),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }

    if (address.text.isEmpty || address.text.isEmpty) {
      _myKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Both field are empty"),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    } else {
      setState(() {
        profileCondition = false;
      });
      userDataUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      key: _myKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0.0,
        leading: profileCondition == false
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    profileCondition = false;
                  });
                },
              ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                profileCondition = true;
              });
            },
            icon: Text(
              "Edit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("user").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var myDocuments = snapshot.data.documents;
            myDocuments.forEach((checkDocument) {
              if (uid == checkDocument["UserId"]) {
                userData = User(
                    fullName: checkDocument["UserName"],
                    email: checkDocument["UserEmail"],
                    contactNumber: checkDocument["UserNumber"],
                    gender: checkDocument["UserGender"],
                    address: checkDocument["UserAddress"],
                    imagePath: checkDocument["UserImagePath"],
                    password: null,
                    image: checkDocument["UserImageUrl"]);

                fullName = TextEditingController(text: userData.fullName);
                //password = TextEditingController(text: userData.password);
                email = TextEditingController(text: userData.email);
                contactNumber = TextEditingController(
                    text: userData.contactNumber.toString());
                address = TextEditingController(text: userData.address);
              }
            });

            return Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 730,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 430,
                                    child: profileCondition == true
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              MyTextFromField(
                                                hintText: "Full Name",
                                                keybord: TextInputType.text,
                                                myController: fullName,
                                                myObscureText: false,
                                              ),
                                              MyTextFromField(
                                                hintText: "Email",
                                                keybord: TextInputType.text,
                                                myController: email,
                                                myObscureText: false,
                                              ),
                                              MyTextFromField(
                                                hintText: "Contact Number",
                                                keybord: TextInputType.text,
                                                myController: contactNumber,
                                                myObscureText: false,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    gender = !gender;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 20, left: 12),
                                                  height: 60,
                                                  width: double.infinity,
                                                  child: Text(
                                                    gender ? "Female" : "Male",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xfffef6fa),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              ),
                                              MyTextFromField(
                                                hintText: "Address",
                                                keybord: TextInputType.text,
                                                myController: address,
                                                myObscureText: false,
                                              ),
                                            ],
                                          )
                                        : Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                _myfalseContainer(
                                                    whenPress: null,
                                                    fieldName:
                                                        userData.fullName),
                                                _myfalseContainer(
                                                    whenPress: null,
                                                    fieldName: userData.email),
                                                _myfalseContainer(
                                                    whenPress: null,
                                                    fieldName: userData
                                                        .contactNumber
                                                        .toString()),
                                                _myfalseContainer(
                                                    whenPress: () {},
                                                    fieldName: userData.gender),
                                                _myfalseContainer(
                                                    whenPress: null,
                                                    fieldName:
                                                        userData.address),
                                              ],
                                            ),
                                          ),
                                  ),
                                  profileCondition == true
                                      ? _raisedButton(context)
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _circleWidet(),
                  profileCondition == true ? _editedIcon() : Container(),
                ],
              ),
            );
          }),
    );
  }
}

// if (fullName.text.trim() == null || fullName.text.isEmpty) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text("FullName Is Empty"),
//       duration: Duration(milliseconds: 600),
//       backgroundColor: Theme.of(context).primaryColor,
//     ));
//   } else if (email.text.isEmpty || email.text.trim() == null) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text("Email is Empty"),
//       duration: Duration(milliseconds: 600),
//       backgroundColor: Theme.of(context).primaryColor,
//     ));
//   } else if (!regex.hasMatch(email.text)) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text("Please Try Vaild Email"),
//       duration: Duration(milliseconds: 600),
//       backgroundColor: Theme.of(context).primaryColor,
//     ));
//   } else if (phoneNumber.text.isEmpty) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text("Phone Number is Empty"),
//       duration: Duration(milliseconds: 600),
//       backgroundColor: Theme.of(context).primaryColor,
//     ));
//   } else if (int.tryParse(phoneNumber.text) == null) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text("Please Enter Vaild Number"),
//       duration: Duration(milliseconds: 600),
//       backgroundColor: Theme.of(context).primaryColor,
//     ));
//   } else if (int.tryParse(phoneNumber.text) < 0) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text("Phone Number  Not Less then 0"),
//       duration: Duration(milliseconds: 600),
//       backgroundColor: Theme.of(context).primaryColor,
//     ));
//   } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text("Phone number must be equal 11"),
//       duration: Duration(milliseconds: 600),
//       backgroundColor: Theme.of(context).primaryColor,
//     ));
//   }

// My Snackbar
// if (password.text.isEmpty || password.text.trim() == null) {
//       _myKey.currentState.showSnackBar(
//         SnackBar(
//           content: Text("Password is Emptey"),
//           duration: Duration(milliseconds: 600),
//           backgroundColor: Theme.of(context).primaryColor,
//         ),
//       );
//       return;
//     }
//     if (password.text.length < 8) {
//       _myKey.currentState.showSnackBar(
//         SnackBar(
//           content: Text("Pasword Must be greater then 8"),
//           duration: Duration(milliseconds: 600),
//           backgroundColor: Theme.of(context).primaryColor,
//         ),
//       );

//       return;
//     }

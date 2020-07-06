// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tastee/Screen/homepage.dart';
// import 'package:tastee/Screen/logIn.dart';
// import 'package:tastee/Wigets/MyTextFromField.dart';
// import 'package:tastee/Wigets/RaisedButton.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../model/user.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as Path;

// class SignUp extends StatefulWidget {
//   static Pattern pattern =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final TextEditingController fullName = TextEditingController();

//   final TextEditingController email = TextEditingController();

//   final TextEditingController password = TextEditingController();
//   final TextEditingController address = TextEditingController();

//   final TextEditingController contactNumber = TextEditingController();

//   final RegExp regex = RegExp(SignUp.pattern);

//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   final auth = FirebaseAuth.instance;

//   bool isLoading = false;
//   AuthResult authResult;
//   bool isMale = true;

//   File myImage;
//   Future getImage() async {
//     var cameraImage =
//         await ImagePicker().getImage(source: ImageSource.camera);

//     setState(() {
//       myImage = File(cameraImage.path);
//     });
//   }

//  Future<Map<String, String>> _uploadFile(File _image) async {
//     String _imagePath = _image.path;

//     StorageReference storageReference = FirebaseStorage.instance
//         .ref()
//         .child('images/${Path.basename(_imagePath)}');
//     StorageUploadTask uploadTask = storageReference.putFile(_image);
//     StorageTaskSnapshot task = await uploadTask.onComplete;
//     final String _imageUrl = (await task.ref.getDownloadURL());

//     Map<String, String> _downloadData = {
//       'imagePath': Path.basename(_imagePath),
//       'imageUrl': _imageUrl
//     };
//     return _downloadData;
//   }


//   void submit() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       authResult = await auth.createUserWithEmailAndPassword(
//         email: email.text,
//         password: password.text,
//       );
//       User user = User(
//           image: myImage,
//           imagePath: null,
//           email: email.text,
//           fullName: fullName.text,
//           contactNumber: int.parse(contactNumber.text),
//           address: address.text,
//           password: null,
//           gender: isMale ? "Male" : "Female");

//       var imageMap = await _uploadFile(myImage);

//       Firestore.instance
//           .collection("user")
//           .document(authResult.user.uid)
//           .setData({
//         "UserEmail": user.email,
//         "UserName": user.fullName,
//         "UserNumber": user.contactNumber,
//         "UserGender": user.gender,
//         "UserId": authResult.user.uid,
//         "UserAddress": user.address,
//         "UserImage": imageMap["imageUrl"],
//         "UserPath": imageMap["imagePath"]    
//       });
//     } on PlatformException catch (error) {
//       var message = "Please Check Your Internet Connection ";
//       if (error.message != null) {
//         message = error.message;
//       }
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text(message),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//       setState(() {
//         isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//       });
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text(error),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));

//       print(error);
//     }
//     Navigator.of(context)
//         .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
//     setState(() {
//       isLoading = false;
//     });
//   }

//   vaildationText() {
//     if (myImage == null) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Please Pick Image"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (fullName.text.isEmpty &&
//         email.text.isEmpty &&
//         password.text.isEmpty &&
//         contactNumber.text.isEmpty &&
//         address.text.isEmpty) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Please Fill All Text"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (fullName.text.trim() == null || fullName.text.isEmpty) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("FullName Is Empty"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (email.text.isEmpty || email.text.trim() == null) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Email is Empty"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (!regex.hasMatch(email.text)) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Please Try Vaild Email"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (password.text.isEmpty || password.text.trim() == null) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Password is Empty"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (password.text.length < 8) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Password is too short"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (contactNumber.text.isEmpty) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Phone Number is Empty"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (int.tryParse(contactNumber.text) == null) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Please Enter Vaild Number"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (int.tryParse(contactNumber.text) < 0) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Phone Number  Not Less then 0"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (contactNumber.text.length < 11 || contactNumber.text.length > 11) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Phone number must be equal 11"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else if (address.text.isEmpty) {
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text("Address is Empty"),
//         duration: Duration(milliseconds: 600),
//         backgroundColor: Theme.of(context).primaryColor,
//       ));
//     } else {
//       submit();
//     }
//   }

//   Widget _buildAllVaildTextButton() {
//     return Container(
//       height: 450,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//          MyTextFromField(
//            hintText: "fullName",
//            keybord: TextInputType.emailAddress,
//            myController: fullName,
//            myObscureText: false,
//          ),
//         MyTextFromField(
//            hintText: "Email",
//            keybord: TextInputType.emailAddress,
//            myController: email,
//            myObscureText: false,
//          ),
//          MyTextFromField(
//            hintText: "contactNumber",
//            keybord: TextInputType.emailAddress,
//            myController: contactNumber,
//            myObscureText: false,
//          ),
//          MyTextFromField(
//            hintText: "password",
//            keybord: TextInputType.emailAddress,
//            myController: password,
//            myObscureText: true,
//          ),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 isMale = !isMale;
//               });
//             },
//             child: Container(
//               height: 60,
//               width: double.infinity,
//               padding: EdgeInsets.only(left: 12),
//               decoration: BoxDecoration(
//                 color: Color(0xfffef6fa),
//                 borderRadius: BorderRadius.circular(7),
//               ),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   isMale ? "Male" : "Female",
//                   style: TextStyle(fontSize: 17, color: Color(0xff757173)),
//                 ),
//               ),
//             ),
//           ),
//          MyTextFromField(
//            hintText: "address",
//            keybord: TextInputType.emailAddress,
//            myController: address,
//            myObscureText: false,
//          ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTopPart(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             height: 105,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Signup",
//                   style: TextStyle(
//                       fontSize: 45, color: Theme.of(context).primaryColor),
//                 ),
//                 Text(
//                   "create an account",
//                   style: TextStyle(
//                       fontSize: 25, color: Theme.of(context).primaryColor),
//                 ),
//               ],
//             ),
//           ),
//           CircleAvatar(
//             radius: 60,
//             backgroundColor: Theme.of(context).primaryColor,
//             child: GestureDetector(
//               onTap: () {
//                 getImage();
//               },
//               child: CircleAvatar(
//                 radius: 55,
//                 backgroundImage: myImage == null
//                     ? AssetImage("images/chicken.jpg")
//                     : FileImage(myImage),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomButoon(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SizedBox(
//           height: 10,
//         ),
//         isLoading == false
//         ?MyRaisedutton(
//           buttonText:'SignUp' ,
//           myColor: Theme.of(context).primaryColor,
//           textColor: Colors.white,
//           whenPress: (){
//             vaildationText();
//           },
//         )
//             : CircularProgressIndicator(
//                 backgroundColor: Colors.yellow,
//               ),
//         SizedBox(
//           height: 20,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Center(
//               child: Text(
//                 "already have an account ?",
//                 style: TextStyle(color: Colors.black, fontSize: 21),
//               ),
//             ),
//             SizedBox(
//               width: 8,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (ctx) => LogIn()));
//               },
//               child: Text(
//                 "Login",
//                 style: TextStyle(
//                     color: Theme.of(context).primaryColor, fontSize: 21),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 15),
//           width: double.infinity,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 _buildTopPart(context),
//                 _buildAllVaildTextButton(),
//                 _buildBottomButoon(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

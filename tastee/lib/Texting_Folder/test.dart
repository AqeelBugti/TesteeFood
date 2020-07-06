// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Texting extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: Firestore.instance.collection("sabzifood").snapshots(),
//         builder: (ctx, streamsnapshot) {
//           if (streamsnapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//             itemCount: streamsnapshot.data.documents.length,
//             itemBuilder: (ctx, index) => Container(
//               height: 40,
//               child: Text(streamsnapshot.data.documents[index]['foodname']),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//  StreamBuilder(
//         stream: Firestore.instance.collection("sabzifood").snapshots(),
//         builder: (ctx, streamsnapshot) {
//           if (streamsnapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//             itemCount: streamsnapshot.data.documents.length,
//             itemBuilder: (ctx, index) => Container(
//               height: 40,
//               child: Text(streamsnapshot.data.documents[index]['foodname']),
//             ),
//           );
//         },
//       ),
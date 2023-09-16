import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("App Rating stars")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Library First :  'Smooth Star Rating' ",
                style: TextStyle(fontSize: 20),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // SmoothStarRating(
              //   rating: rating,
              //   size: 35,
              //   filledIconData: Icons.star,
              //   halfFilledIconData: Icons.star_half,
              //   defaultIconData: Icons.star_border,
              //   starCount: 5,
              //   allowHalfRating: true,
              //   spacing: 2.0,
              //   onRatingChanged: (value) {
              //     setState(() {
              //       rating = value;
              //       print(rating);
              //     });
              //   },
              // ),
              // Text(
              //   "You have Selected : $rating Star",
              //   style: TextStyle(fontSize: 15),
              // ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Library Second:  'Rating_Dialog ' ",
                style: TextStyle(fontSize: 20, color: Colors.deepOrange),
              ),
              // RaisedButton(
              //   onPressed: () {
              //     show();
              //   },
                // child: Text("Open Flutter Rating Dialog Box"),
              // )
            ],
          ),
        ));
  }
  // void show() {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true, // set to false if you want to force a rating
  //       builder: (context) {
  //         return RatingDialog(
  //           icon: const Icon(
  //             Icons.star,
  //             size: 100,
  //             color: Colors.blue,
  //           ), // set your own image/icon widget
  //           title: "Flutter Rating Dialog",
  //           description: "Tap a star to give your rating.",
  //           submitButton: "SUBMIT",
  //           alternativeButton: "Contact us instead?", // optional
  //           positiveComment: "We are so happy to hear 😍", // optional
  //           negativeComment: "We're sad to hear 😭", // optional
  //           accentColor: Colors.blue, // optional
  //           onSubmitPressed: (int rating) {
  //             print("onSubmitPressed: rating = $rating");
  //             // TODO: open the app's page on Google Play / Apple App Store
  //           },
  //           onAlternativePressed: () {
  //             print("onAlternativePressed: do something");
  //             // TODO: maybe you want the user to contact you instead of rating a bad review
  //           },
  //         );
  //       });
  }
// }
// void _showRatingAppDialog() {
//     final _ratingDialog = RatingDialog(
//       ratingColor: Colors.amber,
//       title: 'Rating Dialog In Flutter',
//       message: 'Rating this app and tell others what you think.'
//           ' Add more description here if you want.',
//       image: Image.asset("assets/images/devs.jpg",
//         height: 100,),
//       submitButton: 'Submit',
//       onCancelled: () => print('cancelled'),
//       onSubmitted: (response) {
//         print('rating: ${response.rating}, '
//             'comment: ${response.comment}');

//         if (response.rating < 3.0) {
//           print('response.rating: ${response.rating}');
//         } else {
//            Container();
//         }
//       },
//     );

//     showDialog(
//       context: context,
//       barrierDismissible: true, 
//       builder: (context) => _ratingDialog,
//     );
//   }




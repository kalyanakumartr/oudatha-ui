import 'package:flutter/material.dart';



class payLoadScreen extends StatefulWidget {
  var payload;

    payLoadScreen({super.key,
  required this.payload,
  });

  @override
  State<payLoadScreen> createState() => _payLoadScreenState();
}

class _payLoadScreenState extends State<payLoadScreen> {

   String? payload;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('payLoad Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'payload',
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

// class payLoadScreen extends StatelessWidget {
  

//    payLoadScreen({super.key,required this.payload,});
//   String? payload;
//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('payload Screen'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//          " payload",
//           style: const TextStyle(fontSize: 30),
//         ),
//       ),
//     );
//   }
// }
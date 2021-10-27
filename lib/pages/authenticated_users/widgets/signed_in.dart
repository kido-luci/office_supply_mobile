// import 'package:flutter/material.dart';
// import 'package:office_supply_mobile_master/controllers/google_sign_in_controller.dart';
// import 'package:office_supply_mobile_master/pages/guest/sign_in/sign_in.dart';
// import 'package:provider/provider.dart';

// class SignedIn extends StatelessWidget {
//   const SignedIn({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           backgroundImage: Image.network(
//                   Provider.of<GoogleSignInController>(context, listen: false)
//                       .googleSignInAccount!
//                       .photoUrl!)
//               .image,
//           radius: 50,
//         ),
//         Text(Provider.of<GoogleSignInController>(context, listen: false)
//             .googleSignInAccount!
//             .displayName!),
//         Text(Provider.of<GoogleSignInController>(context, listen: false)
//             .googleSignInAccount!
//             .email),
//         ActionChip(
//           avatar: const Icon(Icons.logout),
//           label: const Text('Sign out'),
//           onPressed: () {
//             Provider.of<GoogleSignInController>(context, listen: false)
//                 .signOut();
//             Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => const SignInPage()));
//           },
//         )
//       ],
//     );
//   }
// }

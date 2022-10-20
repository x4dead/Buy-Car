// part of '../create_screen.dart';

// // ignore: non_constant_identifier_names
// Future<PersistentBottomSheetController<dynamic>> ShowBottomSheet(
//     BuildContext context) async {
//   return showBottomSheet(
//     context: context,
//     builder: (context) {
//       return Container(
//         height: 200,
//         decoration: const BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 18,
//             )
//           ],
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(25),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Фото авто',
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   FloatingActionButton(
//                     backgroundColor: Colors.blue,
//                     onPressed: () async {
//                       _image =
//                           await picker.pickImage(source: ImageSource.camera);
//                       if (imageFile != null) {
//                         imageFile = File(_image!.path);
//                         checkValidation();
//                         // ignore: use_build_context_synchronously
//                         Navigator.pop(context);
//                         setState(() {});
//                       }
//                     },
//                     child: const Icon(Icons.camera, size: 35),
//                   ),
//                   FloatingActionButton(
//                     backgroundColor: Colors.blue,
//                     onPressed: () async {
//                       _image =
//                           await picker.pickImage(source: ImageSource.gallery);
//                       // if (imageFile != null) {
//                       imageFile = File(_image!.path);
//                       checkValidation();
//                       // ignore: use_build_context_synchronously
//                       Navigator.pop(context);
//                       setState(() {});
//                       // }
//                     },
//                     child: const Icon(
//                       Icons.image,
//                       size: 35,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 7),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: const [
//                   Text(
//                     'Камера',
//                     style: TextStyle(fontSize: 15),
//                   ),
//                   Text(
//                     'Галерея',
//                     style: TextStyle(fontSize: 15),
//                   )
//                 ],
//               ),
//               const Spacer(),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

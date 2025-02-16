// import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
// import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class OnboardingScreen4 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<OnboardingCubit>().state;
//     if (state is OnboardingDataChanged) {
//       // Prikazivanje sačuvanih podataka
//       return Scaffold(
//         appBar: AppBar(title: Text('Onboarding - Final Step')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text('First Name: ${state.firstName}'),
//               Text('Last Name: ${state.lastName}'),
//               Text('Date of Birth: ${state.dateOfBirth}'),
//               Text('Weight: ${state.weight}'),
//               Text('Height: ${state.height}'),
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<OnboardingCubit>().saveUserData();
//                 },
//                 child: Text('Finish'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

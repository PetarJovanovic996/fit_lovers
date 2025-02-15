import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController dateOfBirthController =
      TextEditingController(); // Novi controller za datum

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(labelText: 'Weight'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: heightController,
                  decoration: InputDecoration(labelText: 'Height'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),

                // Novi TextField za datum rođenja
                GestureDetector(
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      // Formatiranje datuma u string i upisivanje u controller
                      dateOfBirthController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: dateOfBirthController,
                      decoration: InputDecoration(labelText: 'Date of Birth'),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Preuzimanje unetih podataka
                    String firstName = firstNameController.text;
                    String lastName = lastNameController.text;
                    double weight = double.tryParse(weightController.text) ?? 0;
                    double height = double.tryParse(heightController.text) ?? 0;
                    String dateOfBirthString = dateOfBirthController.text;

                    // Ako datum nije unet, prikaži grešku
                    if (dateOfBirthString.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please select a date of birth")));
                      return;
                    }

                    // Parsiranje unetog datuma
                    DateTime? dateOfBirth =
                        DateTime.tryParse(dateOfBirthString);

                    // Ako datum nije validan, prikaži grešku
                    if (dateOfBirth == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid date format")));
                      return;
                    }

                    // Pozivanje funkcije za snimanje podataka u Firebase
                    context.read<OnboardingCubit>().updateUserData(
                          fName: firstName,
                          lName: lastName,
                          dob: dateOfBirth,
                          w: weight,
                          h: height,
                        );

                    context.read<OnboardingCubit>().saveUserData();
                  },
                  child: Text('Save Info'),
                ),
                if (state is OnboardingLoading) CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}

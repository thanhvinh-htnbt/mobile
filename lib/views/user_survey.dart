import 'package:flutter/material.dart';
import 'package:mobile/constants/app_color.dart';

class UserSurvey extends StatefulWidget {
  const UserSurvey({super.key});

  @override
  _UserSurveyState createState() => _UserSurveyState();
}

class _UserSurveyState extends State<UserSurvey> {
  int _currentStep = 0;
  final TextEditingController _nameController = TextEditingController();
  String _selectedGoal = '';
  String _selectedGender = '';
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightGoalController = TextEditingController();
  double _goalPerWeek = 0.2;
  void _nextStep() {
    setState(() {
      if (_currentStep < 4) {
        _currentStep++;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            LinearProgressIndicator(
              value: (_currentStep + 1) / 4,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _currentStep == 0
                    ? StepOne(nameController: _nameController)
                    : _currentStep == 1
                        ? StepTwo(
                            selectedGoal: _selectedGoal,
                            onGoalSelected: (goal) {
                              setState(() {
                                _selectedGoal = goal;
                              });
                            },
                          )
                        : _currentStep == 2
                          ? StepThree(
                              selectedGender: _selectedGender,
                              onGenderSelected: (gender) {
                                setState(() {
                                  _selectedGender = gender;
                                });
                              },
                              ageController: _ageController,
                              heightController: _heightController,
                              weightController: _weightController,
                            )  
                          : _currentStep == 3
                            ? StepFour(
                                weightGoalController: _weightGoalController,
                                goalPerWeek: _goalPerWeek,
                                onGoalPerWeekSelected: (goal) {
                                  setState(() {
                                    _goalPerWeek = goal;
                                  });
                                },
                              )
                             : Summary(
                                name: _nameController.text,
                                goal: _selectedGoal,
                                gender: _selectedGender,
                                age: _ageController.text,
                                height: _heightController.text,
                                weight: _weightController.text,
                                weightGoal: _weightGoalController.text,
                                goalPerWeek: _goalPerWeek,
                              ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _previousStep,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: AppColors.secondaryColor,
                  ),
                  child: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor, // Background color
                    ),
                    child: const Text('Next', style: TextStyle(color: AppColors.inverseTextColor)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StepOne extends StatelessWidget {
  final TextEditingController nameController;

  const StepOne({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('First, What can we call you?'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your name',
            ),
            style: TextStyle(color: AppColors.defaultTextColor),
          ),
        ),
      ],
    );
  }
}

class StepTwo extends StatelessWidget {
  final String selectedGoal;
  final ValueChanged<String> onGoalSelected;

  const StepTwo({super.key, required this.selectedGoal, required this.onGoalSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('What is your goal?'),
        GestureDetector(
          onTap: () {
            onGoalSelected('Gain Weight');
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor2,
              border: Border.all(
                color: selectedGoal == 'Gain Weight'
                    ? AppColors.primaryColor
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: const Text('Gain Weight'),
              leading: Checkbox(
                value: selectedGoal == 'Gain Weight',
                onChanged: (bool? value) {
                  onGoalSelected(value! ? 'Gain Weight' : '');
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            onGoalSelected('Lose Weight');
          },         
          child: Container(
            decoration: BoxDecoration(
              color:AppColors.backgroundColor2,
              border: Border.all(
                color: selectedGoal == 'Lose Weight'
                    ? AppColors.primaryColor
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: const Text('Lose Weight'),
              leading: Checkbox(
                value: selectedGoal == 'Lose Weight',
                onChanged: (bool? value) {
                  onGoalSelected(value! ? 'Lose Weight' : '');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class StepThree extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onGenderSelected;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;

  const StepThree({super.key, 
    required this.selectedGender,
    required this.onGenderSelected,
    required this.ageController,
    required this.heightController,
    required this.weightController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Tell us more about you'),
        Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onGenderSelected('Male');
                },
                child: Container(
                  decoration: BoxDecoration(
                  color:AppColors.backgroundColor2,
                    border: Border.all(
                      color: selectedGender == 'Male'
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: const Text('Male'),
                    leading: Checkbox(
                      value: selectedGender == 'Male',
                      onChanged: (bool? value) {
                        onGenderSelected(value! ? 'Male' : '');
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onGenderSelected('Female');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:AppColors.backgroundColor2,
                    border: Border.all(
                      color: selectedGender == 'Female'
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: const Text('Female'),
                    leading: Checkbox(
                      value: selectedGender == 'Female',
                      onChanged: (bool? value) {
                        onGenderSelected(value! ? 'Female' : '');
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: ageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your age',
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: AppColors.defaultTextColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: heightController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your height (cm)',
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: AppColors.defaultTextColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: weightController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your weight (kg)',
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: AppColors.defaultTextColor),
          ),
        ),
      ],
    );
  }
}
class StepFour extends StatelessWidget {
  final TextEditingController weightGoalController;
  final double goalPerWeek;
  final ValueChanged<double> onGoalPerWeekSelected;

  const StepFour({super.key, 
    required this.weightGoalController,
    required this.goalPerWeek,
    required this.onGoalPerWeekSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Step 4: Enter your weight goal and goal per week'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: weightGoalController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your weight goal (kg)',
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: AppColors.defaultTextColor),
          ),
        ),
        GestureDetector(
          onTap: () {
            onGoalPerWeekSelected(0.2);
          },
          child: Container(
            decoration: BoxDecoration(
              color: goalPerWeek == 0.2
                  ? AppColors.backgroundColor2
                  : Colors.transparent,
              border: Border.all(
                color: goalPerWeek == 0.2
                    ? AppColors.primaryColor
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: const Text('0.2 kg per week'),
              leading: Radio<double>(
                value: 0.2,
                groupValue: goalPerWeek,
                onChanged: (double? value) {
                  onGoalPerWeekSelected(value!);
                },
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onGoalPerWeekSelected(0.5);
          },
          child: Container(
            decoration: BoxDecoration(
              color: goalPerWeek == 0.5
                  ? AppColors.backgroundColor2
                  : Colors.transparent,
              border: Border.all(
                color: goalPerWeek == 0.5
                    ? AppColors.primaryColor
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: const Text('0.5 kg per week'),
              leading: Radio<double>(
                value: 0.5,
                groupValue: goalPerWeek,
                onChanged: (double? value) {
                  onGoalPerWeekSelected(value!);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class Summary extends StatelessWidget {
  final String name;
  final String goal;
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String weightGoal;
  final double goalPerWeek;

  Summary({
    required this.name,
    required this.goal,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.weightGoal,
    required this.goalPerWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Name: $name'),
          Text('Goal: $goal'),
          Text('Gender: $gender'),
          Text('Age: $age'),
          Text('Height: $height cm'),
          Text('Weight: $weight kg'),
          Text('Weight Goal: $weightGoal kg'),
          Text('Goal per Week: ${goalPerWeek.toString()} kg'),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class UserSurvey extends StatefulWidget {
  const UserSurvey({super.key});

  @override
  _UserSurveyState createState() => _UserSurveyState();
}

class _UserSurveyState extends State<UserSurvey> {
  int _currentStep = 0;

  void _nextStep() {
    setState(() {
      if (_currentStep < 3) {
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
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Text('Step ${_currentStep + 1}'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _previousStep,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _nextStep,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

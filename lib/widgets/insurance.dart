import 'package:ada_hackathon_app/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Insurance extends StatefulWidget {
  const Insurance({super.key});

  @override
  State<Insurance> createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _monthlyPayment = TextEditingController();
  final TextEditingController _birthDate = TextEditingController();
  final TextEditingController _fin = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _workplace = TextEditingController();
  final TextEditingController _profession = TextEditingController();

  bool isSubmitted = false;

  final _myBox = Hive.box('user');

  void pickDate() async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2115));

    if (picked != null) {
      setState(() {
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void insure() async {
    if (_monthlyPayment.text.isEmpty || isSubmitted) return;

    bool auth = await Authentication.authentication();

    if (auth) {
      setState(() {
        _birthDate.text = _myBox.get('date');
        _fin.text = _myBox.get('fin');
        _tel.text = _myBox.get('tel');
        _email.text = _myBox.get('email');
        _workplace.text = _myBox.get('workplace');
        _profession.text = _myBox.get('profession');
        isSubmitted = true;
      });

      Future.delayed(const Duration(milliseconds: 700), () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Color(0xff097a5e), size: 60),
                  SizedBox(height: 20),
                  Text(
                    'Success',
                    style: TextStyle(
                      color: Color(0xff097a5e),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Insurance process completed successfully.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Color(0xff097a5e),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Insurance',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff097a5e),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: _monthlyPayment,
              decoration: const InputDecoration(
                hintText: 'Monthly payment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const Divider(height: 50),
            IgnorePointer(
              child: TextFormField(
                readOnly: true,
                controller: _birthDate,
                decoration: const InputDecoration(
                  hintText: 'Birth date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            IgnorePointer(
              child: TextFormField(
                controller: _fin,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'FIN',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            IgnorePointer(
              child: TextFormField(
                controller: _tel,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Tel number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            IgnorePointer(
              child: TextFormField(
                controller: _email,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            IgnorePointer(
              child: TextFormField(
                controller: _workplace,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Workplace',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            IgnorePointer(
              child: TextFormField(
                controller: _profession,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Profession',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff097a5e)),
                ),
                onPressed: insure,
                child: Container(
                  alignment: Alignment.center,
                  child: isSubmitted
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : const Text(
                          'INSURE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

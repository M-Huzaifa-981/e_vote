import 'package:flutter/material.dart';
import '../database/users_db.dart';
import '../models/user_model.dart';
import '../services/finger_print_service.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  final _cnicController = TextEditingController();
  final _nameController = TextEditingController();


  Future<void> _register() async {
    final finger = await FingerprintService.captureFingerprint();
    if (finger == null) return;


    registeredUsers.add(
      User(
        cnic: _cnicController.text,
        name: _nameController.text,
        fingerprint: finger,
      ),
    );
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Voter Registered')));
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register Voter')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              TextField(
              controller: _cnicController,
              decoration: const InputDecoration(labelText: 'CNIC'),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Scan Finger & Register'),
                ),
              ],
            ),
          ),
        ),
    );
  }
}


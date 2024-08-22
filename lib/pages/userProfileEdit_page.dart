import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileEdit extends StatefulWidget {
  @override
  _UserProfileEditState createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await firestore.collection('users').doc(user.uid).get();
      Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
      _nameController.text = data['userName'] ?? '';
      _yearController.text = data['year'] ?? '';
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.collection('users').doc(user.uid).update({
          'userName': _nameController.text,
          'year': _yearController.text,
        });
        Navigator.pop(context);
      }
    }
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Update'),
          content: Text('Are you sure you want to update your profile?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Update',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _updateUserData();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                cursorColor: Colors.deepPurple,
                showCursor: true,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                cursorColor: Colors.deepPurple,
                showCursor: true,
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.all(16),
                    ),
                  ),
                  onPressed: _showConfirmationDialog,
                  child: const Text(
                    'Save Changes',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

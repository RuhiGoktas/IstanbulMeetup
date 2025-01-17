import 'package:flutter/material.dart';
import 'dart:convert'; // For encoding JSON if needed
import 'package:http/http.dart' as http; // For HTTP requests

class RSVPFormPage extends StatefulWidget {
  @override
  _RSVPFormPageState createState() => _RSVPFormPageState();
}

class _RSVPFormPageState extends State<RSVPFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? _attendance = 'Yes';
  String? _names;
  String? _whatsapp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RSVP to Theatre Club Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Can you attend?', style: TextStyle(fontSize: 18)),
                DropdownButton<String>(
                value: _attendance,
                isExpanded: true, // Makes it full-width
                style: TextStyle(fontSize: 16, color: Colors.black),
                items: ['Yes', 'No'].map((String value) {
                    return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    );
                }).toList(),
                onChanged: (newValue) {
                    setState(() {
                    _attendance = newValue;
                    });
                },
                ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Names of people attending'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter names';
                  }
                  return null;
                },
                onSaved: (value) {
                  _names = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'WhatsApp Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your WhatsApp number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _whatsapp = value;
                },
              ),
              SizedBox(height: 20),
            ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, // Button color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
                if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('RSVP Submitted!')),
                );
                }
            },
            child: Text('Submit RSVP'),
            ),

            ],
          ),
        ),
      ),
    );
  }
}

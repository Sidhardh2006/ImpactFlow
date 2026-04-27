import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/need.dart';
import '../providers/need_provider.dart';

class NgoScreen extends StatefulWidget {
  const NgoScreen({super.key});

  @override
  State<NgoScreen> createState() => _NgoScreenState();
}

class _NgoScreenState extends State<NgoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _urgency = 3;
  final _peopleController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _randomizeLocation();
  }

  void _randomizeLocation() {
    // Demo location: 16.5131 N, 80.5165 E
    const double baseLat = 16.5131;
    const double baseLng = 80.5165;

    final random = Random();
    // Add a small random offset for visualization (approx +/- 5km)
    double offsetLat = (random.nextDouble() - 0.5) * 0.05;
    double offsetLng = (random.nextDouble() - 0.5) * 0.05;

    _latController.text = (baseLat + offsetLat).toStringAsFixed(4);
    _lngController.text = (baseLng + offsetLng).toStringAsFixed(4);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _peopleController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('AI is verifying and categorizing your request...'),
                ],
              ),
            ),
          ),
        ),
      );

      final newNeed = Need(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        urgency: _urgency,
        peopleAffected: int.parse(_peopleController.text),
        latitude: double.parse(_latController.text),
        longitude: double.parse(_lngController.text),
        createdAt: DateTime.now(),
        timestamp: DateTime.now(),
      );

      try {
        await Provider.of<NeedProvider>(context, listen: false).addNeedWithAI(newNeed);
        
        if (!mounted) return;
        Navigator.pop(context); // Close loading dialog

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('Success'),
              ],
            ),
            content: const Text('Your requirement has been posted and prioritized by our AI engine.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back home
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Need')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help us understand the requirement',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Provide accurate details to ensure proper prioritization.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              _buildFieldLabel('TITLE'),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration('e.g., Medical Supplies Needed', Icons.title),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 24),
              _buildFieldLabel('DESCRIPTION'),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: _inputDecoration(
                    'Detail the specific needs and location...', Icons.description),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(height: 24),
              _buildFieldLabel('URGENCY LEVEL ($_urgency/5)'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Slider(
                  value: _urgency.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: Theme.of(context).colorScheme.primary,
                  label: _urgency.toString(),
                  onChanged: (value) {
                    setState(() {
                      _urgency = value.toInt();
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              _buildFieldLabel('PEOPLE AFFECTED'),
              TextFormField(
                controller: _peopleController,
                decoration: _inputDecoration('Estimate number of people', Icons.group),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel('LATITUDE'),
                        TextFormField(
                          controller: _latController,
                          decoration: _inputDecoration('e.g., 12.97', Icons.location_on),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Required';
                            if (double.tryParse(value) == null) return 'Invalid';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel('LONGITUDE'),
                        TextFormField(
                          controller: _lngController,
                          decoration: _inputDecoration('e.g., 77.59', Icons.location_on),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Required';
                            if (double.tryParse(value) == null) return 'Invalid';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Publish Requirement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
      ),
    );
  }
}

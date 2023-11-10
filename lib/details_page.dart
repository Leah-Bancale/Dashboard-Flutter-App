import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final String itemName;

  DetailsPage({required this.itemName});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Map<String, dynamic> countryDetails = {};

  @override
  void initState() {
    super.initState();
    fetchCountryDetails();
  }

  Future<void> fetchCountryDetails() async {
    final response = await http.get(
        Uri.parse('https://restcountries.com/v3.1/name/${widget.itemName}'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        setState(() {
          countryDetails = data[0];
        });
      } else {
        throw Exception('Country details not found');
      }
    } else {
      throw Exception('Failed to load country details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details - ${widget.itemName}'),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Details for ${widget.itemName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(
                'CURRENCY: ${countryDetails['currencies'][0]['name'] ?? 'N/A'}'),
            Text('Demonym: ${countryDetails['demonym'] ?? 'N/A'}'),
            Text(
                'LANGUAGE: ${countryDetails['languages'][0]['name'] ?? 'N/A'}'),
            Text('CAPITAL CITY: ${countryDetails['capital'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}

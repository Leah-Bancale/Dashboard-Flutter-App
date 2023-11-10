import 'package:flutter/material.dart';
import 'details_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> countriesData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> apiCountriesData = data.cast<Map<String, dynamic>>();

      setState(() {
        countriesData = apiCountriesData;
      });
    } else {
      throw Exception('Failed to load country data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard - All Countries'),
         backgroundColor: Colors.redAccent,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 20.0,
            children: countriesData.map((country) {
              String countryName = country['name']['common'];
              return Container(
                width: MediaQuery.of(context).size.width / 2 - 20.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(countryName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(itemName: countryName),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

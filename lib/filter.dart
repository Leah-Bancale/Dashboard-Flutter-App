import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<Map<String, dynamic>> countriesData = [];
  TextEditingController filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

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

  List<Map<String, dynamic>> filterCountries(String filter) {
    return countriesData
        .where((country) =>
            country['name']['common'].toLowerCase().contains(filter.toLowerCase()) ||
            country['capital'].toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Countries'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: filterController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Filter by country or capital',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchDataFromAPI(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Map<String, dynamic>> filteredCountries = filterCountries(filterController.text);
                  return ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      String countryName = filteredCountries[index]['name']['common'];
                      String capital = filteredCountries[index]['capital'];
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text(countryName),
                          subtitle: Text('Capital: $capital'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

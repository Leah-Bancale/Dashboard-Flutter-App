import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Map<String, int> letterCounts = {};

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> countriesData = json.decode(response.body);
      countCountriesByLetter(countriesData);
    } else {
      throw Exception('Failed to load country data');
    }
  }

  void countCountriesByLetter(List<dynamic> countriesData) {
    for (var country in countriesData) {
      String countryName = country['name']['common'];
      String firstLetter = countryName.substring(0, 1).toUpperCase();

      setState(() {
        letterCounts[firstLetter] = (letterCounts[firstLetter] ?? 0) + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics Page'),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Country Counts by Letter',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 20,
                runSpacing: 20,
                children: [
                  for (var letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''))
                    if (letterCounts.containsKey(letter))
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            Text('$letter: ${letterCounts[letter]} countries'),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

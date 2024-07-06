import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter City Name',
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  prefixIcon: Icon(Icons.pin_drop),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context, cityName),
                child: const Text('Search'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

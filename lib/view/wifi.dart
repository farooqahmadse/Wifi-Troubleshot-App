import 'package:flutter/material.dart';
import 'package:smartwifi/services/api_services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WifiInfoScreen());
  }
}

class WifiInfoScreen extends StatefulWidget {
  const WifiInfoScreen({super.key});

  @override
  State<WifiInfoScreen> createState() => _WifiInfoScreenState();
}

class _WifiInfoScreenState extends State<WifiInfoScreen> {
  Map<String, dynamic> devices = {};
  List<dynamic> suggestions = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    devices = await ApiService.getDevices();
    suggestions = await ApiService.getSuggestions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart Wi-Fi Advisor")),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text("Device Usage:", style: TextStyle(fontSize: 18)),
            ...devices.entries.map(
              (e) => ListTile(
                title: Text(e.key),
                subtitle: Text("${e.value} bytes"),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Suggestions:", style: TextStyle(fontSize: 18)),
            ...suggestions.map(
              (s) => ListTile(
                title: Text(s['device']),
                subtitle: Text("${s['problem']} - ${s['suggestion']}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

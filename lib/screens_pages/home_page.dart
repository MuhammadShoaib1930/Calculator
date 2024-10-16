import 'dart:async';
import 'package:calculator/logics/basic_operations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String resultValue = "0";
TextEditingController textController = TextEditingController();
StreamController<String> streamControllerString = StreamController<String>();
StreamController<List<String>> streamControllerList =StreamController<List<String>>();
List<String> history = [];

class _HomePageState extends State<HomePage> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page."),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: StreamBuilder<List<String>>(
              stream: streamControllerList.stream, // Replace with your stream
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return
                    const CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      strokeWidth: 50,
                      strokeAlign: 0.01,
                      color: Colors.grey,

                    ); // Show loading indicator
                } else if (snapshot.hasData) {
                  List<String> items = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index]), // Display each list item
                      );
                    },
                  );
                } else {
                  return const Text('No data available'); // Handle no data
                }
              },
            ),
          ),
          SizedBox(
            width: 300,
            child: StreamBuilder<String>(
              stream: streamControllerString.stream,
              initialData: "",
              builder: (context, snapshot) {
                return Text(
                  snapshot.data.toString(),
                  textDirection: TextDirection.rtl,
                );
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.none,
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'write some think.';
                    }
                    if (!RegExp(
                            r'^[\+\-]?(\d+(\.\d+)?)([\*\+\-\/%]\d+(\.\d+)?)*$')
                        .hasMatch(value)) {
                      if (RegExp(r'[\+\-\*\/%]{2,}').hasMatch(value)) {
                        return 'No consecutive operators allowed.';
                      } else if (RegExp(r'\d*\.\d*\.\d*').hasMatch(value)) {
                        return 'A number can only contain one decimal point.';
                      } else {
                        return 'Invalid format.';
                      }
                    }
                    mainFunction();
                    return null; // Input is valid
                  },
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomizedButtons(label: "+"),
                    CustomizedButtons(label: "-"),
                    CustomizedButtons(label: "/"),
                    CustomizedButtons(label: "*"),
                    CustomizedButtons(label: "C"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomizedButtons(label: "1"),
                    CustomizedButtons(label: "2"),
                    CustomizedButtons(label: "3"),
                    CustomizedButtons(label: "4"),
                    CustomizedButtons(label: "_"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomizedButtons(label: "5"),
                    CustomizedButtons(label: "6"),
                    CustomizedButtons(label: "7"),
                    CustomizedButtons(label: "8"),
                    CustomizedButtons(label: "."),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomizedButtons(label: "9"),
                    CustomizedButtons(label: "0"),
                    CustomizedButtons(label: "("),
                    CustomizedButtons(label: ")"),
                    CustomizedButtons(label: "="),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomizedButtons extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color fontColor;
  const CustomizedButtons(
      {super.key,
      required this.label,
      this.fontSize = 18,
      this.fontColor = Colors.brown});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        buttonsFunctional(label);
      },
      child: Center(
        child: Text(
          " $label ",
          style: TextStyle(fontSize: 18, color: fontColor),
        ),
      ),
    );
  }
}

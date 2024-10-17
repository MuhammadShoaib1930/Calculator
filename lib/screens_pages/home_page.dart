import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController streamController = StreamController();
  List<String> list = ['1','2','3'];
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          centerTitle: true,
        ),
        body: Column(children: [
          SizedBox(
            width: double.infinity,
            height: 310,
            child: StreamBuilder(
              initialData: "WellCome to Calculator",
              stream: streamController.stream,
              builder: (context, snapshot) {
                return (list.isNotEmpty)
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              list[index].toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300
                              ),
                              
                              ),
                          );
                        },
                        itemCount: list.length,
                        dragStartBehavior: DragStartBehavior.down,
                      )
                    : const Center(child: Text("WellCome to Calculator"));
              },
            ),
          ),
          Form(
              child: SizedBox(
            width: 380,
            child: TextFormField(
              controller: textEditingController,
              textAlign:TextAlign.end,
              showCursor: true,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                value = value.trim();
                if (!RegExp(r'^-?(\d+(\.\d+)?)([+\-*/](\d+(\.\d+)?))*$').hasMatch(value)) {
                  return 'Invalid expression. Only valid numbers and operators are allowed';
                }
                // valid 
                return null;
              },
            ),
          ))
        ]));
  }
}

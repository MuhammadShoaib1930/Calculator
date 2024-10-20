import 'dart:async';
import 'package:calculator/logics/basic_operations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

StreamController streamController = StreamController();

class _HomePageState extends State<HomePage> {
  List<String> list = [];
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
            height: 260,
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
                                  fontSize: 18, fontWeight: FontWeight.w300),
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
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                list.clear();
                textEditingController.value = TextEditingValue.empty;
                streamController.add(0);
              },
              child: const Text("Clean")),
          const SizedBox(
            height: 10,
          ),
          Form(
              child: SizedBox(
            width: 380,
            child: TextFormField(
              controller: textEditingController,
              textAlign: TextAlign.end,
              keyboardType: TextInputType.none,
              showCursor: true,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                bool isEqual = false;
                if (value == null || value.isEmpty) {
                  return null;
                }
                value = value.trim();
                if (!RegExp(r'^-?(\d+(\.\d+)?)([+\-*/](\d+(\.\d+)?))*$')
                    .hasMatch(value)) {
                  if (RegExp(r'=$').hasMatch(value)) {
                    isEqual = true;
                  } else {
                    return 'Invalid expression.';
                  }
                }
                // valid
                var inputsValue = textEditingController.text.toString();
                var outputValues = calculationFunction(inputsValue);
                textEditingController.text = outputValues;
                if (isEqual) {
                  list.add(outputValues);
                  if (list.length > 10) {
                    list.removeAt(0);
                  }
                }

                return null;
              },
            ),
          )),
          KeyBoardLayout(textEditingController: textEditingController)
        ]));
  }
}

class KeyBoardLayout extends StatelessWidget {
  final TextEditingController textEditingController;
  const KeyBoardLayout({super.key , required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Row(
            children: [
              elevatedButtonFunction("+", textEditingController),
              elevatedButtonFunction("1", textEditingController),
              elevatedButtonFunction("2", textEditingController),
              elevatedButtonFunction("3", textEditingController),
              elevatedButtonFunction("%", textEditingController),
            ],
          ),
          Row(
            children: [
              elevatedButtonFunction("-", textEditingController),
              elevatedButtonFunction("4", textEditingController),
              elevatedButtonFunction("5", textEditingController),
              elevatedButtonFunction("6", textEditingController),
              elevatedButtonFunction("_", textEditingController),
            ],
          ),
          Row(
            children: [
              elevatedButtonFunction("/", textEditingController),
              elevatedButtonFunction("7", textEditingController),
              elevatedButtonFunction("8", textEditingController),
              elevatedButtonFunction("9", textEditingController),
              elevatedButtonFunction(".", textEditingController),
            ],
          ),
          Row(
            children: [
              elevatedButtonFunction("*", textEditingController),
              elevatedButtonFunction("0", textEditingController),
              elevatedButtonFunction("py", textEditingController),
              elevatedButtonFunction("SqR", textEditingController),
              elevatedButtonFunction("=", textEditingController),
            ],
          ),
        ],
      ),
    );
  }
}

elevatedButtonFunction(
    String clickValue, TextEditingController textEditingController) {
  return ElevatedButton(
      onPressed: () {
        textEditingController.text = clickValue;
      },
      child: Text(clickValue));
}

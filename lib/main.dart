import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed;
  bool isActive = false;
  List<int> values;
  List<int> val;
  int counter = 1;
  Timer timer;
  int max;

  @override
  void initState() {
    secondsPassed = 0;
    values = getValues();
    val = indexColor();
    print(values);
    super.initState();
  }

  List<int> indexColor() {
    List<int> list = List<int>();
    for (int i = 0; i < 25; i++) {
      list.add(1);
    }
    return list;
  }

  void handleTimeOut() {
    setState(() {
      if (!isActive) {
        secondsPassed = secondsPassed + 1;
      } else {
        timer.cancel(); //stop timer
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTimeOut();
      });
    }
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);
    return MaterialApp(
      title: "schulte table",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Schulte Table"),
        ),
        body: Center(
          child: Column(
            children: [
              Text("time:" +
                  hours.toString().padLeft(2, "0") +
                  ":" +
                  minutes.toString().padLeft(2, "0") +
                  ":" +
                  seconds.toString().padLeft(2, "0")),
              Text("best score:" + max.toString()),
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  child: GridView.count(
                    mainAxisSpacing: 0.5,
                    crossAxisSpacing: 0.5,
                    crossAxisCount: 5,
                    children: List.generate(25, (index) {
                      return Container(
                        child: ElevatedButton(
                          child: Text((values[index]).toString()),
                          onPressed: () {
                            setState(() {
                              if (values[index] == counter) {
                                //counter 1 2 3..
                                val[index] = 2;
                                counter++;
                                if (values[index] == 25) {
                                  counter = 1;
                                  if (max == null) {
                                    max = secondsPassed;
                                  }
                                  if (max != null) {
                                    if (secondsPassed < max)
                                      max = secondsPassed;
                                  }
                                  isActive = true; //timer durdurulmasi icin
                                }
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              primary:
                                  val[index] == 2 ? Colors.pink : Colors.blue),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: ElevatedButton(
                      child: Text("RESTART"),
                      onPressed: () {
                        setState(() {
                          values = getValues();
                          val = indexColor();
                          secondsPassed = 0;
                          isActive = false;
                          timer = null;
                        });
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static List<int> getValues() {
    var random = new Random();

    List<int> list = List<int>();
    list.add(random.nextInt(25));

    for (int i = 1; i < 25; i++) {
      int x = random.nextInt(25);
      if (list.contains(x)) {
        //unique elemanlar
        i--;
      } else {
        list.add(x);
      }
    }
    for (int i = 0; i < 25; i++) {
      list[i]++;
    }
    return list;
  }
}

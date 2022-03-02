import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'button.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> button_list = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '^',
    '='
  ];
  String userQ = " ";
  String userA = "00.0";
  @override
  void initState() {
    // TODO: implement initState
    print(button_list[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            color: Colors.white12,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child:
                        Text(
                            userA,

                          style: TextStyle(color: Colors.black,
                              fontSize: 36.0, fontWeight: FontWeight.w600),
                        )
                      // ],
                      // ),
                    ),
                  ),
                  // Expanded(
                  //   child:
                    Container(
                        padding: const EdgeInsets.only(top: 16.0, right: 9),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userQ,
                          style: TextStyle(
                              fontSize: 26.0, fontWeight: FontWeight.w600),
                        )),
                  // )
                ],
              ),
            ),
          )),
          Expanded(
            flex: 2,
            child: Container(
              // padding: EdgeInsets.only(top: 12),
              color: Colors.white,
              child: GridView.builder(
                  itemCount: button_list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, mainAxisSpacing: 0),
                  itemBuilder: (context, int index) {
                    if (index == 0) {
                      return button(
                          text: "C",
                          color: Colors.white,
                          buttoncolor: Colors.orange,
                          buttontapped: () {
                            setState(() {
                              HapticFeedback.heavyImpact();
                              userQ = " ";
                              userA = "0.00 ";
                            });
                          });
                    } else if (index == 1) {
                      return button(
                          text: "DEL",
                          color: Colors.white,
                          buttoncolor: Colors.orange,
                          buttontapped: () {
                            setState(() {
                              HapticFeedback.heavyImpact();
                              userQ = userQ.substring(0, userQ.length - 1);
                            });
                          });
                    }else if (button_list[index] == "=") {
                      return button(
                          text: "=",
                          color: Colors.white,
                          buttoncolor: Colors.orange,
                          buttontapped: () {
                            setState(() {
                              HapticFeedback.heavyImpact();
                              Answer();
                              // userQ = userQ.substring(0, userQ.length - 1);
                            });
                          });
                    }
                    return button(
                        text: button_list[index],
                        color: Colors.white,
                        buttoncolor: isOpearand(button_list[index])
                            ? Colors.orange
                            : Colors.black,
                        buttontapped: () {
                          setState(() {
                            HapticFeedback.heavyImpact();
                            userQ += isOpearand(userQ[userQ.length - 1]) && isOpearand(button_list[index]) ? "" : button_list[index] ;
                            // userA = " ";
                          });
                        });

                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOpearand(String a) {
    if (a == "/" ||
        a == "x" ||
        a == "-" ||
        a == "+" ||
        a == "." ||
        a == "^" ||
        a == "=" ||
        a == "%") {
      return true;
    }
    return false;
  }
  void Answer()
  {
    String finalQ = userQ;
    finalQ = finalQ.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalQ);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userA = eval.toString();
  }
}

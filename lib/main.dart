import 'package:calcuitask/calculator_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

enum mathOperationsPrimary { Add, Sub, Mul, Div, Equ }
enum mathOperationsSecondary { AC, Negate, Percentage }

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: CalculatorTheme.lightTheme,
      darkTheme: CalculatorTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({Key? key}) : super(key: key);

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String output = '';
  List<String> firstRowButtons = ['AC', '+/-', '%'];
  static String divideSign = String.fromCharCode(0x00F7);
  List<String> operationButtons = ['÷', 'x', '+', '-', '='];
  List<List<String>> naturalNumbers = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
  ];
  List<String> bottomElements = ['.', '='];
  double firstNum = 0;
  double secondNum = 0;
  String operand = '';
  double finalResult = 0;

  performMathOperation(String selectedOperation) {
    switch (selectedOperation) {
      case 'AC':
        if (output.isNotEmpty) {
          setState(() {
            firstNum = 0;
            secondNum = 0;
            finalResult = 0;
            output = '';
          });
        }

        break;
      case '+/-':
        if (output.isNotEmpty) {
          setState(() {
            if (output.contains('-')) {
              output = output.replaceAll(RegExp('-'), '');
            } else {
              String result = '-';
              result += output;
              output = result;
            }
          });
        }

        break;
      case '%':
        if (output.isNotEmpty) {
          double? result = double.tryParse(output);
          if (result != null) {
            result /= 100;
            setState(() {
              output = result.toString();
            });
          }
        }

        break;
      case '+':
        if (output.isNotEmpty) {
          setState(() {
            firstNum = double.tryParse(output)!;
            operand = '+';
            output = '';
            // output+='+';
          });
        }
        break;
      case '-':
        if (output.isNotEmpty) {
          setState(() {
            firstNum = double.tryParse(output)!;
            operand = '-';
            output = '';
          });
        }
        break;
      case 'x':
        if (output.isNotEmpty &&
            !(output.contains(divideSign, output.length - 1))) {
          setState(() {
            firstNum = double.tryParse(output)!;
            operand = '*';
            output = '';
          });
        }
        break;
      case '÷':
        if (output.isNotEmpty &&
            !(output.contains(divideSign, output.length - 1))) {
          setState(() {
            firstNum = double.tryParse(output)!;
            operand = '/';
            output = '';
          });
        }
        break;
      case '=':
        if (output.isNotEmpty) {
          secondNum = double.tryParse(output)!;
          if (operand == '+') {
            finalResult = firstNum + secondNum;
            setState(() {
              output = finalResult.toString();
              firstNum = 0;
              secondNum = 0;
              operand = '';
            });
          } else if (operand == '-') {
            finalResult = firstNum - secondNum;
            setState(() {
              output = finalResult.toString();
              firstNum = 0;
              secondNum = 0;
              operand = '';
            });
          } else if (operand == '*') {
            finalResult = firstNum * secondNum;
            setState(() {
              output = finalResult.toString();
              firstNum = 0;
              secondNum = 0;
              operand = '';
            });
          } else if (operand == '/') {
            finalResult = firstNum / secondNum;
            setState(() {
              output = finalResult.toString();
              firstNum = 0;
              secondNum = 0;
              operand = '';
            });
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size buttonSize = Size(80, 80);
    Widget lowerElements = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 170,
          height: 60,
          child: NeumorphicButton(
              style: NeumorphicStyle(
                color: Theme.of(context).backgroundColor,
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(22)),
                depth: -4,
              ),
              child: Text(
                '0',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () {
                setState(() {
                  output += '0';
                });
              }),
        ),
        ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(buttonSize),
            shape:
                MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
          ),
          child: Text(
            '.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          onPressed: () {
            if (!output.contains('.')) {
              setState(() {
                output += '.';
              });
            }
          },
        ),
      ],
    );

    Widget upperElements = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.from(
        mathOperationsSecondary.values.map(
          (e) => ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(buttonSize),
              shape:
                  MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
            ),
            onPressed: () {
              performMathOperation(firstRowButtons[e.index]);
            },
            child: Text(
              firstRowButtons[e.index],
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ),
    );

    List<Widget> middleElements = naturalNumbers
        .map((e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: e
                  .map((e) => ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(buttonSize),
                          shape: MaterialStateProperty.all<CircleBorder>(
                              const CircleBorder()),
                        ),
                        child: Text(
                          '$e',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onPressed: () {
                          setState(() {
                            output += e;
                          });
                        },
                      ))
                  .toList(),
            ))
        .toList();
    middleElements.insert(0, upperElements);
    middleElements.add(lowerElements);
    Widget operationsColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.from(
        mathOperationsPrimary.values.map((e) => ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(buttonSize),
                shape: MaterialStateProperty.all<CircleBorder>(
                    const CircleBorder()),
              ),
              child: Text(
                operationButtons[e.index],
                style: Theme.of(context).textTheme.headline1,
              ),
              onPressed: () {
                setState(() {
                  performMathOperation(operationButtons[e.index]);
                });
              },
            )),
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    output,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Container(
                    // decoration: BoxDecoration(color: Colors.blue),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Container(
                              child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: middleElements,
                          )),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                            child: operationsColumn,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

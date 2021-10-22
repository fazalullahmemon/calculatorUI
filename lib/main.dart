import 'package:calcuitask/calc.dart';
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
  performSecondaryMathOperation(String selectedOperation) {
    switch (selectedOperation) {
      case 'AC':
        setState(() {
          Calc.input = '';
          displayResult = '';
        });

        break;
      case '+/-':
        if (displayResult.isNotEmpty) {
          setState(() {
            if (displayResult.contains('-')) {
              Calc.input = displayResult.replaceAll(RegExp('-'), '');
              displayResult = Calc.input;
              isOutput = false;
            } else {
              isOutput = false;

              String result = '-';
              result += displayResult;
              Calc.input = result;
              displayResult = Calc.input;
            }
          });
        }
        break;
      case '%':
        if (displayResult.isNotEmpty) {
          double? result = double.tryParse(displayResult);
          if (result != null) {
            result /= 100;
            setState(() {
              isOutput = false;

              Calc.input = result.toString();
              displayResult = Calc.input;
            });
          }
        }
        break;
    }
  }

  String displayResult = '';
  bool isOutput = false;

  @override
  Widget build(BuildContext context) {
    NeumorphicStyle neumorphicStyleConcave = NeumorphicStyle(
      shadowLightColor: Colors.black26,
      color: Theme.of(context).backgroundColor,
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(22)),
      depth: -4,
    );
    NeumorphicStyle neumorphicStyleConvex = NeumorphicStyle(
      shadowLightColor: Colors.white38,
      lightSource: LightSource.bottomRight,
      color: Theme.of(context).backgroundColor,
      shape: NeumorphicShape.convex,
      boxShape: const NeumorphicBoxShape.circle(),
      depth: 4,
    );
    Widget lowerElements = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 140,
          height: 60,
          child: NeumorphicButton(
              style: neumorphicStyleConcave,
              child: Text(
                '0',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () {
                setState(() {
                  if (isOutput) {
                    displayResult = '';
                    isOutput = false;
                  }
                  displayResult += '0';
                  Calc.input += '0';
                });
              }),
        ),
        Container(
          width: 70,
          height: 70,
          child: NeumorphicButton(
            style: neumorphicStyleConvex,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            onPressed: () {
              if (!Calc.input.contains('.')) {
                setState(() {
                  Calc.input += '.';
                  if (isOutput) {
                    displayResult = '';
                    isOutput = false;
                  }
                  displayResult += '.';
                });
              }
            },
          ),
        ),
      ],
    );

    Widget upperElements = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.from(
        mathOperationsSecondary.values.map(
          (e) => Container(
            width: 70,
            height: 70,
            child: NeumorphicButton(
              style: neumorphicStyleConvex,
              onPressed: () {
                performSecondaryMathOperation(Calc.firstRowButtons[e.index]);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  Calc.firstRowButtons[e.index],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    List<Widget> middleElements = Calc.naturalNumbers
        .map((e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: e
                  .map((e) => Container(
                        width: 70,
                        height: 70,
                        child: NeumorphicButton(
                          style: neumorphicStyleConvex,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '$e',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              Calc.input += e;

                              if (isOutput) {
                                displayResult = '';
                                isOutput = false;
                              }
                              displayResult += e;
                            });
                          },
                        ),
                      ))
                  .toList(),
            ))
        .toList();
    middleElements.insert(0, upperElements);
    middleElements.add(lowerElements);
    Widget operationsColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.from(
        mathOperationsPrimary.values.map((e) => Container(
              width: 70,
              height: 70,
              child: NeumorphicButton(
                style: neumorphicStyleConvex,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    Calc.operationButtons[e.index],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                onPressed: () {
                  // operand = operationButtons[e.index];
                  // Calc.input+=operationButtons[e.index];
                  if (Calc.operationButtons[e.index] == '=') {
                    setState(() {
                      String calculatedResult = Calc.calculate();
                      displayResult = calculatedResult;
                      isOutput = true;
                    });
                  } else {
                    setState(() {
                      Calc.input += Calc.operationButtons[e.index];
                      displayResult += Calc.operationButtons[e.index];
                      if (isOutput) {
                        Calc.input = displayResult;
                        isOutput = false;
                      }
                    });
                  }
                },
              ),
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
                    displayResult,
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

class Calc {
  static List<String> firstRowButtons = ['AC', '+/-', '%'];
  static List<String> operationButtons = ['÷', 'x', '+', '-', '='];
  static List<List<String>> naturalNumbers = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
  ];
  static List<String> bottomElements = ['.', '='];

  static int pre(String ch) {
    if (ch == 'x' || ch == '÷') {
      return 3;
    } else if (ch == '+' || ch == '-') {
      return 2;
    }
    return 0;
  }

  static String input = '';
  static String output = '';
  static String calculate() {
    output = '';
    List<String> inputCharList = input.split('');
    double num1 = 0;
    double num2 = 0;
    double result = 0;
    int d = 0, e = 0;
    String op = '';
    bool flag = true;
    while (flag) {
      int tempPri = 0;
      int index = 0;

      for (int i = 0; i < inputCharList.length; i++) {
        if (inputCharList[i].contains(RegExp("^[0-9]")) ||
            inputCharList[i] == '.' ||
            (inputCharList[i] == '-' && i == 0)) {
          continue;
        } else if (pre(inputCharList[i]) > tempPri) {
          index = i;
          tempPri = pre(inputCharList[i]);
        }
      }
      List tempNumList = [];
      List tempNumList2 = [];
      String tempNumString = '', tempNumString2 = '';

      try {
        for (int k = index - 1; k >= 0; k--) {
          if (RegExp(r'^[0-9]').hasMatch(inputCharList[k]) ||
              (inputCharList[k] == '-' && k == 0) ||
              inputCharList[k] == '.') {
            tempNumList.add(inputCharList[k]);
            d = k;
          } else {
            break;
          }
        }
        tempNumString = tempNumList.reversed.toList().join();
      } catch (e2) {}

      try {
        for (int k = index + 1; k < inputCharList.length; k++) {
          if (RegExp(r'^[0-9]').hasMatch(inputCharList[k]) ||
              inputCharList[k] == '.') {
            tempNumList2.add(inputCharList[k]);
            e = k;
          } else {
            break;
          }
        }
        print('tempNumString2: ${tempNumList2.reversed.toList().join()}');
        tempNumString2 = tempNumList2.join();
      } catch (e3) {}

      try {
        num1 = double.parse(tempNumString);
        num2 = double.parse(tempNumString2);
      } catch (e1) {}

      switch (inputCharList[index]) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case 'x':
          result = num1 * num2;
          break;
        case '÷':
          if (num2 == 0) {
            break;
          }
          result = num1 / num2;
          break;
      }
      if (d != 0 || e != 0) {
        String resultStr = result.toString();
        String res = '';
        if (resultStr.contains('.')) {
          res = resultStr.substring(resultStr.indexOf('.'), resultStr.length);
          double resDouble = double.parse(res);
          if (resDouble > 0) {
            res = resultStr;
          } else {
            res = resultStr.substring(0, resultStr.indexOf('.'));
          }
        }

        output =
            input.substring(0, d) + res + input.substring(e + 1, input.length);
        input =
            input.substring(0, d) + res + input.substring(e + 1, input.length);
        inputCharList = input.split('');
      } else {
        break;
      }
      for (int j = 0; j < input.length; j++) {
        List inputSplitted = input.split('');
        if (inputSplitted[j] == '-' && j == 0) {
          flag = false;
          break;
        } else if (input.contains('+') ||
            input.contains('-') ||
            input.contains('x') ||
            input.contains('÷')) {
          flag = true;
        } else {
          flag = false;
          break;
        }
      }
    }
// print('output: $output');
    input = '';
    return output;
  }
}


// String myResult = calculate();
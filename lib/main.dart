import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:string_validator/string_validator.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Calculator',
    home: Calculator()
)
);

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String expression = '';
  String shownExpression = '';
  String result = '';
  void btnLogic(String btnText) {
    setState(() {
      if(btnText == 'C') {
        expression = '';
        result = '';
      } else if(btnText == '⌫') {
        if(expression != '' && expression.length != 0) {
          expression = expression.substring(0 , expression.length-1);
          result = '';
        }

      }else if(btnText == '=') {
        expression = result;
        result = '';
        try {
          Parser parser = Parser();
          String resultExpression = expression.replaceAll('x', '*');
          Expression exp = parser.parse(resultExpression);
          ContextModel contextModel = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
        } catch (e) {
          expression = '';
          result = 'Invalid Expression';
        }
      }else {
        expression = expression + btnText;
      }
    });
  }

  Widget _createButton(String btnText) {

    Color color;

    if(isNumeric(btnText) && !btnText.contains('00')) {
      color = Colors.deepOrangeAccent.withOpacity(0.9);
  } else if(btnText.endsWith('=')){
      color = Colors.white30.withOpacity(0.5);
    } else {
      color = Colors.white30.withOpacity(0.2);
    }

    return Expanded(
        child: FlatButton(
          color: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45),
              ),
          child: Text(btnText ,
            style: TextStyle(fontWeight: FontWeight.bold , fontSize: 23.0 , color: Colors.white),)
          ,onPressed: () {
          btnLogic(btnText);
          if(expression.contains('/') || expression.contains('+') || expression.contains('-') || expression.contains('%') || expression.contains('x')) {
            try {
              Parser parser = Parser();
              String resultExpression = expression.replaceAll('x', '*');
              Expression exp = parser.parse(resultExpression);
              ContextModel contextModel = ContextModel();
              result = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
            } catch (e) {
              print(e.toString());
            }
          }
        },
          padding: EdgeInsets.all(27.0),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(0, 18, 10, 18),
              child: Text(expression , style: TextStyle(letterSpacing: 1.0 , fontSize: 54.0 , color: Colors.white),),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(0, 18, 10, 18),
              child: Text(result , style: TextStyle(letterSpacing: 1.0 , fontSize: 27.0 , color: Colors.white), overflow: TextOverflow.fade,),
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                _createButton('C'),
                SizedBox(width: 10),
                _createButton('⌫'),
                SizedBox(width: 10),
                _createButton('%'),
                SizedBox(width: 10),
                _createButton('+'),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height : 10),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                _createButton('7'),
                SizedBox(width: 10),
                _createButton('8'),
                SizedBox(width: 10),
                _createButton('9'),
                SizedBox(width: 10),
                _createButton('-'),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                _createButton('4'),
                SizedBox(width: 10),
                _createButton('5'),
                SizedBox(width: 10),
                _createButton('6'),
                SizedBox(width: 10),
                _createButton('/'),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                _createButton('1'),
                SizedBox(width: 10),
                _createButton('2'),
                SizedBox(width: 10),
                _createButton('3'),
                SizedBox(width: 10),
                _createButton('x'),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                _createButton('00'),
                SizedBox(width: 10),
                _createButton('0'),
                SizedBox(width: 10),
                _createButton('.'),
                SizedBox(width: 10),
                _createButton('='),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height : 10),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = "0";

  void _onButtonClick(String value) {
    setState(() {
      if (value == "AC") {
        display = "0";
      } else if (value == "⌫") {
        if (display.length > 1) {
          display = display.substring(0, display.length - 1);
        } else {
          display = "0";
        }
      } else if (value == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(
            display.replaceAll("×", "*").replaceAll("÷", "/"),
          );
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          display = eval.toString();
        } catch (e) {
          display = "Error";
        }
      } else {
        if (display == "0") {
          display = value;
        } else {
          display += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ✅ Display (Auto Shrink Text)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                display,
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 1,
                minFontSize: 20,
              ),
            ),
          ),

          // ✅ Buttons Layout
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    calcButton("AC", const Color(0xFF272569), Colors.white),
                    calcButton("%", const Color(0xFF272569), Colors.white),
                    calcButton("⌫", const Color(0xFF272569), Colors.white),
                    calcButton("÷", const Color(0xFFc1d53f), Colors.black),
                  ],
                ),
                Row(
                  children: [
                    calcButton(
                      "7",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton(
                      "8",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton(
                      "9",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton("×", const Color(0xFFc1d53f), Colors.black),
                  ],
                ),
                Row(
                  children: [
                    calcButton(
                      "4",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton(
                      "5",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton(
                      "6",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton("-", const Color(0xFFc1d53f), Colors.black),
                  ],
                ),
                Row(
                  children: [
                    calcButton(
                      "1",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton(
                      "2",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton(
                      "3",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton("+", const Color(0xFFc1d53f), Colors.black),
                  ],
                ),
                Row(
                  children: [
                    // 0 button (double width)
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 24),
                          ),
                          onPressed: () => _onButtonClick("0"),
                          child: const Text(
                            "0",
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    calcButton(
                      ".",
                      const Color.fromARGB(255, 238, 237, 237),
                      Colors.black,
                    ),
                    calcButton("=", const Color(0xFFc1d53f), Colors.black),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Reusable Button
  Widget calcButton(String text, Color bgColor, Color txtColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => _onButtonClick(text),
          child: Text(text, style: TextStyle(fontSize: 24, color: txtColor)),
        ),
      ),
    );
  }
}

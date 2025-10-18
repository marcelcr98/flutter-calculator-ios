import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'widgets/CalcButton.dart';

void main() {
  runApp(const CalcApp());
}

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  String _history = "";
  String _expression = "";

  void clear(String text) {
    setState(() {
      _expression = "";
    });
  }


  void allClear(String text) {
    setState(() {
      _history = "";
      _expression = "";
    });
  }

void evaluate(String text) {
  try {
    // Solo corregimos el símbolo de multiplicación visual
    String finalExpression = _expression.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalExpression);
    ContextModel cm = ContextModel();

    setState(() {
      _history = _expression;
      _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  } catch (e) {
    setState(() {
      _expression = "Error";
    });
  }
}



void numClick(String text) {
  setState(() {
    if (text == "X") {
      _expression += "*";
    } else if (text == "÷") {
      _expression += "/";
    } else if (text == "−") {
      _expression += "-";
    } else {
      _expression += text;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculadora iOS Style",
      home: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Tamaño dinámico: más grande y adaptable
              final buttonHeight = constraints.maxHeight * 0.11;
              final buttonWidth = (constraints.maxWidth - 60) / 4;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Texto historial
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        _history,
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                            fontSize: 28,
                            color: Color(0xFF868686),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Texto principal
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        _expression,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                            fontSize: 64,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Teclado
                    _buildButtonGrid(buttonWidth, buttonHeight),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

Widget _buildButtonGrid(double width, double height) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonRow(
        ["AC", "C", "%", "/"], // ÷ → /
        [0xFF9B9B9B, 0xFF9B9B9B, 0xFF9B9B9B, 0xFF23C1EC],
        width,
        height,
      ),
      _buildButtonRow(
        ["7", "8", "9", "X"], // × → *
        [0xFF333333, 0xFF333333, 0xFF333333, 0xFF23C1EC],
        width,
        height,
      ),
      _buildButtonRow(
        ["4", "5", "6", "-"], // − → -
        [0xFF333333, 0xFF333333, 0xFF333333, 0xFF23C1EC],
        width,
        height,
      ),
      _buildButtonRow(
        ["1", "2", "3", "+"],
        [0xFF333333, 0xFF333333, 0xFF333333, 0xFF23C1EC],
        width,
        height,
      ),
      _buildButtonRow(
        ["0", ".", "="],
        [0xFF333333, 0xFF333333, 0xFF23C1EC],
        width,
        height,
        isLastRow: true,
      ),
    ],
  );
}


  Widget _buildButtonRow(List<String> texts, List<int> colors, double width, double height, {bool isLastRow = false}) {
    List<Widget> buttons = [];

    for (int i = 0; i < texts.length; i++) {
      bool isZero = (isLastRow && texts[i] == "0");

      buttons.add(
        Expanded(
          flex: isZero ? 2 : 1,
          child: Container(
            margin: const EdgeInsets.all(6),
            width: isZero ? width * 2 + 12 : width,
            height: height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CalcButton(
                bgcolor: colors[i],
                text: texts[i],
                callback: texts[i] == "AC"
                    ? allClear
                    : texts[i] == "C"
                        ? clear
                        : texts[i] == "="
                            ? evaluate
                            : numClick,
                textSize: 30,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }
}

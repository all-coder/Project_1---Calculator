import 'package:flutter/material.dart';
import '../widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../process/parser.dart';


class MainCalc extends StatefulWidget {
  const MainCalc({super.key});
  @override
  State<MainCalc> createState() {
    return _MainCalcState();
  }
}

//main widget
class _MainCalcState extends State<MainCalc> {
  final list = [
   // '%',
    '*',
    '-',
    '+',
    '^',
    '(',
    ')',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  @override
  Widget build(context) {
    final TextEditingController calc = TextEditingController();
    final TextEditingController output = TextEditingController();
    void push(String char) {
      final newText = char;
      final updatedText = calc.text + newText;

      calc.value = TextEditingValue(text: updatedText);

      //calc.value = calc.value.copyWith(text: updatedText);
    }

    void clear() {
      setState(() {
        calc.value = TextEditingValue.empty;
      });
    }

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff957964),
        // appBarTheme: const AppBarTheme(color: ),
        //scaffoldBackgroundColor: ,
        useMaterial3: true,
        brightness: Brightness.light,
        // cardColor: Color(0xffe76f51),
        textTheme: GoogleFonts.robotoMonoTextTheme(),
        //useMaterial3: true,
        //primaryColor: Color(0xffe76f51),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //drawer: ,
        appBar: AppBar(
          
          backgroundColor: const Color(0xffC7AA74),
          elevation: 20,
          title: const Text(
            'Calculator',
            textAlign: TextAlign.start,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff2B2D42),
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color(0xff2B2D42),
                  //     Color(0xff603140),
                  //     Color(0xff957964),
                  //     // Color(0xff001219)
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 10,
                      color: const Color(0xff793E51),
                      margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextField(
                          enabled: false,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          textDirection: TextDirection.rtl,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Colors.white,
                              ),
                          controller: output,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      color: const Color(0xff793E51),
                      margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Colors.white,
                              ),
                          controller: calc,
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 500,
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 15),
                decoration: BoxDecoration(
                  color: const Color(0xff2B2D42),
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color(0xff2B2D42),
                  //     Color(0xff603140),
                  //     Color(0xff957964),
                  //     // Color(0xff001219)
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  borderRadius: BorderRadius.circular(10),
                  //color: const Color(0xffe76f51),
                ),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                  ),
                  children: [
                    Button(
                      num: "AC",
                      pushVal: () {
                        clear();
                      },
                    ),
                    ...list.map(
                      (item) => Button(
                        num: item,
                        pushVal: () {
                          push(item);
                        },
                      ),
                    ),
                    Button(
                      num: '<',
                      pushVal: () {
                        //need to fix this piece of logic for backspace
                        final expressionArray = calc.text.split("");
                        final array = expressionArray.removeAt(0);
                        calc.value = TextEditingValue(text: array);
                      },
                    ),


                    Button(
                      num: "=",
                      pushVal: () {
                        final outputText =
                            ParseExpressions().calcString(calc.text);
                        output.value =
                            TextEditingValue(text: outputText.toString());
                      },
                    ),
                    
                  ],
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     push('1');
            //   },
            //   child: Text("Test me"),
            // ),
          ],
        ),
      ),
    );
  }
}

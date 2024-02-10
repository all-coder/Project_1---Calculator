import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.num, required this.pushVal});
  final void Function() pushVal;
  final String num;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pushVal,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //   Color(0xff38a3a5),
            //   Color(0xff57cc99),
            //   Color(0xff22577a),
            // ],),
            color: Color(0xffC7AA74),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: Text(
          num,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: const Color(0xff2B2D42),
              ),
        ),
      ),
    );
  }
}

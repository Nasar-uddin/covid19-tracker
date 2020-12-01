import 'package:flutter/material.dart';

class SingleStatus extends StatelessWidget {
  final flex;
  final String label;
  final int amount;
  final Color color;
  SingleStatus ({
    this.flex = 1,
    @required this.label,
    @required this.amount,
    this.color = Colors.blueAccent
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            boxShadow: [BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 15,
              offset: Offset(0,5)
            )]
          ),
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Text(
              this.label,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              '${this.amount}',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class ConfirmationTickAnimation extends StatefulWidget {
 

  final double size;
  final Color color;

  String selectity1;

  String selectcity2;

  DateTime date;

  TimeOfDay? selectedtime;

  ConfirmationTickAnimation({
    this.size = 64.0,
    this.color = Colors.green, required String this.selectity1, required String this.selectcity2, required DateTime this.date, required TimeOfDay this.selectedtime,
  });

  @override
  _ConfirmationTickAnimationState createState() =>
      _ConfirmationTickAnimationState();
}

class _ConfirmationTickAnimationState extends State<ConfirmationTickAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Path _tickPath;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _tickPath = _buildTickPath();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Path _buildTickPath() {
    double tickWidth = widget.size / 3.0;
    double tickHeight = widget.size / 2.0;
    Path path = Path();
    path.moveTo(0, tickHeight);
    path.lineTo(tickWidth, widget.size);
    path.lineTo(widget.size, 0);
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Center(
            child: CustomPaint(
              painter: _ConfirmationTickPainter(
                animation: _animation,
                color: widget.color,
                tickPath: _tickPath,
              ),
              size: Size(widget.size, widget.size),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("BOOKING CONFIRMED",style: TextStyle(
           color: Colors.white,fontSize: 20,
         ),),
    SizedBox(
      height:20,
    ),
    Container(
      color:Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "TICKET", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                   ),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Text(
                      "CONFIRMED", style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    Text(widget.selectity1,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          Icon(Icons.compare_arrows),

          Text(widget.selectcity2,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5,),
                Row(
                  children: [
                    SizedBox(width: 8,),
                    Text("Date : ",style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(
                      width: 20,
                    ),
                    Text(widget.date.toString().substring(0, 10),
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    SizedBox(width: 8,),
                    Text("Time : ",style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(
                      width: 20,
                    ),
                    Text(widget.selectedtime.toString().substring(10,15),
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    SizedBox(width: 8,),
                    Text("Boarding : ",style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(
                      width: 20,
                    ),
                    Text(widget.selectity1,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              ],


            ),

          ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.95,
          child: ElevatedButton(onPressed: ()=>Navigator.push(context,
    MaterialPageRoute(builder: (context)=>
        CitySelector())),

              child: Text("BOOK ANOTHER TICKET")),
        ),

      ],
    );
  }
}

class _ConfirmationTickPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final Path tickPath;

  _ConfirmationTickPainter({
    required this.animation,
    required this.color,
    required this.tickPath,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = size.width / 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(tickPath, paint);
  }

  @override
  bool shouldRepaint(_ConfirmationTickPainter oldDelegate) =>
      animation != oldDelegate.animation;
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? repeatedFunc;
  Duration duration = const Duration(minutes: 25);
  bool show2but = false;
  bool stopandrus= true;
  promdor() {
     repeatedFunc = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        show2but = true;
        int newseconds = duration.inSeconds - 1;
        duration = Duration(seconds: newseconds);
        if (newseconds == 0) {
          timer.cancel();
          show2but=false;
          stopandrus=false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 79, 106, 117),
          title: const Text('Pomodoro timer')),
      backgroundColor: const Color.fromARGB(255, 33, 40, 43),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 110.0,
                  progressColor: const Color.fromARGB(255, 255, 85, 113),
                  backgroundColor: Colors.grey,
                  lineWidth: 8.0,
                  percent: duration.inMinutes/25,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 250,
                  center:
                  duration.inMinutes==0?const Text('❤️',style: TextStyle(fontSize: 40),):
                  Text(
                  '${duration.inMinutes.toString()}:${duration.inSeconds.remainder(60).toString().padLeft(2, ('0'))}',
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ), 
                ),
                
              ],
            ),
            const SizedBox(
              height: 30,
            ),
           show2but?      Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
       stopandrus?      ElevatedButton(
         style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 85, 113)),
             ),
                onPressed: () {
                setState(() {
                   repeatedFunc!.cancel();
                   stopandrus=false;
                });
                },
                child:  const Text('Stop')
                ):
                 ElevatedButton(
                   style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(Colors.green),
             ),
                onPressed: () {
                setState(() {
                   promdor();
                   stopandrus=true;
                });
                },
                child:  const Text('continue')),





                
                 ElevatedButton(
                   style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 85, 113)),
             ),
                onPressed: () {
                setState(() {
                   if(repeatedFunc!.isActive){

                    duration = const Duration(minutes: 25);
                    repeatedFunc!.cancel();
                     show2but = false;
                     stopandrus=true;
                   }else{
                      duration = const Duration(minutes: 25);
                    repeatedFunc!.cancel();
                     show2but = false;
                     stopandrus=true;
                   }
                 
                });
                },
                child: const Text('Cancel')
                ),
           ],
           )    : ElevatedButton(
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 85, 113)),
             ),
                onPressed: () {
                  
                  promdor();
                },
                child: const Text('Start')),
                
          ],
        ),
      ),
    );
  }
}

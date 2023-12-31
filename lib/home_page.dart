import 'package:flutter/material.dart';
import 'package:quizz_flutter/quizz_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final height=size.height;
    final width=size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Quizz"),
      ),
      body:  Center(
        child: Card(
          color: Colors.deepOrange.shade100,
          elevation: 10,
          child: Column(
            mainAxisSize:MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child:Image.asset(
                "images/cover.jpg",
                height:height/2.5 ,
                // 80% en largeur
                width:width/0.8,
                fit: BoxFit.cover ,
                ), 
              ),
              
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext ctx){
                        return QuizzPage();
                    }),
                  );
                }, 
                child: const Text("Commencer le Quizz")
                ),
            ],
          ),
        ),
       ),
    );
  }
}
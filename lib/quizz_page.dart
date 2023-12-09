import 'package:flutter/material.dart';
import 'package:quizz_flutter/question.dart';
import 'package:quizz_flutter/text_with_style.dart';

import 'datas.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  List<Question> questions = Datas().listeQuestions;
  // pour connaitre index de notre liste
  int index = 3;
  int score = 0;
  @override
  Widget build(BuildContext context) {
    final Question question = questions[index];
    return Scaffold(
      appBar: AppBar(
        title: Text("Score : $score"),
      ),
      body:  Center(
        child: Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWithStyle(data:"Question numéro:${index+1}",color: Colors.deepOrange,style: FontStyle.italic,),
                TextWithStyle(data:question.question,size:21,weight:FontWeight.bold ,),
                Image.asset(question.getImage()),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [ 
                    answerBtn(false),
                    answerBtn(true),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton answerBtn(bool b){
     return ElevatedButton(
      onPressed: (){
         checkAnswer(b);
      },
       style: ElevatedButton.styleFrom(backgroundColor: (b) ? Colors.greenAccent:Colors.red),
      child: Text((b)? "VRAI":"FAUX")
      );
  }

  checkAnswer(bool answer) {
    final question = questions[index];
    bool bonneReponse = (question.reponse == answer);

    if (bonneReponse) {
      setState(() {
        score++;
      });
    }
    showAnswer(bonneReponse);
  }

  Future<void> showAnswer(bool bonneReponse) async{
    Question question= questions[index];
    String title = (bonneReponse)? "C'est gagné !":"Raté !";
    String imageToShow=(bonneReponse) ? "vrai.jpg" : "faux.jpg";
    String path="images/$imageToShow";

    return  await showDialog(
          barrierDismissible: false  ,
          context: context,
          builder:(BuildContext context){
          return SimpleDialog(
             title: TextWithStyle(data:title),
             children: [
               Image.asset(path),
               TextWithStyle(data: question.explication),
               TextButton(
                   onPressed: (){
                      Navigator.of(context).pop();
                      toNextQuestion();
                   },
                   child: TextWithStyle(data: "passer à la question suivante",)
               ),
             ],
          ) ;

          }
    );
  }

  Future<void> showResult() async{
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext ctx){
        return AlertDialog(
          title: TextWithStyle(data: "c'est fini !",),
          content: TextWithStyle(
            data: "Votre score est de: $score points",
          ),
          actions: [
            TextButton(
                onPressed: (){
                  // fermer les context de showdialog et application
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                } ,
                child:TextWithStyle(data: "OK",) ,
            ),
          ],
        );
        },
    );
  }

  void toNextQuestion(){

    if(index<questions.length-1){
      index++;
      setState(() {

      });
    } else{
      showResult();
    }


  }
}

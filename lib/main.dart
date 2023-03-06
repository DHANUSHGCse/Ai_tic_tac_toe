import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   var result="";
   var nos=0;
   var iconsno=[-1,-1,-1,-1,-1,-1,-1,-1,-1];
   List<IconData> icondata=[FontAwesomeIcons.close,CupertinoIcons.circle];
   List<Color> colors=[Colors.white,Color(0xff7A76DD)];
   int minimax(nos,computerturn){
     var bestscore=0;
     if(isgameover()){
       if(computerturn){
         return -10;
       }else{
         return 10;
       }
     }else{
       if(nos<9){
          if(computerturn){
            bestscore=-999;
            for(int i=0;i<9;i++){
              if(iconsno[i]==-1){
                iconsno[i]=1;
                var score = minimax(nos+1,false);
                iconsno[i]=-1;
                if(score>bestscore){
                  bestscore=score;
                }
              }
            }
            return bestscore;
          }else{
            bestscore=999;
            for(int i=0;i<9;i++){
              if(iconsno[i]==-1){
                iconsno[i]=0;
                var score = minimax(nos+1,true);
                iconsno[i]=-1;
                if(score<bestscore){
                  bestscore=score;
                }
              }
            }
            return bestscore;
          }
       }else{
         return 0;
       }
     }
   }
   void computerchoice(nos){
     var bestscore=-999;
     var bno=-1;
     for(var i=0;i<9;i++){
              if(iconsno[i]==-1){
                iconsno[i]=1;
                var score=minimax(nos+1,false);
                iconsno[i]=-1;
                if(score>bestscore){
                  bestscore=score;
                  bno=i;
                }
              }
     }
     iconsno[bno]=1;
   }
   bool isgameover(){
     for(int i=0;i<9;i+=3){
       if(iconsno[i]==iconsno[i+1]&&iconsno[i+1]==iconsno[i+2]&&iconsno[i]!=-1){
         return true;
       }
     }
     for(int i=0;i<3;i++){
       if(iconsno[i]==iconsno[i+3]&&iconsno[i+3]==iconsno[i+6]&&iconsno[i]!=-1){
         return true;
       }
     }
     if(iconsno[0]==iconsno[4]&&iconsno[4]==iconsno[8] && iconsno[0]!=-1){
       return true;
     }
     if(iconsno[2]==iconsno[4]&&iconsno[4]==iconsno[6]&&iconsno[2]!=-1){
       return true;
     }
     return false;
   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff28283B),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tic Tac Toe",style: TextStyle(color: Colors.white,fontSize: 50.0,fontFamily: 'TiltNeon'),),
            SizedBox(height: 50,),
            Row(
              children: [
                     SizedBox(width: 10,),buildExpanded(0),buildExpanded(1),buildExpanded(2),SizedBox(width: 10,)
              ],
            ),
            Row(
              children: [
                SizedBox(width: 10,),buildExpanded(3),buildExpanded(4),buildExpanded(5),SizedBox(width: 10,)
              ],
            ),
            Row(
              children: [
                SizedBox(width: 10,),buildExpanded(6),buildExpanded(7),buildExpanded(8),SizedBox(width: 10,)
              ],
            ),
            SizedBox(height: 20,),
            Text(result,style: TextStyle(color: Colors.white,fontSize: 30.0,fontFamily: 'TiltNeon'),),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              setState(() {
                result="";
                nos=0;
                iconsno=[-1,-1,-1,-1,-1,-1,-1,-1,-1];
              });
            }, child: Text("Reset",style: TextStyle(color: Colors.white,fontSize: 30.0,fontFamily: 'TiltNeon')),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xff35354A)),padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.only(left: 25.0,right: 25.0,top: 10,bottom: 10))),)
          ],
        ),
      ),
    );
  }

  Expanded buildExpanded(no) {
    return Expanded(
          child: GestureDetector(
          onTap: (){
    setState(() {
      if(iconsno[no]!=-1){
       print("-1");
      }else{
        if(!isgameover() && nos < 9) {
          iconsno[no] = 0;
          nos++;
          if(isgameover()){
            result="You Wins the Game";
          }else{
            if(nos>=9){
              result="Game Draw";
            }
          }
          if (!isgameover() && nos < 9) {
            computerchoice(nos);
            nos++;
            print(nos);
          }
          if(isgameover()){
            result="You Lose the Game";
          }else{
            if(nos>=9){
              result="Game Draw";
            }
          }
        }
      }
    });

    },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xff35354A),
        ),
        width: 100,
        height: 120,
        child: Container(
            padding: EdgeInsets.all(20),
            child: iconsno[no]!=-1 ?Icon(icondata[iconsno[no]],color: colors[iconsno[no]],size: 50,):Text("")),
      ),
    ),
  );
  }
}



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }




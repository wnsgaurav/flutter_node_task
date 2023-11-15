import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
 late bool showProgress;

  @override
  void initState() {
    showProgress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task"),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showProgress?   const Padding(
              padding: EdgeInsets.all(40),
              child: SizedBox(
                width: 40,
                  height: 40,
                  child: CircularProgressIndicator()),
            ):
            const Padding(padding: EdgeInsets.all(20)),

            ElevatedButton(onPressed: (){
              setState(() {
                if(showProgress){
                  showProgress = false;
                }else{
                  showProgress = true;
                }
              });


            }, child: Text(showProgress?"Hide Progress" : "Show Progress")),
            ElevatedButton(onPressed: (){
              const snackBar = SnackBar(
                content: Text('Yay! A SnackBar!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

            }, child: const Text("Show Snack bar"))


          ],
        ),
      ),
    );
  }
}

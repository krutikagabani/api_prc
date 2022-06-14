import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import 'Models/UserData.dart';
import 'Resource/StyleResource.dart';

class DetailsScreen extends StatefulWidget {

  UseData obj=null;

  DetailsScreen({this.obj});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        //(widget.obj!=null)?
        SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.purple.shade300,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: ()async{
                          Navigator.of(context).pop();
                        },
                          icon:Icon(Icons.arrow_back,size: 35,color: Colors.white,),
                        ),
                        Icon(Icons.star_border,color: Colors.white,size: 30,)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child:  CircleAvatar(backgroundImage:NetworkImage("https://image.tmdb.org/t/p/w600_and_h900_bestv2"+widget.obj.posterPath,),
                            radius: 30  ,),
                        ),
                        Expanded(child: Text(widget.obj.title,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white)),)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  PhysicalModel(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                    child: FadeInImage.assetNetwork(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/2.5,
                      placeholder: "img/loading.jpg",
                      image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/"+widget.obj.backdropPath,
                      fit: BoxFit.fill,
                    ),
                  ),

                  SizedBox(height: 20,),
                  Text("OVERVIEW",style: StyaleResource.primaryTextStyale,),
                  SizedBox(height: 10,),
                  Container(
                    child: new DescriptionTextWidget(text:widget.obj.overview.toString(),),
                  ),

                  //also use this widget for two text joint

                  // RichText(
                  //   text: TextSpan(
                  //     text: widget.obj.overview.substring(0,150)+"...",
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //           recognizer: new TapGestureRecognizer()..onTap = () {
                  //
                  //           },
                  //           text: 'Read More', style: TextStyle(fontWeight: FontWeight.bold)),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20,),
                  Container(
                    color: Colors.purple.shade100,
                    padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Actors",style: StyaleResource.primaryTextStyale,),
                              Icon(Icons.arrow_forward_ios,color:Colors.white,)
                            ],
                          ),
                        ),
                        Container(
                          height: 100.0,
                          child:  ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CircleAvatar(radius: 50.0,backgroundImage:NetworkImage("https://image.tmdb.org/t/p/w600_and_h900_bestv2"+widget.obj.posterPath,)),
                              SizedBox(width: 15.0,),
                              CircleAvatar(radius: 50.0,backgroundImage:NetworkImage("https://image.tmdb.org/t/p/w600_and_h900_bestv2"+widget.obj.posterPath,)),
                              SizedBox(width: 15.0,),
                              CircleAvatar(radius: 50.0,backgroundImage:NetworkImage("https://image.tmdb.org/t/p/w600_and_h900_bestv2"+widget.obj.posterPath,)),
                              SizedBox(width: 15.0,),
                              CircleAvatar(radius: 50.0,backgroundImage:NetworkImage("https://image.tmdb.org/t/p/w600_and_h900_bestv2"+widget.obj.posterPath,)),
                            ],
                          ),
                        ),
                      ],

                    ),

                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("IMdb",style: StyaleResource.primaryTextStyale,),
                          Row(
                            children: [
                              Text(widget.obj.voteAverage.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white)),
                              Text("/10",style: StyaleResource.textColor)
                            ],
                          )

                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Text("Vote:",style: StyaleResource.primaryTextStyale,),
                          Row(
                            children: [
                              Text(widget.obj.voteCount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white)),
                              Text(" /100",style: StyaleResource.textColor)
                            ],
                          )

                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        )
      //:Center(child: CircularProgressIndicator(),)
    );
  }
}

//create new widget

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }




  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
        children: <Widget>[
          new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),style: StyaleResource.textColor),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "Read More" : "Read",
                  style: new TextStyle(color: Colors.yellow),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }
}
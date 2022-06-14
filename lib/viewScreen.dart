import 'dart:math';

import 'package:flutter/material.dart';

import 'DetailsScrren.dart';
import 'Models/UserData.dart';
import 'Resource/StyleResource.dart';
import 'Resource/UrlResource.dart';
import 'helpers/ApiHandler.dart';
import 'helpers/ErrorHandler.dart';

class viewScreen extends StatefulWidget {


  @override
  State<viewScreen> createState() => _viewScreenState();
}

class _viewScreenState extends State<viewScreen> {

  List <UseData>alldata;

  getdata()async{
    try{
      await ApiHandler.get(UrlResource.VIEW).then((json) {
        print(json);
        setState(() {
          alldata = json["results"]
              .map<UseData>((obj) => UseData.fromJson(obj))
              .toList();
        });
      });

    }

    on ErrorHandler catch (ex) {
      if (ex.code.toString() == "500") {
        print(Text("no conaction"));
      }
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  List colors = [
    Colors.greenAccent.shade100,
    Colors.purple.shade100,
    Colors.blue.shade100
  ];
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (alldata != null)
            ? ListView.builder(
          itemCount: alldata.length,
          itemBuilder: (context, index) {
           var i = random.nextInt(3);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      obj: alldata[index],
                    )));
              },
              child: Container(
                decoration: BoxDecoration(
                 color: colors[i],
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w600_and_h900_bestv2" +
                              alldata[index].posterPath,
                          width: 80.0,
                          height: 100.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alldata[index].title.toString(),
                            style: StyaleResource.primaryTextStyale,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Movies",style: StyaleResource.textColor,),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(alldata[index]
                                          .voteAverage
                                          .toString(),style: StyaleResource.textColor),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

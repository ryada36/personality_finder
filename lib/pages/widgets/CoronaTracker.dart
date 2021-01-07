import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './counter.dart';

class CoronaTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                height: 350,
                width: double.infinity,
                decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF3383CD),
                        Color(0xFF11249F),
                      ],
                    ),
                    image: DecorationImage(
                      image: AssetImage('images/virus.png'),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => print('open detail page'),
                        child: SvgPicture.asset('images/menu.svg')),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              top: 0,
                              child: SvgPicture.asset(
                                'images/coronadr.svg',
                                width: 230,
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              )),
                          Positioned(
                            top: 10,
                            left: 150,
                            child: Text(
                              "Get to know \nAbout Covid-19",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset('images/maps-and-flags.svg'),
                    SizedBox(width: 20),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: SvgPicture.asset('images/dropdown.svg'),
                        value: "India",
                        items: ["India", "Pakistan", "Bangladesh"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFE5E5E5)),
                )),
            SizedBox(height: 29),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Case Update\n",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Newest update March 28",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ])),
                        Spacer(),
                        Text(
                          "See details",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 30,
                                  color: Colors.white38)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Counter(
                              color: Colors.red,
                              number: 1046,
                              title: "Infected",
                            ),
                            Counter(
                              color: Colors.pink,
                              number: 87,
                              title: "Deaths",
                            ),
                            Counter(
                              color: Colors.green,
                              number: 46,
                              title: "Recovered",
                            ),
                          ],
                        )),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Speed of Virus", style: TextStyle()),
                        Text(
                          "See Details",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      height: 178,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 30,
                                color: Colors.white38)
                          ]),
                      child: Image.asset('images/map.png', fit: BoxFit.contain),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

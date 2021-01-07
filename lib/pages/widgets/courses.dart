import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:personality_finder/pages/widgets/courseDetail.dart';
// import 'package:flutter_svg/svg.dart';

import 'model/category.dart';

class Courses extends StatelessWidget {
  // TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   width: double.infinity,
          //   // height: 50,
          //   // color: Colors.red,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[],
          //   ),
          //   padding: EdgeInsets.all(0),
          // ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Hey User,",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Find a course you want a learn",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14.0,
                    color: Colors.grey)),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 8, right: 8),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search for anything',
                          border: InputBorder.none),
                    ),
                  )
                ],
              )),
          Expanded(
            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseDetail(index: index))),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: index.isEven ? 200 : 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(categories[index].image),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          categories[index].name,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${categories[index].numOfCourses} Courses',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(.5),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            ),
          )
        ],
      ),
    );
  }
}

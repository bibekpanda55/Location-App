import 'package:flutter/material.dart';

class ListWidgetScreen extends StatelessWidget {
  const ListWidgetScreen({Key? key}) : super(key: key);
  static const routeName = '/list-widget-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            separatorBuilder: (ctx, idx) => SizedBox(
                  height: 20,
                ),
            itemCount: 10,
            itemBuilder: (ctx, idx) => buildListTile()));
  }

  Widget buildListTile() {
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(child: Icon(Icons.person)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('Luka Donicic'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Tesla is over valued I connot help,',
                    )
                  ])),
              Icon(
                Icons.more_horiz_outlined,
                color: Colors.black,
              )
            ]),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: (Row(
                      children: [
                        Icon(
                          Icons.thumb_up_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '532',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ))),
                SizedBox(
                  width: 20,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: (Row(
                      children: [
                        Icon(
                          Icons.message_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text('532', style: TextStyle(color: Colors.blue)),
                      ],
                    )))
              ],
            )
          ],
        ));
  }
}

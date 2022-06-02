import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);
  static const routeName = '/test-screen';
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 3,
        separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.all(10),
            child: Divider(
              endIndent: 10,
            )),
        itemBuilder: ((context, index) => _buildTile()));
  }

  Widget _buildTile() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(
        children: const [
          Icon(Icons.apple),
          SizedBox(
            width: 20,
          ),
          Text('APPL')
        ],
      ),
      Text('\$785.25'),
      CircleAvatar(
        backgroundColor: Colors.green,
        child: Text('56'),
      ),
      Text('34%'),
      Text('\$43,114.57\n\t+12.63%'),
    ]);
  }
}

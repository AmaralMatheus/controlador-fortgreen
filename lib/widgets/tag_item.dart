import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final List<String> tags;

  TagItem(this.tags);

  Widget _buildHomeTagItem(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(54)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(tags[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: _buildHomeTagItem,
        itemCount: tags.length);
  }
}

import 'package:flutter/material.dart';

class GroupsTitle extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupsTitle(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<GroupsTitle> createState() => _GroupsTitleState();
}

class _GroupsTitleState extends State<GroupsTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.groupName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Join KE grup ${widget.userName}',
            style: const TextStyle(fontSize: 13),
          ),
        ));
  }
}

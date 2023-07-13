import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../utils/constans.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({super.key, required this.text});

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(color: Colors.grey.shade700),
          maxLines: _showMore ? null : 3, // Show 3 lines when not expanded
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            setState(() {
              _showMore = !_showMore;
            });
          },
          child: _showMore
              ? Row(
                  children: [
                    Text(
                      'Show less',
                      style: TextStyle(color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      IconBroken.Arrow___Up_Circle,
                      color: defaultColor,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      'Show more',
                      style: TextStyle(color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      IconBroken.Arrow___Down_Circle,
                      color: defaultColor,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

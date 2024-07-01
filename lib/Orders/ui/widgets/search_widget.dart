// ignore_for_file: library_private_types_in_public_api

import 'package:dayshez_pt/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final String hintText;
  final ValueChanged<String> onChanged;

  const SearchWidget({
    super.key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  });

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.clear();
      widget.onChanged('');
    });
  }

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: primaryColor);
    const styleHint = TextStyle(color: blackColor);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}

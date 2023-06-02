import 'package:flutter/material.dart';

import '../assets/style/style.dart';

class Searchbar extends StatelessWidget {
  Searchbar({
    super.key,
  });

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchField(
            maxLines: 1,
            hintText: 'Do Exercise',
            controller: controller,
          ),
        ),

        const SearchButton()
      ],
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          color: AppColor.accentOrange,
          borderRadius: BorderRadius.circular(19)),
      child: const Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.maxLines});

  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: bold15.copyWith(color: AppColor.textColor),
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.secondaryColor,
          hintText: hintText,
          hintStyle:
              bold15.copyWith(color: AppColor.textColor.withOpacity(0.4)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(19)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(19)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(19)),
        ));
  }
}

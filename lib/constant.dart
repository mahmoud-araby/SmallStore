import 'package:flutter/material.dart';

final loginDecration = BoxDecoration(
  image: DecorationImage(
    fit: BoxFit.fill,
    colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
    image: AssetImage('assets/login.jpg'),
  ),
);

double varibleWidth(BuildContext context) {
  return MediaQuery.of(context).size.width >= 550
      ? 500
      : MediaQuery.of(context).size.width;
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget hashtagSvg(BuildContext context) {
  return SvgPicture.asset(
    'assets/hashtag_dark.svg',
    height: 100,
    width: 100,
    // ignore: deprecated_member_use
    color: Theme.of(context).colorScheme.primary,
  );
}

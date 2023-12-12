import 'package:flutter/material.dart';
import 'package:keuanganku/util/font_style.dart';

class KPageAppBar extends StatefulWidget {
  const KPageAppBar({super.key, required this.title, required this.menuButton});
  final String title;
  final Widget menuButton;

  @override
  State<KPageAppBar> createState() => _KPageAppBarState();
}

class _KPageAppBarState extends State<KPageAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return IntrinsicHeight(
      child: SizedBox(
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: widget.menuButton,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 0.1 * size.width,
                right: 0.3 * size.width
              ),
              child: SizedBox(
                width: 0.4 * size.width,
                child: Center(
                  child: Text(
                    widget.title, 
                    style: kFontStyle(
                      fontSize: 24, 
                      color: Colors.white
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
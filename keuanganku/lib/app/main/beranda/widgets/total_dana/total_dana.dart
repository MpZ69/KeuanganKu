import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/wrap.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/util/get_currency.dart';

class Data {
  double get dbAPIgetTotalDana {
    return 1500000;
  }
}

class TotalDana {
  TotalDana(this.context);
  BuildContext context;
  static Data data = Data();
  Widget getWidget(){
     return wrapWithPadding(
      context,
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Dana",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "QuickSand_Medium",
                  color: ApplicationColors.primaryColorWidthPercentage(percentage: 75)),
            ),
            Text(
              formatCurrency(TotalDana.data.dbAPIgetTotalDana),
              style: const TextStyle(
                  fontSize: 24,
                  fontFamily: "QuickSand_Bold",
                  color: ApplicationColors.primary),
            )
          ],
        ),
      ),
    );
  }
}
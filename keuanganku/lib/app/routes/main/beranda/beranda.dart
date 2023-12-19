import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/distribusi/distribusi_transaksi.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/list_expenselimiter/list_expenselimiter.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/list_wallet/list_wallet.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/statistik/statistik.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/database/helper/user_data.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/distribusi/distribusi_transaksi.dart' as distribusi_tx;
import 'package:keuanganku/app/routes/main/beranda/widgets/statistik/statistik.dart' as statistik;
import 'package:keuanganku/util/font_style.dart';

class WidgetData{
  distribusi_tx.WidgetData wxDataDistribusiTransaksi = distribusi_tx.WidgetData();
  statistik.WidgetData wxDataStatistik = statistik.WidgetData();
}

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key, required this.parentScaffoldKey});

  final GlobalKey<ScaffoldState> parentScaffoldKey;
  static StateBridge state = StateBridge();
  static WidgetData widgetData = WidgetData();

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {

  KEventHandler callback(){
    updateState();
    HalamanPengeluaran.state.update();
  }

  void updateState() {
    setState(() {

    });
  }

  Widget drawerButton(){
    return GestureDetector(
      onTap: (){
        widget.parentScaffoldKey.currentState!.openDrawer();
      },
      child: const Icon(
        Icons.menu, 
        size: 30, 
        color: Colors.white,
      ),
    );
  }
   
  Widget listWallet() {
    void callback(){
      updateState();
      HalamanWallet.state.update();
      HalamanPengeluaran.state.update();
    }

    return FutureBuilder(
      future: SQLHelperWallet().readAll(db.database), 
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return makeCenterWithRow(child: const Text("Something wrong..."));
        } else {
          return ListWallet(wallets: snapshot.data!, callback: callback);
        }
      },
    );
  }
  Widget getUsername() {
    return FutureBuilder(
      future: SQLHelperUserData().readById(db.database, 1), 
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else {
          String username = "";
          const String defaultUserName = "User";
          if (snapshot.hasError){
            username = defaultUserName;
          } else {
            username = snapshot.data!.username ?? defaultUserName;
          }
          
          return Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello,", style: kFontStyle(fontSize: 16, color: Colors.white, family: "QuickSand_Medium"),),
                Text(username, style: kFontStyle(fontSize: 26, color: Colors.white),),
              ],
            ),
          );
        }
      }
    );
  }

  Widget buildBody(BuildContext context){
    const double paddingBottom = 20;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dummyPadding(height: 50),
          KPageAppBar(title: "Beranda", menuButton: drawerButton(),),
          dummyPadding(height: paddingBottom),
          getUsername(),
          dummyPadding(height: paddingBottom),
          listWallet(),
          dummyPadding(height: paddingBottom),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 25,),
                  Statistik(
                    widgetData: HalamanBeranda.widgetData.wxDataStatistik,
                  ),
                  const SizedBox(width: 15,),
                  DistribusiTransaksi(
                    widgetData: HalamanBeranda.widgetData.wxDataDistribusiTransaksi,
                    getter: () => HalamanBeranda.widgetData.wxDataDistribusiTransaksi.getData(),
                  ),
                  const SizedBox(width: 25,),
                ],  
              ),
            )
          ),
          dummyPadding(height: paddingBottom),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListExpenseLimiter(callback: callback),
          ),
          dummyPadding(height: 25),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HalamanBeranda.state.init(updateState);
    return Scaffold(
      backgroundColor: ApplicationColors.primary,
      body: buildBody(context)
    );
  }
}

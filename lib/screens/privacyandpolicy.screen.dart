import 'dart:io';

import 'package:app/config.dart';
import 'package:app/constants/colors.dart';
import 'package:app/screens/welcome.screen.dart';
import 'package:app/utils/size_config..dart';
import 'package:app/widgets/button.widget.dart';
import 'package:app/widgets/copyright.widget.dart';
import 'package:app/widgets/label.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class PrivacyAndPolicyScreen extends StatelessWidget {
  static final routeName = "/PrivacyAndPolicyScreen";
  void aggree() {
    Box box = Hive.box('GUEST');
    box.put("privacyAndPolicy", true);
    Get.offNamed(WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Palette.colorWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        title: LabelWidget(
          "Privasi dan Persyaratan",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: new Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Scrollbar(
              child: ListView(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                children: [
                  LabelWidget(
                    "Ketentuan",
                    color: Colors.black87,
                    fontSize: 18.0,
                    textAlign: TextAlign.left,
                  ),
                  LabelWidget(
                    "Dengan mengakses aplikasi ${Config.application}, Anda setuju untuk terikat oleh "
                    "syarat dan Ketentuan Penggunaan aplikasi, "
                    "semua hukum dan peraturan yang berlaku, "
                    "dan setuju bahwa Anda bertanggung jawab untuk mematuhi hukum setempat yang berlaku.\n\n"
                    "Jika Anda tidak setuju dengan istilah ini, Anda dilarang menggunakan "
                    "atau mengakses aplikasi ini. Bahan-bahan yang terkandung dalam aplikasi ini "
                    "dilindungi oleh hak cipta yang berlaku dan hukum merek dagang.\n",
                    fontSize: 16.0,
                    color: new Color(0xff3b3b3b),
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                  LabelWidget(
                    "Kebijakan pribadi",
                    color: Colors.black87,
                    fontSize: 18.0,
                    textAlign: TextAlign.left,
                  ),
                  LabelWidget(
                    "Privasi Anda penting bagi kami, dan itu adalah kebijakan ${Config.application} untuk menghormati privasi Anda "
                    "mengenai informasi yang kami kumpulkan sementara dari aplikasi ini. "
                    "Dengan demikian, kami telah mengembangkan Kebijakan ini agar Anda memahami bagaimana kami "
                    "mengumpulkan, menggunakan, berkomunikasi dan mengungkapkan dan menggunakan informasi pribadi.\n",
                    fontSize: 16.0,
                    color: new Color(0xff3b3b3b),
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                  LabelWidget(
                    "Penolakan",
                    color: Colors.black87,
                    fontSize: 18.0,
                    textAlign: TextAlign.left,
                  ),
                  LabelWidget(
                    "Bahan-bahan di aplikasi ${Config.application} ini disediakan 'sebagaimana adanya'. "
                    "${Config.application} tidak memberikan jaminan, tersurat maupun tersirat, "
                    "dan dengan ini menolak dan meniadakan semua jaminan lainnya, termasuk tanpa batasan, "
                    "jaminan tersirat atau kondisi yang dapat diperjualbelikan, kesesuaian untuk tujuan tertentu, "
                    "atau non-pelanggaran atas kekayaan intelektual atau pelanggaran lain dari hak. \n\n"
                    "Selanjutnya, ${Config.application} tidak menjamin atau membuat pernyataan apapun tentang akurasi, "
                    "kemungkinan hasil, atau keandalan dari penggunaan materi di aplikasi atau yang berkaitan "
                    "dengan bahan tersebut atau pada setiap aplikasi yang terhubung ke aplikasi ini.\n",
                    fontSize: 16.0,
                    color: new Color(0xff3b3b3b),
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                  LabelWidget(
                    "Keterbatasan",
                    color: Colors.black87,
                    fontSize: 18.0,
                    textAlign: TextAlign.left,
                  ),
                  LabelWidget(
                    "Dalam hal apapun ${Config.application} atau pemasok tidak bertanggung jawab "
                    "untuk kerugian (termasuk, tanpa batasan, ganti rugi atas hilangnya data atau keuntungan, "
                    "atau karena gangguan bisnis), yang timbul dari penggunaan atau ketidakmampuan untuk "
                    "menggunakan materi di Internet aplikasi ${Config.application} ini, bahkan jika ${Config.application} atau "
                    "perwakilan ${Config.application} resmi telah diberitahu secara lisan atau tertulis dari kemungkinan "
                    "kerusakan tersebut. Karena beberapa yurisdiksi tidak mengizinkan pembatasan pada jaminan "
                    "tersirat, atau keterbatasan dari tanggung jawab untuk kerusakan konsekuensial atau insidentil, "
                    "keterbatasan ini mungkin tidak berlaku untuk Anda.\n",
                    fontSize: 16.0,
                    color: new Color(0xff3b3b3b),
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                  LabelWidget(
                    "Revisi",
                    color: Colors.black87,
                    fontSize: 18.0,
                    textAlign: TextAlign.left,
                  ),
                  LabelWidget(
                    "Materi yang muncul di aplikasi ${Config.application} bisa mencakup teknis, kesalahan ketik, "
                    "atau fotografi. ${Config.application} tidak menjamin bahwa setiap materi di aplikasi adalah akurat, "
                    "lengkap, pada saat ini. ${Config.application} dapat membuat perubahan materi yang terkandung di aplikasi "
                    "setiap saat tanpa pemberitahuan. ${Config.application} tidak membuat komitmen untuk memperbaharui materi.\n",
                    fontSize: 16.0,
                    color: new Color(0xff3b3b3b),
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                  LabelWidget(
                    "Links",
                    color: Colors.black87,
                    fontSize: 18.0,
                    textAlign: TextAlign.left,
                  ),
                  LabelWidget(
                    "${Config.application} belum meninjau semua aplikasi yang terhubung ke aplikasi dan tidak bertanggung "
                    "jawab atas isi dari setiap aplikasi yang terhubung tersebut. Dimasukkannya semua link tidak "
                    "menyiratkan pengesahan oleh aplikasi ${Config.application}. Penggunaan aplikasi tersebut terkait adalah resiko "
                    "pengguna sendiri.\n",
                    fontSize: 16.0,
                    color: new Color(0xff3b3b3b),
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                  LabelWidget(
                    "Aplikasi syarat pengguna modifikasi",
                    color: Colors.black87,
                    fontSize: 18.0,
                    textAlign: TextAlign.left,
                  ),
                  LabelWidget(
                    "${Config.application} dapat merevisi persyaratan penggunaan untuk aplikasi setiap saat tanpa pemberitahuan. "
                    "Dengan menggunakan aplikasi ini, Anda setuju untuk terikat oleh versi sekarang dari Syarat dan "
                    "Ketentuan Penggunaan.\n",
                    fontSize: 16.0,
                    color: new Color(0xff3b3b3b),
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                  LabelWidget(
                    "Hukum",
                    color: Colors.black87,
                    fontSize: 18.0,
                    textAlign: TextAlign.left,
                  ),
                  LabelWidget(
                    "Setiap klaim yang berkaitan dengan aplikasi ${Config.application} ini akan diatur oleh hukum Indonesia tanpa memperhatikan "
                    "pertentangan ketentuan hukum Syarat dan Ketentuan Umum yang berlaku untuk penggunaan aplikasi.\n",
                    fontSize: 16.0,
                    color: new Color(0xff3b3b3b),
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: new Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: <Widget>[
                ButtonWidget(
                  "Batal",
                  height: 45,
                  onPressed: () => exit(0),
                ),
                ButtonWidget(
                  "Saya Setuju",
                  backgroundColor: Theme.of(context).primaryColor,
                  fontColor: Colors.white,
                  height: 45,
                  onPressed: () => aggree(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CopyrightWidget(),
    );
  }
}

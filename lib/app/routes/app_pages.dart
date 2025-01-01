import 'package:get/get.dart';
import '../modules/DAPURHOME/bindings/dapurhome_binding.dart';
import '../modules/DAPURHOME/views/dapurhome_view.dart';
import '../modules/dapur1/bindings/dapur1_binding.dart';
import '../modules/dapur1/views/dapur1_view.dart';
import '../modules/dapur2/bindings/dapur2_binding.dart';
import '../modules/dapur2/views/dapur2_view.dart';
import '../modules/dapur3/bindings/dapur3_binding.dart';
import '../modules/dapur3/views/dapur3_view.dart';
import '../modules/dapur4/bindings/dapur4_binding.dart';
import '../modules/dapur4/views/dapur4_view.dart';
import '../modules/historypage/bindings/historypage_binding.dart';
import '../modules/historypage/views/historypage_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home2/bindings/home2_binding.dart';
import '../modules/home2/views/home2_view.dart';
import '../modules/homeruangtamu/bindings/homeruangtamu_binding.dart';
import '../modules/homeruangtamu/views/homeruangtamu_view.dart';
import '../modules/interior1/bindings/interior1_binding.dart';
import '../modules/interior1/views/interior1_view.dart';
import '../modules/interior2/bindings/interior2_binding.dart';
import '../modules/interior2/views/interior2_view.dart';
import '../modules/interior3/bindings/interior3_binding.dart';
import '../modules/interior3/views/interior3_view.dart';
import '../modules/interior4/bindings/interior4_binding.dart';
import '../modules/interior4/views/interior4_view.dart';
import '../modules/interiorkesukses/bindings/interiorkesukses_binding.dart';
import '../modules/interiorkesukses/views/interiorkesukses_view.dart';
import '../modules/kamar/bindings/kamar_binding.dart';
import '../modules/kamar/views/kamar_view.dart';
import '../modules/kamaramerika1/bindings/kamaramerika1_binding.dart';
import '../modules/kamaramerika1/views/kamaramerika1_view.dart';
import '../modules/kamareropa1/bindings/kamareropa1_binding.dart';
import '../modules/kamareropa1/views/kamareropa1_view.dart';
import '../modules/kamarjapan1/bindings/kamarjapan1_binding.dart';
import '../modules/kamarjapan1/views/kamarjapan1_view.dart';
import '../modules/kamarspanyol1/bindings/kamarspanyol_binding.dart';
import '../modules/kamarspanyol1/views/kamarspanyol1_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupapassword/bindings/lupapassword_binding.dart';
import '../modules/lupapassword/views/lupapassword_view.dart';
import '../modules/passwordbaru/bindings/passwordbaru_binding.dart';
import '../modules/passwordbaru/views/passwordbaru_view.dart';
import '../modules/profileinfo/bindings/profileinfo_binding.dart';
import '../modules/profileinfo/views/profileinfo_view.dart';
import '../modules/profilepage/bindings/profilepage_binding.dart';
import '../modules/profilepage/views/profilepage_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/suksesdaftar/bindings/suksesdaftar_binding.dart';
import '../modules/suksesdaftar/views/success_registration_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SUKSESDAFTAR,
      page: () => SuccessRegistrationView(),
      binding: SuksesdaftarBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LUPAPASSWORD,
      page: () => LupaPasswordView(),
      binding: LupapasswordBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORDBARU,
      page: () => PasswordBaruView(),
      binding: PasswordbaruBinding(),
    ),
    GetPage(
      name: _Paths.HOME2,
      page: () => HomePage(),
      binding: Home2Binding(),
    ),
    GetPage(
      name: _Paths.HISTORYPAGE,
      page: () => HistoryPage(),
      binding: HistorypageBinding(),
    ),
    GetPage(
      name: _Paths.KAMAR,
      page: () => KamarView(),
      binding: KamarBinding(),
    ),
    GetPage(
      name: _Paths.KAMARSPANYOL,
      page: () => Kamarspanyol1View(),
      binding: KamarspanyolBinding(),
    ),
    GetPage(
      name: _Paths.DAPURHOME,
      page: () => dapurhomeView(),
      binding: DapurhomeBinding(),
    ),
    GetPage(
      name: _Paths.DAPUR1,
      page: () => dapur1View(),
      binding: Dapur1Binding(),
    ),
    GetPage(
      name: _Paths.DAPUR2,
      page: () => Dapur2View(),
      binding: Dapur2Binding(),
    ),
    GetPage(
      name: _Paths.DAPUR3,
      page: () => Dapur3View(),
      binding: Dapur3Binding(),
    ),
    GetPage(
      name: _Paths.DAPUR4,
      page: () => dapur4View(),
      binding: Dapur4Binding(),
    ),
    GetPage(
      name: _Paths.PROFILEPAGE,
      page: () => ProfilePage(),
      binding: ProfilepageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILEINFO,
      page: () => ProfileInfoView(),
      binding: ProfileinfoBinding(),
    ),
    GetPage(
      name: _Paths.HOMERUANGTAMU,
      page: () => HomeruangtamuView(),
      binding: HomeruangtamuBinding(),
    ),
    GetPage(
      name: _Paths.INTERIOR1,
      page: () => Interior1View(),
      binding: Interior1Binding(),
    ),
    GetPage(
      name: _Paths.INTERIOR2,
      page: () => Interior2View(),
      binding: Interior2Binding(),
    ),
    GetPage(
      name: _Paths.INTERIOR3,
      page: () => Interior3View(),
      binding: Interior3Binding(),
    ),
    GetPage(
      name: _Paths.INTERIOR4,
      page: () => Interior4View(),
      binding: Interior4Binding(),
    ),

    GetPage(
      name: _Paths.INTERIORKESUKSES,
      page: () => InteriorSuksesView(),
      binding: InteriorkesuksesBinding(),
    ),
    GetPage(
      name: _Paths.KAMARJAPAN1,
      page: () => Kamarjapan1View(),
      binding: Kamarjapan1Binding(),
    ),
    GetPage(
      name: _Paths.KAMARAMERIKA1,
      page: () => Kamaramerika1View(),
      binding: Kamaramerika1Binding(),
    ),
    GetPage(
      name: _Paths.KAMAREROPA1,
      page: () => Kamareropa1View(),
      binding: Kamareropa1Binding(),
    ),
  ];
}

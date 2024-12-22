import 'package:get/get.dart';

import '../modules/admin_faq/bindings/admin_faq_binding.dart';
import '../modules/admin_faq/views/admin_faq_view.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/admin_produk/bindings/admin_produk_binding.dart';
import '../modules/admin_produk/views/admin_produk_view.dart';
import '../modules/alamat_saya/bindings/alamat_saya_binding.dart';
import '../modules/alamat_saya/views/alamat_saya_view.dart';
import '../modules/alamat_tagihan/bindings/alamat_tagihan_binding.dart';
import '../modules/alamat_tagihan/views/alamat_tagihan_view.dart';
import '../modules/allbrand/bindings/allbrand_binding.dart';
import '../modules/allbrand/views/allbrand_view.dart';
import '../modules/brandfm1/bindings/brandfm1_binding.dart';
import '../modules/brandfm1/views/brandfm1_view.dart';
import '../modules/brandfm2/bindings/brandfm2_binding.dart';
import '../modules/brandfm2/views/brandfm2_view.dart';
import '../modules/brandhm1/bindings/brandhm1_binding.dart';
import '../modules/brandhm1/views/brandhm1_view.dart';
import '../modules/brandhm2/bindings/brandhm2_binding.dart';
import '../modules/brandhm2/views/brandhm2_view.dart';
import '../modules/brandms1/bindings/brandms1_binding.dart';
import '../modules/brandms1/views/brandms1_view.dart';
import '../modules/brandms2/bindings/brandms2_binding.dart';
import '../modules/brandms2/views/brandms2_view.dart';
import '../modules/brandvindys1/bindings/brandvindys1_binding.dart';
import '../modules/brandvindys1/views/brandvindys1_view.dart';
import '../modules/brandvindys2/bindings/brandvindys2_binding.dart';
import '../modules/brandvindys2/views/brandvindys2_view.dart';
import '../modules/forgot_pw/bindings/forgot_pw_binding.dart';
import '../modules/forgot_pw/views/forgot_pw_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_fm/bindings/home_fm1_binding.dart';
import '../modules/home_fm/views/home_fm_view.dart';
import '../modules/home_hm/bindings/home_hm_binding.dart';
import '../modules/home_hm/views/home_hm_view.dart';
import '../modules/home_ms/bindings/home_ms_binding.dart';
import '../modules/home_ms/views/home_ms_view.dart';
import '../modules/home_vd/bindings/home_vd_binding.dart';
import '../modules/home_vd/views/home_vd_view.dart';
import '../modules/keranjang/bindings/keranjang_binding.dart';
import '../modules/keranjang/views/keranjang_view.dart';
import '../modules/keranjang_fm1/bindings/keranjang_fm1_binding.dart';
import '../modules/keranjang_fm1/views/keranjang_fm1_view.dart';
import '../modules/keranjang_fm2/bindings/keranjang_fm2_binding.dart';
import '../modules/keranjang_fm2/views/keranjang_fm2_view.dart';
import '../modules/keranjang_hm1/bindings/keranjang_hm1_binding.dart';
import '../modules/keranjang_hm1/views/keranjang_hm1_view.dart';
import '../modules/keranjang_hm2/bindings/keranjang_hm2_binding.dart';
import '../modules/keranjang_hm2/views/keranjang_hm2_view.dart';
import '../modules/keranjang_ms1/bindings/keranjang_ms1_binding.dart';
import '../modules/keranjang_ms1/views/keranjang_ms1_view.dart';
import '../modules/keranjang_ms2/bindings/keranjang_ms2_binding.dart';
import '../modules/keranjang_ms2/views/keranjang_ms2_view.dart';
import '../modules/keranjang_vd1/bindings/keranjang_vd1_binding.dart';
import '../modules/keranjang_vd1/views/keranjang_vd1_view.dart';
import '../modules/keranjang_vd2/bindings/keranjang_vd2_binding.dart';
import '../modules/keranjang_vd2/views/keranjang_vd2_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_pw/bindings/new_pw_binding.dart';
import '../modules/new_pw/views/new_pw_view.dart';
import '../modules/pembayaran/bindings/pembayaran_binding.dart';
import '../modules/pembayaran/views/pembayaran_view.dart';
import '../modules/pencarian/bindings/pencarian_binding.dart';
import '../modules/pencarian/views/pencarian_view.dart';
import '../modules/pesanan_sukses/bindings/pesanan_sukses_binding.dart';
import '../modules/pesanan_sukses/views/pesanan_sukses_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/user_faq/bindings/user_faq_binding.dart';
import '../modules/user_faq/views/user_faq_view.dart';
import '../modules/user_profil/bindings/user_profil_binding.dart';
import '../modules/user_profil/views/user_profil_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

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
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PW,
      page: () => ForgotPwView(),
      binding: ForgotPwBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PW,
      page: () => NewPwView(),
      binding: NewPwBinding(),
    ),
    GetPage(
      name: _Paths.BRANDMS1,
      page: () => Brandms1View(),
      binding: Brandms1Binding(),
    ),
    GetPage(
      name: _Paths.BRANDFM1,
      page: () => Brandfm1View(),
      binding: Brandfm1Binding(),
    ),
    GetPage(
      name: _Paths.BRANDFM2,
      page: () => Brandfm2View(),
      binding: Brandfm2Binding(),
    ),
    GetPage(
      name: _Paths.BRANDMS2,
      page: () => Brandms2View(),
      binding: Brandms2Binding(),
    ),
    GetPage(
      name: _Paths.BRANDHM1,
      page: () => Brandhm1View(),
      binding: Brandhm1Binding(),
    ),
    GetPage(
      name: _Paths.BRANDVINDYS1,
      page: () => Brandvindys1View(),
      binding: Brandvindys1Binding(),
    ),
    GetPage(
      name: _Paths.BRANDHM2,
      page: () => Brandhm2View(),
      binding: Brandhm2Binding(),
    ),
    GetPage(
      name: _Paths.BRANDVINDYS2,
      page: () => Brandvindys2View(),
      binding: Brandvindys2Binding(),
    ),
    GetPage(
      name: _Paths.ALLBRAND,
      page: () => AllbrandView(),
      binding: AllbrandBinding(),
    ),
    GetPage(
      name: _Paths.HOME_FM1,
      page: () => HomeFmView(),
      binding: HomeFm1Binding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_MS1,
      page: () => KeranjangMs1View(),
      binding: KeranjangMs1Binding(),
    ),
    GetPage(
      name: _Paths.HOME_HM,
      page: () => HomeHmView(),
      binding: HomeHmBinding(),
    ),
    GetPage(
      name: _Paths.HOME_MS,
      page: () => HomeMsView(),
      binding: HomeMsBinding(),
    ),
    GetPage(
      name: _Paths.HOME_VD,
      page: () => HomeVdView(),
      binding: HomeVdBinding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_MS2,
      page: () => const KeranjangMs2View(),
      binding: KeranjangMs2Binding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_FM1,
      page: () => const KeranjangFm1View(),
      binding: KeranjangFm1Binding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_FM2,
      page: () => const KeranjangFm2View(),
      binding: KeranjangFm2Binding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_HM1,
      page: () => const KeranjangHm1View(),
      binding: KeranjangHm1Binding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_HM2,
      page: () => const KeranjangHm2View(),
      binding: KeranjangHm2Binding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_VD1,
      page: () => const KeranjangVd1View(),
      binding: KeranjangVd1Binding(),
    ),
    GetPage(
      name: _Paths.KERANJANG_VD2,
      page: () => const KeranjangVd2View(),
      binding: KeranjangVd2Binding(),
    ),
    GetPage(
      name: _Paths.PENCARIAN,
      page: () => PencarianView(),
      binding: PencarianBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN,
      page: () => const PembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.KERANJANG,
      page: () => KeranjangView(),
      binding: KeranjangBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.ALAMAT_TAGIHAN,
      page: () => AlamatTagihanView(),
      binding: AlamatTagihanBinding(),
    ),
    GetPage(
      name: _Paths.PESANAN_SUKSES,
      page: () => const PesananSuksesView(),
      binding: PesananSuksesBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFIL,
      page: () => UserProfilView(),
      binding: UserProfilBinding(),
    ),
    GetPage(
      name: _Paths.ALAMAT_SAYA,
      page: () => const AlamatSayaView(),
      binding: AlamatSayaBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PRODUK,
      page: () => AdminProdukView(),
      binding: AdminProdukBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_FAQ,
      page: () => const AdminFaqView(),
      binding: AdminFaqBinding(),
    ),
    GetPage(
      name: _Paths.USER_FAQ,
      page: () => const UserFaqView(),
      binding: UserFaqBinding(),
    ),
  ];
}

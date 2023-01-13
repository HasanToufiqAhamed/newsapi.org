import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/app/modules/book_mark/controllers/book_mark_controller.dart';
import 'package:untitled/app/modules/home/views/bottom_sheet/country_bottom_sheet.dart';
import 'package:untitled/domain/core/exceptions/time_out.exception.dart';

import '../../../../domain/core/exceptions/default.exception.dart';
import '../../../../domain/core/exceptions/invalid_token.exception.dart';
import '../../../../domain/core/model/news/news_ui.model.dart';
import '../../../../domain/interface/repository/news.repository.interface.dart';
import '../../../../domain/service/news/dto/news.dto.dart';
import '../../../utilities/custom_widgets/message/snack_bars.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final INewsRepository _newsRepository;
  final BookMarkController _bookMarkController;

  HomeController({
    required INewsRepository newsRepository,
    required BookMarkController bookMarkController,
  })  : _newsRepository = newsRepository,
        _bookMarkController = bookMarkController;

  @override
  void onInit() {
    productsScrollController = ScrollController()..addListener(scrollListener);
    tabController = TabController(length: tabs.length, vsync: this);
    category = tabs.first;
    country.value = countries.first;
    _getAllNews();
    getUserInfo();
    super.onInit();
  }

  @override
  void onClose() {
    productsScrollController!.removeListener(scrollListener);
    tabCurrentIndex.close();
    tabController!.dispose();
    super.onClose();
  }

  TabController? tabController;
  ScrollController? productsScrollController;

  RxInt tabCurrentIndex = 0.obs;
  List<String> tabs = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
  List<String> countries = ['US', 'IN'];

  List<NewsUIModel> newsList = [];
  bool loadingForNews = true;
  RxBool loadingMoreProduct = false.obs;
  RxBool noMoreProduct = false.obs;

  int currentPage = 1;
  String category = '';
  RxString country = ''.obs;
  String searchKey = '';

  void resetAndGetNews() {
    currentPage = 1;
    newsList.clear();
    loadingForNews = true;
    _getAllNews();
  }

  void _getAllNews() async {
    try {
      NewsDto dto = NewsDto(
        country: country.value,
        category: category,
        page: currentPage,
        searchKey: searchKey,
      );
      List<NewsUIModel> newNews = await _newsRepository.getAllNews(dto);
      for (var value in newNews) {
        newsList.add(value);
      }
      if (newNews.isNotEmpty) {
        currentPage += 1;
      } else {
        noMoreProduct.value = true;
      }
    } on InvalidTokenException catch (e) {
      showBasicSnackBar(message: e.message, success: false);
    } on TimeOutException catch (e) {
      showBasicSnackBar(message: e.message, success: false);
    } on DefaultException catch (e) {
      showBasicSnackBar(message: e.message, success: false);
    } catch (e, t) {
      if (kDebugMode) {
        print('get new error ---<>');
        print(e.toString());
        print(t.toString());
      }
    } finally {
      loadingForNews = false;
      enableTempPaginate = true;
      loadingMoreProduct.value = false;
      update(['news']);
    }
  }

  bool enableTempPaginate = true;

  void scrollListener() async {
    if ((productsScrollController!.position.pixels ==
                productsScrollController!.position.maxScrollExtent ||
            productsScrollController!.position.pixels >=
                productsScrollController!.position.maxScrollExtent) &&
        enableTempPaginate) {
      if (noMoreProduct.value == false) {
        enableTempPaginate = false;
        loadingMoreProduct.value = true;

        _getAllNews();
      }
    }
  }

  void changeTab({required int value}) {
    tabCurrentIndex.value = value;
    loadingForNews = true;
    enableTempPaginate = true;
    loadingMoreProduct.value = false;
    noMoreProduct.value = false;
    update(['news']);
    category = tabs[value];
    currentPage = 1;
    searchKey = '';
    newsList.clear();
    _getAllNews();
  }

  void selectCountry() async {
    var result = await Get.bottomSheet(
      CountryBottomSheet(),
    );

    if (result != null) {
      loadingForNews = true;
      enableTempPaginate = true;
      loadingMoreProduct.value = false;
      noMoreProduct.value = false;
      update(['news']);
      currentPage = 1;
      newsList.clear();
      country.value = result;
      searchKey = '';
      _getAllNews();
    }
  }

  void search({required String keyWord}) {
    loadingForNews = true;
    enableTempPaginate = true;
    loadingMoreProduct.value = false;
    noMoreProduct.value = false;
    update(['news']);
    currentPage = 1;
    newsList.clear();
    searchKey = keyWord;
    _getAllNews();
  }

  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          showBasicSnackBar(
            message: e.message ?? 'account-exists-with-different-credential',
            success: false,
          );
        } else if (e.code == 'invalid-credential') {
          showBasicSnackBar(
            message: e.message ?? 'invalid-credential',
            success: false,
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('google sign in error ---<>');
          print(e.toString());
        }
      }
    }

    return user;
  }

  User? user;
  RxString userImage = ''.obs;

  void googleSignIn() async {
    try {
      user = await signInWithGoogle();
      userImage.value = user?.photoURL ?? '';
      _bookMarkController.init();
    } catch (e) {
      if (kDebugMode) {
        print('google sign in error ---<>');
        print(e.toString());
      }
    }
  }

  void getUserInfo() {
    try {
      user = FirebaseAuth.instance.currentUser;
      userImage.value = user?.photoURL ?? '';
    } catch (e) {
      if (kDebugMode) {
        print('user info error ---<>');
        print(e.toString());
      }
    }
  }

  void signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      userImage.value = '';
    } catch (e) {
      if (kDebugMode) {
        print('google sign out error ---<>');
        print(e.toString());
      }
    }
  }
}

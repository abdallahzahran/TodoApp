import 'package:get/get.dart';
import 'package:todoapp/core/translation/translation_keys.dart';
import '../cache/cache_data.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_keys.dart';
import 'ar.dart';
import 'en.dart';



class TranslationHelper implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    CacheKeys.keyAR: ar,
    CacheKeys.keyEN: en,
  };

  static Future setLanguage() async
  {
    CacheData.lang = await CacheHelper.getData(key: CacheKeys.langKey);

    if (CacheData.lang == null)
    {
      await CacheHelper.saveData(
          key: CacheKeys.langKey, value: CacheKeys.keyEN);
      await Get.updateLocale(TranslationKeys.localeEN);
      CacheData.lang = CacheKeys.keyEN;
    }
  }

  static changeLanguage(bool isAr)async
  {
    if(isAr)
    {
      await CacheHelper.saveData(
          key: CacheKeys.langKey, value: CacheKeys.keyAR);
      await Get.updateLocale(TranslationKeys.localeAR);
      CacheData.lang = CacheKeys.keyAR;
    }
    else
    {
      await CacheHelper.saveData(
          key: CacheKeys.langKey, value: CacheKeys.keyEN);
      await Get.updateLocale(TranslationKeys.localeEN);
      CacheData.lang = CacheKeys.keyEN;
    }

  }
}
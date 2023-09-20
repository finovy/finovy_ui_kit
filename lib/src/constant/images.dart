/// 本地png等图片的路径
const String localImagePath = 'lib/assets/images/';

/// 远程图片的路径
const String networkImagePath = 'https://commom.cdn.bcebos.com';

/// 网络占位图
const String placeholder = '$networkImagePath/baymax/country/flag_gb.png';

/*
 * 图片
 */
class FNImagePath {
  /// input
  static String openEyeIcon = FNImagePath.png('icon_login_visible'); //可见
  static String closeEyeIcon = FNImagePath.png('icon_login_unvisible'); //不可见

  /*
   * @description:    获取本地png图片路径
   * @params:         name: 图片名称
   * @return:         String
   * @author:         jay xie
   * @time:           26/01/21 10:49
   */
  static String png(String name) {
    if (name.contains('.png') ||
        name.contains('.jpg') ||
        name.contains('.jpeg') ||
        name.contains('.PNG')) {
      return '$localImagePath$name';
    }
    return '$localImagePath$name.png';
  }
}

import 'package:flutter/material.dart';

/// 图片加载（支持本地与网络图片）
class FNUIImage extends StatelessWidget {
  const FNUIImage(this.path,
      {super.key,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.holderImg = '',
      this.errorHolderImg,
      this.cacheWidth,
      this.cacheHeight,
      this.color,
      this.loadOptions,
      this.package = 'module_library'});

  /// 图片路径
  final String path;

  /// 图片宽度
  final double? width;

  /// 图片高度
  final double? height;

  /// 填充模式
  final BoxFit fit;

  /// 默认图片（全路径）
  final String holderImg;

  /// 错误图片（全路径）
  final String? errorHolderImg;

  /// 缓存宽度
  final int? cacheWidth;

  /// 缓存高度
  final int? cacheHeight;

  /// 图片颜色
  final Color? color;

  /// 加载配置项（用于相对路径图片或者替换新域名）
  final FNResourceLoadOptions? loadOptions;

  /// 资源库名称
  final String package;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return Container();

    if (path.startsWith('http') || path.startsWith('https')) {
      String netPath = _convertPath(path);
      final Widget holder = holderImg.isEmpty
          ? Container(
              height: height,
              width: width,
              color: color ?? Colors.white,
            )
          : LoadAssetImage(holderImg, height: height, width: width, fit: fit);
      Widget? errorHolder;
      if (errorHolderImg != null && errorHolderImg!.isNotEmpty) {
        errorHolder = LoadAssetImage(
          errorHolderImg!.convert(packageName: package),
          height: height,
          width: width,
          fit: fit,
        );
      }
      /*return CachedNetworkImage(
        imageUrl: netPath,
        placeholder: (_, __) => holder,
        errorWidget: (_, __, dynamic error) => errorHolder ?? holder,
        width: width,
        height: height,
        fit: fit,
        color: color,
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
        cacheManager: cacheManager,
      );*/
      return Image.network(
        netPath,
        width: width,
        height: height,
        fit: fit,
        color: color,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return holder;
          }
        },
        errorBuilder: (context, error, stackTrace) => errorHolder ?? holder,
      );
    } else {
      return LoadAssetImage(path.convert(packageName: package),
          height: height,
          width: width,
          fit: fit,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
          color: color);
    }
  }

  /*
  * @description:     转换路径
  * param:
  * @return:
  * @author:          novice.cai
  * @time:            2022/12/12 15:44
  */
  String _convertPath(String path) {
    String targetUrl = loadOptions?.targetBaseUrl ?? '';
    if (path.startsWith('http')) {
      bool needReplace = loadOptions?.needReplace ?? false;
      if (targetUrl.isEmpty ||
          loadOptions?.replaceUrls == null ||
          loadOptions?.replaceUrls?.isEmpty == true) {
        return path;
      }
      if (targetUrl.isNotEmpty && path.startsWith(targetUrl)) {
        return path;
      }
      if (needReplace) {
        loadOptions?.replaceUrls?.forEach((element) {
          if (path.startsWith(element)) {
            path = targetUrl + path.split(element).last;
          }
        });
      }
    } else {
      // 相对路径补全
      path = targetUrl + path;
    }
    return path;
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit,
    this.color,
  });

  final String image;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: height,
      width: width,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,

      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}

/*
* @description:     加载配置项
* param:
* @return:
* @author:          novice.cai
* @time:            2022/12/12 15:24
*/
class FNResourceLoadOptions extends Object {
  /// 是否需要替换域名
  bool? needReplace = true;

  /// 目标域名 如 https://116.com.cn-open.oss-cn-shenzhen.aliyuncs.com
  /// 如果返回的是相对路径，那么这个targetBaseUrl不能为空
  String? targetBaseUrl;

  /// 被替换域名 如[https://xgc-dev-open.oss-cn-shenzhen.aliyuncs.com,https://xgc-dev2-open.oss-cn-shenzhen.aliyuncs.com]
  List<String>? replaceUrls;

  FNResourceLoadOptions(
      {this.needReplace, this.targetBaseUrl, this.replaceUrls});
  FNResourceLoadOptions.init(
      {this.needReplace, this.targetBaseUrl, this.replaceUrls});
}

extension ImagePath on String {
  String convert({String packageName = ''}) {
    String libPath = packageName.isNotEmpty ? 'packages/$packageName/' : '';
    String sourcePath = 'lib/assets/';
    String prefix = 'images/';
    if (startsWith(libPath)) {
      return this;
    }
    if (startsWith(sourcePath)) {
      sourcePath = '';
      prefix = '';
    }
    String target = "$libPath$sourcePath$prefix$this";
    return target;
  }
}

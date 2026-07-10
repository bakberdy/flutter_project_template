import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  final String imageUrl;
  final BoxFit? fit;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: resolveUrl(imageUrl, context.di<CoreAppConfig>()),
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }

  static String resolveUrl(String imageUrl, CoreAppConfig appConfig) {
    final value = imageUrl.trim();
    final imageUri = Uri.tryParse(value);
    if (imageUri != null && imageUri.hasScheme) {
      return value;
    }

    final baseUri = Uri.tryParse(appConfig.baseUrl);
    if (baseUri == null || !baseUri.hasScheme) {
      return value;
    }

    final originUri = baseUri.replace(path: '/', query: null, fragment: null);
    final originPath = value.startsWith('/') ? value : '/$value';
    return originUri.resolve(originPath).toString();
  }
}

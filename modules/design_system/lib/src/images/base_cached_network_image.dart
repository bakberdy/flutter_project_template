import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseCachedNetworkImage extends StatelessWidget {
  const BaseCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.baseUrl,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  final String imageUrl;
  final String? baseUrl;
  final BoxFit? fit;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: resolveUrl(imageUrl, baseUrl: baseUrl),
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }

  static String resolveUrl(String imageUrl, {String? baseUrl}) {
    final value = imageUrl.trim();
    final imageUri = Uri.tryParse(value);
    if (imageUri != null && imageUri.hasScheme) {
      return value;
    }

    final base = baseUrl?.trim();
    if (base == null || base.isEmpty) {
      return value;
    }

    final baseUri = Uri.tryParse(base);
    if (baseUri == null || !baseUri.hasScheme) {
      return value;
    }

    final originUri = baseUri.replace(path: '/', query: null, fragment: null);
    final originPath = value.startsWith('/') ? value : '/$value';
    return originUri.resolve(originPath).toString();
  }
}

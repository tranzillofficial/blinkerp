// ignore_for_file: deprecated_member_use
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

class BrandVideo extends StatefulWidget {
  const BrandVideo({super.key, required this.asset, this.loop = false, this.size = 220});
  final String asset;
  final bool loop;
  final double size;
  @override
  State<BrandVideo> createState() => _BrandVideoState();
}

class _BrandVideoState extends State<BrandVideo> {
  static int _nextId = 0;
  late final String _viewType;
  late final html.VideoElement _video;
  @override
  void initState() {
    super.initState();
    _viewType = 'blink-video-${_nextId++}';
    _video = html.VideoElement()
      ..src = Uri.base.resolve('assets/${widget.asset}').toString()
      ..muted = true
      ..autoplay = true
      ..loop = widget.loop
      ..setAttribute('playsinline', '')
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'contain'
      ..style.pointerEvents = 'none';
    ui.platformViewRegistry.registerViewFactory(_viewType, (_) => _video);
    _video.play().catchError((_) {});
  }
  @override
  void dispose() {
    _video.pause();
    _video.removeAttribute('src');
    _video.load();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: widget.size,
        child: HtmlElementView(viewType: _viewType),
      );
}

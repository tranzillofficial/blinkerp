import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Clean native video player widget for brand animations (.webm, .mp4).
class BrandVideo extends StatefulWidget {
  const BrandVideo({
    super.key,
    required this.asset,
    this.loop = false,
    this.size = 320,
    this.onFinished,
  });

  final String asset;
  final bool loop;
  final double size;
  final VoidCallback? onFinished;

  @override
  State<BrandVideo> createState() => _BrandVideoState();
}

class _BrandVideoState extends State<BrandVideo> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _finishedCalled = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _onControllerUpdate() {
    if (!_finishedCalled &&
        _controller.value.isInitialized &&
        !_controller.value.isPlaying &&
        _controller.value.position >= _controller.value.duration) {
      _finishedCalled = true;
      widget.onFinished?.call();
    }
  }

  Future<void> _initPlayer() async {
    try {
      _controller = VideoPlayerController.asset(widget.asset);
      await _controller.initialize();
      await _controller.setLooping(widget.loop);
      _controller.addListener(_onControllerUpdate);

      if (mounted) {
        setState(() => _isInitialized = true);
        await _controller.play();
      }
    } catch (_) {
      // Fallback in case of driver/codec error
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted && !_finishedCalled) {
          _finishedCalled = true;
          widget.onFinished?.call();
        }
      });
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.removeListener(_onControllerUpdate);
      _controller.pause();
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return SizedBox.square(dimension: widget.size);
    }

    // Displays the video in its authentic, original colors (Dark Blue logo)
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}

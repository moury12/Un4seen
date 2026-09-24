import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:un4seen/src/core/theme/app_colors.dart';

class AnnouncementVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool hasMusic;
  final bool isSoundOn;
  final bool isPaused;

  const AnnouncementVideoPlayer({
    super.key,
    required this.videoUrl,
    this.hasMusic = false,
    this.isSoundOn = true,
    this.isPaused = false,
  });

  @override
  State<AnnouncementVideoPlayer> createState() =>
      _AnnouncementVideoPlayerState();
}

class _AnnouncementVideoPlayerState extends State<AnnouncementVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      await _controller.initialize();
      _controller.setLooping(true);

      _updateVolumeAndPlay();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint("AnnouncementVideoPlayer error: $e");
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _updateVolumeAndPlay() {
    if (!_isInitialized) return;

    // "j music ta attached korbe tar sound sunaio jodi sound na thake video r sound sunaio"
    if (widget.hasMusic) {
      _controller.setVolume(0.0); // Mute video so attached music plays
    } else {
      _controller.setVolume(widget.isSoundOn ? 1.0 : 0.0); // Play video sound
    }

    if (widget.isPaused) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  void didUpdateWidget(covariant AnnouncementVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      if (_isInitialized) {
        _controller.dispose();
        _isInitialized = false;
      }
      _initPlayer();
    } else {
      _updateVolumeAndPlay();
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.redAccent, size: 36),
              SizedBox(height: 8),
              Text(
                'Unable to play video',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.kPrimaryColor),
        ),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: _controller.value.size.width > 0
              ? _controller.value.size.width
              : 1080,
          height: _controller.value.size.height > 0
              ? _controller.value.size.height
              : 1920,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/stories/presentation/controllers/story_controller.dart';

/// Story canvas aspect ratio: standard 9:16 portrait.
const double _kStoryAspectRatio = 9 / 16;

/// A widget that renders a fixed 9:16 Story canvas.
///
/// The canvas:
/// - Wraps everything in a [RepaintBoundary] (keyed by [StoryController.storyCanvasKey])
///   so the exact composition can be rendered to a PNG at upload time.
/// - Clips the image to the canvas bounds so content outside is invisible.
/// - Handles pinch-to-zoom, drag-to-reposition, and two-finger rotation via
///   [GestureDetector]'s scale callbacks.
/// - Reads / writes [StoryController.storyScale], [storyOffsetX], [storyOffsetY],
///   and [storyRotation] — the single source of truth for transformation state.
///
/// Initial scale is computed once when the image changes, setting the image's
/// width equal to the canvas width (width-based fit) while preserving the
/// original aspect ratio. The member can then freely transform from there.
class StoryCanvasWidget extends StatefulWidget {
  const StoryCanvasWidget({super.key});

  @override
  State<StoryCanvasWidget> createState() => _StoryCanvasWidgetState();
}

class _StoryCanvasWidgetState extends State<StoryCanvasWidget> {
  final StoryController _ctrl = Get.find<StoryController>();

  // ── Gesture State ──────────────────────────────────────────────────────────
  double _gestureStartScale = 1.0;
  double _gestureStartRotation = 0.0;
  Offset _gestureStartOffset = Offset.zero;
  Offset _gestureStartFocalLocal = Offset.zero;

  // ── Scale limits ──────────────────────────────────────────────────────────
  double _minScale = 0.5;
  static const double _maxScale = 10.0;

  // ── Canvas size ────────────────────────────────────────────────────────────
  double _canvasWidth = 0;
  double _canvasHeight = 0;

  /// Path of the image we last initialised the scale for.
  String? _lastInitialisedImagePath;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final file = _ctrl.selectedImage.value;
      if (file == null) return const SizedBox.shrink();

      return LayoutBuilder(
        builder: (context, constraints) {
          // Determine canvas size from available width, keeping 9:16 ratio.
          _canvasWidth = constraints.maxWidth;
          _canvasHeight = _canvasWidth / _kStoryAspectRatio;

          // If the canvas would be taller than available height, constrain by height.
          if (constraints.maxHeight > 0 &&
              constraints.maxHeight < _canvasHeight) {
            _canvasHeight = constraints.maxHeight;
            _canvasWidth = _canvasHeight * _kStoryAspectRatio;
          }

          // Apply initial scale once per new image.
          if (_lastInitialisedImagePath != file.path) {
            _lastInitialisedImagePath = file.path;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _applyInitialScale(_ctrl.imageAspectRatio.value);
            });
          }

          return Center(
            child: SizedBox(
              width: _canvasWidth,
              height: _canvasHeight,
              child: _buildCanvas(file),
            ),
          );
        },
      );
    });
  }

  /// Sets [StoryController.storyScale] so that the image's logical width
  /// equals the canvas width (width-based fit).
  ///
  /// At scale == 1.0, the image is pre-sized to canvasWidth × canvasWidth/AR,
  /// so no additional initial scale adjustment is needed beyond 1.0.
  void _applyInitialScale(double imageAspectRatio) {
    _ctrl.storyScale.value = 1.0;
    _ctrl.storyOffsetX.value = 0.0;
    _ctrl.storyOffsetY.value = 0.0;
    _ctrl.storyRotation.value = 0.0;
    _minScale = 0.5;
  }

  Widget _buildCanvas(dynamic file) {
    // Logical image size at scale == 1.0:
    //   width  = canvasWidth (full width fit)
    //   height = canvasWidth / imageAspectRatio (maintains original AR)
    return Obx(() {
      final double imgAR = _ctrl.imageAspectRatio.value > 0
          ? _ctrl.imageAspectRatio.value
          : 1.0;
      final double imgLogicalWidth = _canvasWidth;
      final double imgLogicalHeight = _canvasWidth / imgAR;

      return RepaintBoundary(
        key: _ctrl.storyCanvasKey,
        child: GestureDetector(
          onScaleStart: _onScaleStart,
          onScaleUpdate: (details) =>
              _onScaleUpdate(details, imgLogicalWidth, imgLogicalHeight),
          onScaleEnd: _onScaleEnd,
          behavior: HitTestBehavior.opaque,
          child: ClipRect(
            child: SizedBox(
              width: _canvasWidth,
              height: _canvasHeight,
              child: Obx(() {
                final scale = _ctrl.storyScale.value;
                final rotation = _ctrl.storyRotation.value;
                final dx = _ctrl.storyOffsetX.value;
                final dy = _ctrl.storyOffsetY.value;

                return Stack(
                  children: [
                    // Dark canvas background.
                    Container(color: Colors.black),
                    // Transformed image.
                    Positioned.fill(
                      child: Transform(
                        // Translate to canvas centre, apply rotation and scale,
                        // then translate back by half the image logical size
                        // so the image is centred before any user offset.
                        transform: Matrix4.identity()
                          ..translateByDouble(
                            _canvasWidth / 2 + dx,
                            _canvasHeight / 2 + dy,
                            0,
                            1,
                          )
                          ..rotateZ(rotation)
                          ..scaleByDouble(scale, scale, 1.0, 1.0)
                          ..translateByDouble(
                            -imgLogicalWidth / 2,
                            -imgLogicalHeight / 2,
                            0,
                            1,
                          ),
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: imgLogicalWidth,
                          height: imgLogicalHeight,
                          child: Image.file(
                            file,
                            // BoxFit.fill stretches to the SizedBox, but since
                            // the SizedBox already has the correct AR, this is
                            // equivalent to filling the pre-computed AR box
                            // without distortion.
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.medium,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      );
    });
  }

  // ── Gesture Handlers ───────────────────────────────────────────────────────

  void _onScaleStart(ScaleStartDetails details) {
    _gestureStartScale = _ctrl.storyScale.value;
    _gestureStartRotation = _ctrl.storyRotation.value;
    _gestureStartOffset = Offset(
      _ctrl.storyOffsetX.value,
      _ctrl.storyOffsetY.value,
    );
    _gestureStartFocalLocal = details.localFocalPoint;
  }

  void _onScaleUpdate(
    ScaleUpdateDetails details,
    double imgLogicalWidth,
    double imgLogicalHeight,
  ) {
    // ── Scale ──────────────────────────────────────────────────────────────
    final double newScale = (_gestureStartScale * details.scale).clamp(
      _minScale,
      _maxScale,
    );
    _ctrl.storyScale.value = newScale;

    // ── Rotation ──────────────────────────────────────────────────────────
    // details.rotation is the cumulative rotation delta since gesture start.
    _ctrl.storyRotation.value = _gestureStartRotation + details.rotation;

    // ── Translation ────────────────────────────────────────────────────────
    final Offset focalDelta = details.localFocalPoint - _gestureStartFocalLocal;
    _ctrl.storyOffsetX.value = _gestureStartOffset.dx + focalDelta.dx;
    _ctrl.storyOffsetY.value = _gestureStartOffset.dy + focalDelta.dy;
  }

  void _onScaleEnd(ScaleEndDetails details) {
    // No snap-back — member controls exact framing.
  }
}

/// Utility: minimum scale to completely fill the canvas with this image.
/// Useful for computing a "fill" scale hint if needed.
double storyMinFillScale({
  required double canvasWidth,
  required double canvasHeight,
  required double imageAspectRatio,
}) {
  // Image logical size at scale 1.0: canvasWidth x (canvasWidth / imageAR)
  final double imgH = canvasWidth / imageAspectRatio;
  if (imgH >= canvasHeight) {
    // Image already fills vertically at scale 1.0.
    return 1.0;
  }
  // Scale needed to make image height == canvas height.
  return canvasHeight / imgH;
}

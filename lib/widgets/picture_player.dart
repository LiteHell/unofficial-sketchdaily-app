import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/widgets/get_cached_image.dart';

class PicturePlayer extends StatefulWidget {
  final Duration imageDuration;
  final Future<SketchDailyImage?> Function() getNextImage;
  final void Function(SketchDailyImage)? onCurrentImageChange;
  final bool infiniteDuration;
  final bool displayElapsedTime;
  final bool displayElapsedTimeOnInfinity;
  const PicturePlayer({
    super.key,
    required this.imageDuration,
    required this.getNextImage,
    required this.displayElapsedTime,
    required this.displayElapsedTimeOnInfinity,
    this.onCurrentImageChange,
    this.infiniteDuration = false,
  });

  @override
  State<PicturePlayer> createState() => _PicturePlayerState();
}

class _PicturePlayerState extends State<PicturePlayer> {
  List<SketchDailyImage> images = [];
  int index = -1;
  Timer? timer;
  Stopwatch stopwatch = Stopwatch();
  bool stopped = false;
  bool noMoreImages = false;
  String elapsedTimerString = '??:??';
  bool loadingImage = false;
  bool imageMirrored = false;
  File? currentCachedFile;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      onTimerTick();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  String formatDuration(Duration duration) {
    return '${duration.inMinutes.toString()}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Future<void> goNext() async {
    // Get next image index
    final nextIndex = index + 1;

    // If There's not enough images
    if (images.length <= nextIndex) {
      // Return if no more images available
      if (noMoreImages) return;

      // Get next image
      final image = await widget.getNextImage();
      if (image == null) {
        // If no more next image, set flag and return
        setState(() {
          noMoreImages = true;
        });
        return;
      } else {
        // If there's next image, add it.
        setState(() {
          images.add(image);
        });
      }
    }

    // Set Index and reset stopwatch
    setState(() {
      index = nextIndex;
    });
    fetchImage();
  }

  void goFirst() {
    if (images.isEmpty) return;
    setState(() {
      index = 0;
    });
    fetchImage();
  }

  void goPrev() {
    final prevIndex = index - 1;
    if (prevIndex < 0) return;

    setState(() {
      index = prevIndex;
    });
    fetchImage();
  }

  void goLast() {
    if (images.isEmpty) return;
    setState(() {
      index = images.length - 1;
    });
    fetchImage();
  }

  void toggleStopwatch() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }

    setState(() {
      stopped = !stopwatch.isRunning;
    });
  }

  void fetchImage() {
    setState(() {
      currentCachedFile = null;
      loadingImage = true;
    });
    stopwatch.stop();
    if (widget.onCurrentImageChange != null) {
      widget.onCurrentImageChange!(images[index]);
    }
    getCachedFile(
        url: images[index].uri.toString(), onCompleted: onImageFetched);
  }

  void onImageFetched(String cacheKey, FileInfo fileInfo) {
    if (!mounted || images[index].uri.toString() != cacheKey) {
      return;
    }
    setState(() {
      currentCachedFile = fileInfo.file;
      loadingImage = false;
    });
    stopwatch.reset();
    stopwatch.start();
  }

  void onTimerTick() async {
    if (!mounted) {
      // Skip when not mounted
      return;
    }

    if (index >= 0) {
      // Fetch next image if enough time is gone
      if (stopwatch.elapsed > widget.imageDuration &&
          !widget.infiniteDuration &&
          !stopped &&
          !loadingImage) {
        setState(() {
          elapsedTimerString = Messages.requestingNextImage;
        });
        await goNext();
      } else {
        if (currentCachedFile == null || loadingImage) {
          setState(() {
            elapsedTimerString = Messages.downloadingImage;
          });
        } else if (widget.infiniteDuration) {
          if (widget.displayElapsedTimeOnInfinity) {
            setState(() {
              elapsedTimerString = Messages.elapsedTimeInInfinityTimer(
                  formatDuration(stopwatch.elapsed));
            });
          } else {
            setState(() {
              elapsedTimerString = Messages.infinityTimer;
            });
          }
        } else {
          setState(() {
            Duration elapsed = stopwatch.elapsed;
            if (!widget.displayElapsedTime) {
              elapsed = widget.imageDuration - elapsed;
            }

            elapsedTimerString = formatDuration(elapsed);
          });
        }
      }
    } else {
      // Fetch first image
      await goNext();
    }
  }

  Widget cacheImageWidget() {
    final image = currentCachedFile;
    if (image != null) {
      final imageWidget = Image.file(
        image,
        fit: BoxFit.contain,
      );
      return imageMirrored
          ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: imageWidget)
          : imageWidget;
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const iconButtonSize = 20.0;
    const iconButtonPaddingSize = 8.0;
    const iconButtonPadding = EdgeInsets.all(iconButtonPaddingSize);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.timer_outlined),
          const SizedBox(width: 5),
          Text(elapsedTimerString)
        ]),
        Flexible(
            flex: 1,
            child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if ((details.primaryVelocity ?? 0) > 0) {
                    goPrev();
                  } else if ((details.primaryVelocity ?? 0) < 0) {
                    goNext();
                  }
                },
                child: (index < 0
                    ? (noMoreImages
                        ? Center(child: Text(Messages.noMoreImages))
                        : const Center(child: CircularProgressIndicator()))
                    : cacheImageWidget()))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: goFirst,
                iconSize: iconButtonSize,
                padding: iconButtonPadding,
                tooltip: Messages.goFirst,
                icon: const Icon(
                  Icons.keyboard_double_arrow_left,
                )),
            IconButton(
                onPressed: goPrev,
                iconSize: iconButtonSize,
                padding: iconButtonPadding,
                tooltip: Messages.goPrev,
                icon: const Icon(Icons.chevron_left)),
            IconButton(
                onPressed: toggleStopwatch,
                iconSize: iconButtonSize,
                padding: iconButtonPadding,
                tooltip: stopped ? Messages.resume : Messages.pause,
                icon: stopped
                    ? const Icon(Icons.play_arrow)
                    : const Icon(Icons.pause)),
            IconButton(
                onPressed: goNext,
                iconSize: iconButtonSize,
                padding: iconButtonPadding,
                tooltip: Messages.goNext,
                icon: const Icon(Icons.chevron_right)),
            IconButton(
                onPressed: goLast,
                iconSize: iconButtonSize,
                padding: iconButtonPadding,
                tooltip: Messages.goLast,
                icon: const Icon(Icons.keyboard_double_arrow_right)),
            IconButton(
                onPressed: () {
                  setState(() {
                    imageMirrored = !imageMirrored;
                  });
                },
                iconSize: iconButtonSize,
                padding: iconButtonPadding,
                tooltip: Messages.horizontalFlip,
                icon: const Icon(Icons.flip))
          ]
              .map((i) => SizedBox(
                    width: iconButtonSize + iconButtonPaddingSize * 2,
                    height: iconButtonSize + iconButtonPaddingSize * 2,
                    child: i,
                  ))
              .toList(),
        )
      ],
    );
  }
}

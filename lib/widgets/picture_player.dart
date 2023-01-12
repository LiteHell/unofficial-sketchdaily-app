import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';

class PicturePlayer extends StatefulWidget {
  final Duration imageDuration;
  final Future<SketchDailyImage?> Function() getNextImage;
  final bool infiniteDuration;
  const PicturePlayer({
    super.key,
    required this.imageDuration,
    required this.getNextImage,
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
    return '${duration.inMinutes.toString()}:${duration.inSeconds.toString().padLeft(2, '0')}';
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
    stopwatch.reset();
    stopwatch.start();
  }

  void goFirst() {
    if (images.isEmpty) return;
    setState(() {
      index = 0;
    });
    stopwatch.reset();
    stopwatch.start();
  }

  void goPrev() {
    final prevIndex = index - 1;
    if (prevIndex < 0) return;

    setState(() {
      index = prevIndex;
    });
    stopwatch.reset();
    stopwatch.start();
  }

  void goLast() {
    if (images.isEmpty) return;
    setState(() {
      index = images.length - 1;
    });
    stopwatch.reset();
    stopwatch.start();
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

  void onTimerTick() async {
    if (!mounted) {
      // Skip when not mounted
      return;
    }

    if (index >= 0) {
      // Fetch next image if enough time is gone
      if (stopwatch.elapsed > widget.imageDuration &&
          !widget.infiniteDuration &&
          !stopped) {
        setState(() {
          elapsedTimerString = 'Loading...';
        });
        await goNext();
      } else {
        if (widget.infiniteDuration) {
          setState(() {
            elapsedTimerString = 'Infinite';
          });
        } else {
          setState(() {
            elapsedTimerString = formatDuration(stopwatch.elapsed);
          });
        }
      }
    } else {
      // Fetch first image
      await goNext();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: index < 0
                ? (noMoreImages
                    ? const Center(child: Text('no more images'))
                    : const Center(child: CircularProgressIndicator()))
                : Image.network(
                    images[index].uri.toString(),
                    fit: BoxFit.contain,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: goFirst,
                icon: const Icon(Icons.keyboard_double_arrow_left)),
            IconButton(onPressed: goPrev, icon: const Icon(Icons.chevron_left)),
            IconButton(
                onPressed: toggleStopwatch,
                icon: stopped
                    ? const Icon(Icons.play_arrow)
                    : const Icon(Icons.pause)),
            IconButton(
                onPressed: goNext, icon: const Icon(Icons.chevron_right)),
            IconButton(
                onPressed: goLast,
                icon: const Icon(Icons.keyboard_double_arrow_right)),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maple/widgets/maple-scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../utils/colors.dart';

class FullscreenPlayer extends StatefulWidget {
  final String ytUrl;
  final startAt;
  const FullscreenPlayer({Key? key, required this.ytUrl, this.startAt})
      : super(key: key);

  @override
  State<FullscreenPlayer> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  YoutubePlayerController? playerController;

  int currentTime = 0;

  @override
  void initState() {
    print(widget.startAt);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    playerController = YoutubePlayerController(
        initialVideoId: widget.ytUrl,
        flags: YoutubePlayerFlags(
            startAt: widget.startAt,
            autoPlay: true,
            controlsVisibleAtStart: false));
    playerController?.addListener(() {
      currentTime = playerController?.value.position.inSeconds ?? 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MapleScaffold(
        isUsingAppbar: false,
        body: YoutubePlayer(
          controller: playerController!,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
              playedColor: MapleColor.indigo, handleColor: MapleColor.indigo),
          bottomActions: [
            const SizedBox(width: 14.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                  playedColor: MapleColor.indigo,
                  handleColor: MapleColor.indigo),
            ),
            RemainingDuration(),
            IconButton(
              onPressed: () => Navigator.pop(
                  context, currentTime),
              icon: Icon(
                Icons.fullscreen_exit,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}

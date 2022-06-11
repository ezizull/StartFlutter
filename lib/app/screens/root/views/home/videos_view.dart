import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideosView extends StatefulWidget {
  List videos = [];
  VideosView({Key? key, this.videos = const []}) : super(key: key);

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  @override
  Widget build(BuildContext context) {
    // double sheight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            children: widget.videos.map((video) {
          // print(double.parse(video["video_files"][2]["height"]).runtimeType);
          int inth = video["video_files"][2]["height"];
          double height = inth.toDouble();

          int intw = video["video_files"][2]["width"];
          double width = intw.toDouble();

          return Container(
              width: 170,
              margin: EdgeInsets.only(
                  bottom: widget.videos.indexOf(video) % 2 == 0 ? 0 : 15),
              child: widget.videos.indexOf(video) % 2 == 0
                  ? null
                  : VideoPlay(
                      video: video["video_files"][0]["link"],
                      image: video["image"].toString(),
                      height: height,
                      width: width,
                    ));
        }).toList()),
        Column(
            children: widget.videos.map((video) {
          int inth = video["video_files"][2]["height"];
          double height = inth.toDouble();

          int intw = video["video_files"][2]["width"];
          double width = intw.toDouble();

          return Container(
              width: 170,
              margin: EdgeInsets.only(
                  bottom: widget.videos.indexOf(video) % 2 == 0 ? 15 : 0),
              child: widget.videos.indexOf(video) % 2 == 0
                  ? VideoPlay(
                      video: video["video_files"][2]["link"],
                      image: video["image"].toString(),
                      height: height,
                      width: width,
                    )
                  : null);
        }).toList()),
      ],
    );
  }
}

class VideoPlay extends StatefulWidget {
  String? video;
  String image;
  double height;
  double width;

  VideoPlay({
    Key? key,
    this.video,
    this.width = 170,
    this.image = "null",
    this.height = 95.63,
  }) : super(key: key);

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController videoController;
  late Future<void> futureController;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  loadVideo() {
    videoController = VideoPlayerController.network(widget.video!)
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize()
      ..play().then((_) => {
            isPlaying = !isPlaying,
          });
  }

  @override
  void dispose() {
    super.dispose();
    if (!mounted) {
      videoController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (mounted) {
              setState(() {
                loadVideo();
              });
            }
          },
          child: SizedBox(
            width: 170,
            height: widget.height < 420 ? widget.height : widget.height / 10,
            child: isPlaying
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(swidth / 50),
                    child: VideoPlayer(
                      videoController,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(swidth / 50),
                      image: widget.image != "null"
                          ? DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image:
                                  AssetImage('assets/images/bumi_masker.png'),
                              fit: BoxFit.cover),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

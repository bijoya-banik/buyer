
//import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import '../ProductDetails.dart';

class PortraitVideoImageContainer extends StatefulWidget {
  final index;
  PortraitVideoImageContainer(this.index);
  @override
  _PortraitVideoImageContainerState createState() =>
      _PortraitVideoImageContainerState();
}

class _PortraitVideoImageContainerState extends State<PortraitVideoImageContainer> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  //ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    //  // 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    // ..initialize().then((_) {
    //   // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //   setState(() {});
    // });
//_initializeVideoPlayerFuture = _controller.initialize();
    //_controller.setLooping(true);
    // _chewieController = ChewieController(
    //   videoPlayerController: _controller,
    //   //fullScreenByDefault: true,
    //   aspectRatio: 2/1,
    //   autoPlay: false,
    //   looping: false,
    // //   deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitDown],
    //  // customControls: Container(height: 50,color: Colors.red,),
    // //systemOverlaysAfterFullScreen: [SystemUiOverlay.bottom],

    //   // Try playing around with some of these other options:

    //   // showControls: false,
    //   materialProgressColors: ChewieProgressColors(
    //     playedColor: appTealColor,
    //     handleColor: appTealColor,
    //     backgroundColor: Colors.grey,
    //     bufferedColor: Color(0XFF989898),
    //   ),
    //   // placeholder: Container(
    //   //   color: Colors.grey,
    //   // ),
    //   autoInitialize: true,
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    //_chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //height: 300,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ProductsDetailsPage()),
          // );
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Container(
            //height: 260,
            width: MediaQuery.of(context).size.width,
            //margin: EdgeInsets.all(5),
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
            //     color: Colors.white,
            //     border: Border.all(width: 0.2, color: Colors.grey)),
            // child: FutureBuilder(
            //     future: _initializeVideoPlayerFuture,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            // child: _controller.value.initialized
            //     ? AspectRatio(
            //         aspectRatio: _controller.value.aspectRatio,
            //         child: VideoPlayer(_controller),
            //       )
            //     : Container(),
            //   // } else {
            //   //   return Center(child: CircularProgressIndicator());
            //   // }
            // //}
            // //),
            // child: Chewie(
            //   controller: _chewieController,
            // ),
          ),
        ),
      ),
    );
  }
}

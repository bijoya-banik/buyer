//import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import '../ProductDetails.dart';

class LandscapeVideoImageContainer extends StatefulWidget {
  final index;
  LandscapeVideoImageContainer(this.index);

  @override
  _LandscapeVideoImageContainerState createState() =>
      _LandscapeVideoImageContainerState();
}

class _LandscapeVideoImageContainerState
    extends State<LandscapeVideoImageContainer> {
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
    //   aspectRatio: 3 / 2,
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
          title: Column(
            children: <Widget>[
              /////////   Video Containner   ////////
              Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      //height: 300,
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
                    // Container(
                    //   height: 200,
                    //   width: MediaQuery.of(context).size.width,
                    //   //color: Colors.blue,
                    //   child: IconButton(
                    //     alignment: Alignment.center,
                    //     padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    //     icon: Icon(
                    //         _controller.value.isPlaying
                    //             ? Icons.pause
                    //             : Icons.play_arrow,
                    //         size: 100,
                    //         color: Colors.red.withOpacity(0.7)),
                    //     onPressed: () {
                    //       setState(() {
                    //         _controller.value.isPlaying
                    //             ? _controller.pause()
                    //             : _controller.play();
                    //         print('play\pause');
                    //       });
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),

              //////    Image Container   ////////
              // Container(
              //   height: 300,
              //   width: MediaQuery.of(context).size.width,
              //   margin: EdgeInsets.all(5),
              //   //margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //       color: Colors.white,
              //       border: Border.all(width: 0.2, color: Colors.grey)),
              //   child: Container(
              //     // margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(15.0)),
              //         color: Colors.white,
              //         border: Border.all(width: 0.2, color: Colors.grey)),
              //     child: Image.asset(
              //       'assets/images/product_1.jpg',
              //       height: 300,
              //       width: MediaQuery.of(context).size.width,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

//   TargetPlatform _platform;
//   VideoPlayerController _videoPlayerController1;
//   VideoPlayerController _videoPlayerController2;
//   ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController1 = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
//     _videoPlayerController2 = VideoPlayerController.network(
//         'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController1,
//       aspectRatio: 3 / 2,
//       autoPlay: true,
//       looping: true,
//       // Try playing around with some of these other options:

//       // showControls: false,
//       // materialProgressColors: ChewieProgressColors(
//       //   playedColor: Colors.red,
//       //   handleColor: Colors.blue,
//       //   backgroundColor: Colors.grey,
//       //   bufferedColor: Colors.lightGreen,
//       // ),
//       // placeholder: Container(
//       //   color: Colors.grey,
//       // ),
//       // autoInitialize: true,
//     );
//   }

//   @override
//   void dispose() {
//     _videoPlayerController1.dispose();
//     _videoPlayerController2.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('widget.title'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: Center(
//                 child: Chewie(
//                   controller: _chewieController,
//                 ),
//               ),
//             ),
//             FlatButton(
//               onPressed: () {
//                 _chewieController.enterFullScreen();
//               },
//               child: Text('Fullscreen'),
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: FlatButton(
//                     onPressed: () {
//                       setState(() {
//                         _chewieController.dispose();
//                         _videoPlayerController2.pause();
//                         _videoPlayerController2.seekTo(Duration(seconds: 0));
//                         _chewieController = ChewieController(
//                           videoPlayerController: _videoPlayerController1,
//                           aspectRatio: 3 / 2,
//                           autoPlay: true,
//                           looping: true,
//                         );
//                       });
//                     },
//                     child: Padding(
//                       child: Text("Video 1"),
//                       padding: EdgeInsets.symmetric(vertical: 16.0),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: FlatButton(
//                     onPressed: () {
//                       setState(() {
//                         _chewieController.dispose();
//                         _videoPlayerController1.pause();
//                         _videoPlayerController1.seekTo(Duration(seconds: 0));
//                         _chewieController = ChewieController(
//                           videoPlayerController: _videoPlayerController2,
//                           aspectRatio: 3 / 2,
//                           autoPlay: true,
//                           looping: true,
//                         );
//                       });
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16.0),
//                       child: Text("Error Video"),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: FlatButton(
//                     onPressed: () {
//                       setState(() {
//                         _platform = TargetPlatform.android;
//                       });
//                     },
//                     child: Padding(
//                       child: Text("Android controls"),
//                       padding: EdgeInsets.symmetric(vertical: 16.0),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: FlatButton(
//                     onPressed: () {
//                       setState(() {
//                         _platform = TargetPlatform.iOS;
//                       });
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16.0),
//                       child: Text("iOS controls"),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),

//     );
//   }
// }

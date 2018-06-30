import 'package:flutter/material.dart';
import 'package:flutter_tinder_app/common/selected_photo_indicator.dart';

class PhotoBrowser extends StatefulWidget {
  final List<String> assetPaths;
  final int visiblePhotoIndex;

  PhotoBrowser({
    this.assetPaths,
    this.visiblePhotoIndex = 0
  });

  @override
  _PhotoBrowserState createState() => _PhotoBrowserState();
}

class _PhotoBrowserState extends State<PhotoBrowser> {
  int visiblePhotoIndex;

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Photo
        new Image.asset(
          widget.assetPaths[visiblePhotoIndex],
          fit: BoxFit.cover,
        ),


        // Photo indicator
        new Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: new SelectedPhotoIndicator(
            photosCount: widget.assetPaths.length,
            currentIndex: visiblePhotoIndex
          ),
        ),

        // Photo controls
        _buildPhotoControls()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    visiblePhotoIndex = widget.visiblePhotoIndex;
  }

  @override
  void didUpdateWidget(PhotoBrowser oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.visiblePhotoIndex != oldWidget.visiblePhotoIndex) {
      setState(() {
        visiblePhotoIndex = widget.visiblePhotoIndex;
      });
    }
  }

  _prevImage() {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex > 0 ? visiblePhotoIndex - 1 : 0;
    });
  }

  _nextImage() {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex < widget.assetPaths.length - 1 ? visiblePhotoIndex + 1 : widget.assetPaths.length - 1;
    });
  }

  Widget _buildPhotoControls() {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new GestureDetector(
          onTap: _prevImage,
          child: new FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topLeft,
            child: new Container(
              color: Colors.transparent,
            ),
          ),
        ),
        new GestureDetector(
          onTap: _nextImage,
          child: new FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topRight,
            child: new Container(
              color: Colors.transparent,
            ),
          ),
        )
      ],
    );
  }
}


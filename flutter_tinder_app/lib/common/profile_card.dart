

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tinder_app/common/photo_browser.dart';
import 'package:fluttery/layout.dart';

class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

  Widget _buildBackground() {
    return new PhotoBrowser(
      assetPaths:[
        'resources/images/photo_1.jpg',
        'resources/images/photo_2.jpg',
        'resources/images/photo_3.jpg',
        'resources/images/photo_4.jpg',
      ]
    );
  }

  Widget _buildProfileThumbnail() {
    return new Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ]
          )
        ),
        padding: const EdgeInsets.all(24.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
                      'Name',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 24.0
                      ),
                    ),
                    new Text(
                      'Description',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                      ),
                    ),
                  ],
                )
            ),
            new Icon(
              Icons.info,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 2.0,
            color: const Color(0x110000000),
          )

        ],
      ),
      child: new ClipRRect(
        borderRadius: new BorderRadius.circular(10.0),
        child: new Material(
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildBackground(),
              _buildProfileThumbnail()
            ],
          ),
        ),
      ),
    );
  }
}


class DragableCard extends StatefulWidget {
  @override
  _DragableCardState createState() => _DragableCardState();
}

class _DragableCardState extends State<DragableCard> {
  Offset _cardOffset = const Offset(0.0, 0.0);
  Offset _dragStart;
  Offset _dragPosition;

  _onPanStart(DragStartDetails details) {
    _dragStart = details.globalPosition;
  }

  _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition = details.globalPosition;
      _cardOffset = _dragPosition - _dragStart;
    });
  }

  _onPanEnd(DragEndDetails details) {
    setState(() {
      _dragStart = null;
      _dragPosition = null;
      _cardOffset = const Offset(0.0, 0.0);
    });
  }

  Offset _rotationOrigin(Rect dragBounds) {
    if (_dragStart != null) {
      return _dragStart - dragBounds.topLeft;
    } else {
      return const Offset(0.0, 0.0);
    }
  }

  double _rotation(Rect dragBounds) {
    if (_dragStart != null) {
      return (pi/8) * (_cardOffset.dx / dragBounds.width);
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AnchoredOverlay(
        child: new Center(),
        showOverlay: true,
        overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor) {
          return new CenterAbout(
            position: anchor,
            child: new Transform(
              transform: new Matrix4.translationValues(_cardOffset.dx, _cardOffset.dy, 0.0)
              ..rotateZ(_rotation(anchorBounds)),
              origin: _rotationOrigin(anchorBounds),
              child: new Container(
                width: anchorBounds.width,
                height: anchorBounds.height,
                padding: const EdgeInsets.all(16.0),
                child: new GestureDetector(
                    child: new ProfileCard(),
                  onPanStart: _onPanStart,
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                ),
              ),
            ),
          );
        }
    );
  }
}



import 'dart:math';
import 'matches.dart';

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
  final DateMatch match;

  DragableCard({
    this.match
  });

  @override
  _DragableCardState createState() => _DragableCardState();
}

class _DragableCardState extends State<DragableCard> with TickerProviderStateMixin {
  Offset _cardOffset = const Offset(0.0, 0.0);
  Offset _dragStart;
  Offset _dragPosition;
  Offset _slideBackStart;
  AnimationController _slideBackAnimation;
  Tween<Offset> _slideOutTween;
  AnimationController _slideOutAnimation;
  Decision decision;
  GlobalKey profileCardKey = new GlobalKey(debugLabel: 'profile_card_key');

  @override
  void initState() {
    super.initState();
    _slideBackAnimation = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
    ..addListener((() => setState(() {
      _cardOffset = Offset.lerp(_slideBackStart, const Offset(0.0, 0.0), Curves.elasticOut.transform(_slideBackAnimation.value));
    })))
    ..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
           _dragStart = null;
           _slideBackStart = null;
          _dragPosition = null; 
        });
      }
    });


    _slideOutAnimation = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
    ..addListener(() {
      setState(() {
        _cardOffset = _slideOutTween.evaluate(_slideOutAnimation);
      });
    })
    ..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
          setState(() {
            _dragStart = null;
            _slideOutTween = null;
            _dragPosition = null;
            _cardOffset = const Offset(0.0, 0.0);
          });
      }
    });

    widget.match.addListener(_onMatchChange);
    decision = widget.match.decision;
  }


  @override
  void didUpdateWidget(DragableCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.match != oldWidget.match) {
      oldWidget.match.removeListener(this._onMatchChange);
      widget.match.addListener(this._onMatchChange);
    }
  }


  @override
  void dispose() {
    widget.match.removeListener(_onMatchChange);
    _slideBackAnimation.dispose();
    super.dispose();
  }

  void _onMatchChange() {
    if (widget.match.decision != this.decision) {
      switch (widget.match.decision) {
        case Decision.nope:
          _slideLeft();
          break;
        case Decision.like:
          _slideRight();
          break;
        case Decision.superLike:
          _slideUp();
          break;
        default:
          break;
      }
    }
  }



  Offset _chooseRandomDragStart() {
    final cardContext = profileCardKey.currentContext;
    final cardTopLeft = ((cardContext.findRenderObject()) as RenderBox).localToGlobal(const Offset(0.0, 0.0));
    final dragStartY = cardContext.size.height * (new Random().nextDouble() < 0.5 ? 0.25: 0.75) + cardTopLeft.dy;


    return new Offset(cardContext.size.width/2 + cardTopLeft.dx, dragStartY);
  }

  _slideLeft() {
    final screenWidth = context.size.width;
    _dragStart = _chooseRandomDragStart();
    _slideOutTween = new Tween(begin: const Offset(0.0, 0.0), end: new Offset(-2*screenWidth, 0.0));
    _slideOutAnimation.forward(from: 0.0);
  }

  _slideRight() {
    final screenWidth = context.size.width;
    _dragStart = _chooseRandomDragStart();
    _slideOutTween = new Tween(begin: const Offset(0.0, 0.0), end: new Offset(2*screenWidth, 0.0));
    _slideOutAnimation.forward(from: 0.0);
  }

  _slideUp() {
    final screenHeight = context.size.height;
    _dragStart = _chooseRandomDragStart();
    _slideOutTween = new Tween(begin: const Offset(0.0, 0.0), end: new Offset(0.0, -2*screenHeight));
    _slideOutAnimation.forward(from: 0.0);
  }

  _onPanStart(DragStartDetails details) {
    _dragStart = details.globalPosition;

    if (_slideBackAnimation.isAnimating) {
      _slideBackAnimation.stop(canceled: true);
    }
  }

  _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition = details.globalPosition;
      _cardOffset = _dragPosition - _dragStart;
    });
  }

  _onPanEnd(DragEndDetails details) {
    final dragVector = _cardOffset/_cardOffset.distance;
    final isInDislikeRegion = (_cardOffset.dx / context.size.width) < -0.45;
    final isInLikeRegion = (_cardOffset.dx / context.size.width) > 0.45;
    final isInSuperLikeRegion = (_cardOffset.dy / context.size.height) < -0.4;

    setState(() {
      if (isInDislikeRegion || isInLikeRegion) {
        _slideOutTween = new Tween(begin: _cardOffset, end: dragVector * (2*context.size.width));
        _slideOutAnimation.forward(from: 0.0);
      } else if (isInSuperLikeRegion) {
        _slideOutTween = new Tween(begin: _cardOffset, end: dragVector * (2*context.size.height));
        _slideOutAnimation.forward(from: 0.0);
      } else {
        _slideBackStart = _cardOffset;
        _slideBackAnimation.forward(from: 0.0);
      }
    });

    _slideBackStart = _cardOffset;
    _slideBackAnimation.forward(from: 0.0);
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
      final rotationMultiplierCorner = _dragStart.dy >= dragBounds.top + (dragBounds.height/2.0) ? -1 : 1;
      return (pi/8) * (_cardOffset.dx / dragBounds.width) * rotationMultiplierCorner;
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

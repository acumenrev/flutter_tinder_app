import 'package:flutter/material.dart';

class SelectedPhotoIndicator extends StatelessWidget {
  final int photosCount;
  final int currentIndex;

  SelectedPhotoIndicator({
    this.photosCount,
    this.currentIndex
  });

  Widget _buildInactiveIndicator() {
    return new Expanded(
        child: new Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 2.0
            ),
          child: new Container(
            height: 3.0,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(2.5),
              color: Colors.black.withOpacity(0.2),

            ),
          ),
        ) 
    );
  }

  Widget _buildActiveIndicator() {
    return new Expanded(
        child: new Padding(
          padding: const EdgeInsets.only(
              left: 2.0, right: 2.0
          ),
          child: new Container(
            height: 3.0,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(2.5),
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                  spreadRadius: 0.0,
                  blurRadius: 2.0,
                  offset: const Offset(0.0, 1.0),
                  color: const Color(0x22000000),
                )
              ]
            ),

          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: _buildIndicators(),
      )
    );
  }
  
  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    
    for (int i = 0; i < this.photosCount; i++) {
      indicators.add(
          this.currentIndex == i ? _buildActiveIndicator() : _buildInactiveIndicator()
      );
    }
    
    return indicators;
  }
}

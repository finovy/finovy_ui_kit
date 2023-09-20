import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double? rating);

class FNRate extends StatefulWidget {
  final EdgeInsets? margin;
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRated;
  final double size;
  final bool allowHalfRating;
  final Widget? filledIcon;
  final Widget? nonFilledIcon;
  final double spacing;
  final bool isReadOnly;
  const FNRate({
    super.key,
    this.margin,
    this.starCount = 5,
    this.isReadOnly = true,
    this.spacing = 0.0,
    this.rating = 0.0,
    this.onRated,
    this.size = 25,
    this.allowHalfRating = true,
    this.filledIcon,
    this.nonFilledIcon,
  });
  @override
  FNRateState createState() => FNRateState();
}

class FNRateState extends State<FNRate> {
  final double halfStarThreshold =
      0.53; //half star value starts from this number

  //tracks for user tapping on this widget
  bool isWidgetTapped = false;
  double? currentRating;
  Timer? debounceTimer;
  @override
  void initState() {
    currentRating = widget.rating;
    super.initState();
  }

  @override
  void dispose() {
    debounceTimer?.cancel();
    debounceTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: widget.margin,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: widget.spacing,
          children: List.generate(
              widget.starCount, (index) => buildStar(context, index)),
        ),
      ),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Widget icon;
    if (index >= currentRating!) {
      icon = widget.nonFilledIcon ?? _buildDefaultIcon(Color(0xffB0B0B0));
    } else if (index >
            currentRating! -
                (widget.allowHalfRating ? halfStarThreshold : 1.0) &&
        index < currentRating!) {
      icon = Stack(
        children: [
          widget.nonFilledIcon ?? _buildDefaultIcon(Color(0xffB0B0B0)),
          ClipPath(
            clipBehavior: Clip.hardEdge,
            clipper: HalfClipper(),
            child: widget.filledIcon ?? _buildDefaultIcon(Color(0xffFFBF1C)),
          ),
        ],
      );
    } else {
      icon = widget.filledIcon ?? _buildDefaultIcon(Color(0xffFFBF1C));
    }
    final Widget star = widget.isReadOnly
        ? icon
        : kIsWeb
            ? MouseRegion(
                onExit: (event) {
                  if (widget.onRated != null && !isWidgetTapped) {
                    //reset to zero only if rating is not set by user
                    setState(() {
                      currentRating = 0;
                    });
                  }
                },
                onEnter: (event) {
                  isWidgetTapped = false; //reset
                },
                onHover: (event) {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  var _pos = box.globalToLocal(event.position);
                  final _rate = calculateRateFromOffset(_pos.dx);
                  if (_rate == null) return;
                  var newRating =
                      widget.allowHalfRating ? _rate : _rate.ceil().toDouble();
                  if (_rate < 0.2) newRating = 0;
                  if (newRating > widget.starCount) {
                    newRating = widget.starCount.toDouble();
                  }
                  if (newRating < 0) {
                    newRating = 0.0;
                  }
                  setState(() {
                    currentRating = newRating;
                  });
                },
                child: GestureDetector(
                  onTapDown: (detail) {
                    isWidgetTapped = true;

                    RenderBox box = context.findRenderObject() as RenderBox;
                    var _pos = box.globalToLocal(detail.globalPosition);
                    var _rate =
                        ((_pos.dx - index * widget.spacing) / widget.size);
                    var newRating = widget.allowHalfRating
                        ? _rate
                        : _rate.ceil().toDouble();
                    if (_rate < 0.2) newRating = 0;
                    if (newRating > widget.starCount) {
                      newRating = widget.starCount.toDouble();
                    }
                    if (newRating < 0) {
                      newRating = 0.0;
                    }
                    setState(() {
                      currentRating = newRating;
                    });
                    if (widget.onRated != null) {
                      widget.onRated!(normalizeRating(currentRating!));
                    }
                  },
                  onHorizontalDragUpdate: (dragDetails) {
                    isWidgetTapped = true;

                    RenderBox box = context.findRenderObject() as RenderBox;
                    var _pos = box.globalToLocal(dragDetails.globalPosition);
                    final _rate = calculateRateFromOffset(_pos.dx);
                    if (_rate == null) return;
                    var newRating = widget.allowHalfRating
                        ? _rate
                        : _rate.ceil().toDouble();
                    if (_rate < 0.2) newRating = 0;
                    if (newRating > widget.starCount) {
                      newRating = widget.starCount.toDouble();
                    }
                    if (newRating < 0) {
                      newRating = 0.0;
                    }
                    setState(() {
                      currentRating = newRating;
                    });
                    debounceTimer?.cancel();
                    debounceTimer = Timer(Duration(milliseconds: 100), () {
                      if (widget.onRated != null) {
                        currentRating = normalizeRating(newRating);
                        widget.onRated!(currentRating);
                      }
                    });
                  },
                  child: icon,
                ),
              )
            : GestureDetector(
                onTapDown: (detail) {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  var _pos = box.globalToLocal(detail.globalPosition);
                  var i = ((_pos.dx - index * widget.spacing) / widget.size);
                  var newRating =
                      widget.allowHalfRating ? i : i.ceil().toDouble();
                  if (i < 0.2) newRating = 0;
                  if (newRating > widget.starCount) {
                    newRating = widget.starCount.toDouble();
                  }
                  if (newRating < 0) {
                    newRating = 0.0;
                  }
                  newRating = normalizeRating(newRating);
                  print("newrating is $newRating");
                  setState(() {
                    currentRating = newRating;
                  });
                },
                onTapUp: (e) {
                  if (widget.onRated != null) widget.onRated!(currentRating);
                },
                onHorizontalDragUpdate: (dragDetails) {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  var _pos = box.globalToLocal(dragDetails.globalPosition);
                  final _rate = calculateRateFromOffset(_pos.dx);
                  if (_rate == null) return;
                  var newRating =
                      widget.allowHalfRating ? _rate : _rate.ceil().toDouble();
                  if (_rate < 0.2) newRating = 0;
                  if (newRating > widget.starCount) {
                    newRating = widget.starCount.toDouble();
                  }
                  if (newRating < 0) {
                    newRating = 0.0;
                  }
                  setState(() {
                    currentRating = newRating;
                  });
                  debounceTimer?.cancel();
                  debounceTimer = Timer(Duration(milliseconds: 100), () {
                    if (widget.onRated != null) {
                      currentRating = normalizeRating(newRating);
                      widget.onRated!(currentRating);
                    }
                  });
                },
                child: icon,
              );

    return star;
  }

  double? calculateRateFromOffset(double dx) {
    int? starIndex;
    for (int i = 0; i < widget.starCount; i++) {
      double starBegin = i * widget.spacing + i * widget.size;
      double starEnd = i * widget.spacing + (i + 1) * widget.size;
      if (dx >= starBegin && dx <= starEnd) {
        starIndex = i;
      }
    }
    if (starIndex != null) {
      var rate = (dx - starIndex * widget.spacing) / widget.size;
      return rate;
    }
    return null;
  }

  double normalizeRating(double newRating) {
    var k = newRating - newRating.floor();
    if (k != 0) {
      //half stars
      if (k >= halfStarThreshold) {
        newRating = newRating.floor() + 1.0;
      } else {
        newRating = newRating.floor() + 0.5;
      }
    }
    return newRating;
  }

  Widget _buildDefaultIcon(Color color) {
    return Icon(
      Icons.star,
      size: widget.size,
      color: color,
    );
  }
}

class HalfClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    final height = size.height;
    final width = size.width;
    path.lineTo(0, height);
    path.lineTo(width / 2, height);
    path.lineTo(width / 2, 0);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

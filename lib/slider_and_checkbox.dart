library slider_and_checkbox;

import 'dart:async';

/// A Calculator.import 'dart:async';
import 'package:animate_ease/animate_ease.dart';
import 'package:animate_ease/animate_ease_type.dart';
import 'package:flutter/material.dart';
import 'package:slider_and_checkbox/content_details.dart';
import 'package:slider_and_checkbox/image_model.dart';

class SliderAndCheckbox extends StatefulWidget {
  final List<ImageModel> images;
  final bool autoScroll;
  final bool showControls;
  final bool showOverlayText;
  final Color overlayTextColor;
  final double overlayTextSize;
  final FontWeight overlayTextWeight;
  final bool showThumbnails;
  final double imageBorderRadius;
  final double controlsSize;
  final double controlsPadding;
  final Color controlsColor;
  final double thumbnailSize;
  final double thumbnailBorderRadius;
  final double thumbnailPadding;
  final Duration animationDuration;
  final bool isOverlaySlider;
  final AnimateEaseType subTitleAnimationType;
  final AnimateEaseType titleAnimationType;
  final AnimateEaseType imageAnimationType;
  final AnimateEaseType thumbnailAnimationType;

  const SliderAndCheckbox({
    super.key,
    required this.images,
    this.autoScroll = false,
    this.showControls = true,
    this.showOverlayText = true,
    this.overlayTextColor = Colors.white,
    this.overlayTextSize = 16.0,
    this.overlayTextWeight = FontWeight.normal,
    this.showThumbnails = true,
    this.imageBorderRadius = 0.0,
    this.controlsSize = 30.0,
    this.controlsPadding = 8.0,
    this.controlsColor = Colors.white,
    this.thumbnailSize = 60.0,
    this.thumbnailBorderRadius = 0.0,
    this.thumbnailPadding = 4.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.isOverlaySlider = false,
    this.subTitleAnimationType = AnimateEaseType.slideInBottom,
    this.titleAnimationType = AnimateEaseType.slideInTop,
    this.imageAnimationType = AnimateEaseType.fadeIn,
    this.thumbnailAnimationType = AnimateEaseType.slideInRight,
  });

  @override
  SliderAndCheckboxState createState() => SliderAndCheckboxState();
}

class SliderAndCheckboxState extends State<SliderAndCheckbox> {
  final PageController _pageController = PageController();
  Timer? _autoScrollTimer;
  Timer? _interactionTimer;
  int _currentIndex = 0;
  int _nextIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.autoScroll) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (widget.isOverlaySlider) {
        _nextIndex = (_currentIndex + 1) % widget.images.length;
        _animateToPage(_nextIndex);
      } else {
        _nextPage();
      }
    });
  }

  void _resetAutoScroll() {
    _autoScrollTimer?.cancel();
    _interactionTimer?.cancel();
    _interactionTimer = Timer(const Duration(seconds: 6), () {
      if (widget.autoScroll) {
        _startAutoScroll();
      }
    });
  }

  void _animateToPage(int index) {
    setState(() {
      _nextIndex = index;
    });
    Future.delayed(widget.animationDuration, () {
      setState(() {
        _currentIndex = _nextIndex;
      });
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _interactionTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _resetAutoScroll();
    _pageController.animateToPage(
      (_currentIndex + 1) % widget.images.length,
      duration: widget.animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void _prevPage() {
    _resetAutoScroll();
    _pageController.animateToPage(
      (_currentIndex - 1 + widget.images.length) % widget.images.length,
      duration: widget.animationDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              widget.isOverlaySlider
                  ? _buildOverlaySlider()
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: widget.images.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final imageModel = widget.images[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageDetailPage(
                                  image: imageModel.imageUrl,
                                  title: imageModel.title,
                                  subtitle: imageModel.subtitle,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(widget.imageBorderRadius),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AnimateEase(
                                  animate: widget.imageAnimationType,
                                  duration: widget.animationDuration,
                                  child: _buildImage(imageModel.imageUrl),
                                ),
                                if (widget.showOverlayText)
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    right: 20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AnimateEase(
                                          animate: widget.titleAnimationType,
                                          duration: widget.animationDuration,
                                          child: Text(
                                          imageModel.title,
                                          style: TextStyle(
                                            color: widget.overlayTextColor,
                                            fontSize: widget.overlayTextSize + 10,
                                            fontWeight: widget.overlayTextWeight,
                                          ),
                                        ),
                                        ),
                                        const SizedBox(height: 10.0),
                                         AnimateEase(
                                          animate: widget.subTitleAnimationType,
                                          duration: widget.animationDuration,
                                          child: Text(
                                          imageModel.subtitle,
                                          style: TextStyle(
                                            color: widget.overlayTextColor,
                                            fontSize: widget.overlayTextSize,
                                            fontWeight: widget.overlayTextWeight,
                                          ),
                                        ),
                                         ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              if (widget.showControls)
                Positioned(
                  left: widget.controlsPadding,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: widget.controlsColor, size: widget.controlsSize),
                      onPressed: _prevPage,
                    ),
                  ),
                ),
              if (widget.showControls)
                Positioned(
                  right: widget.controlsPadding,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, color: widget.controlsColor, size: widget.controlsSize),
                      onPressed: _nextPage,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.showThumbnails)
          Container(
            height: widget.thumbnailSize,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _resetAutoScroll();
                    if (widget.isOverlaySlider) {
                      _animateToPage(index);
                    } else {
                      setState(() {
                        _currentIndex = index;
                      });
                      _pageController.animateToPage(
                        _currentIndex,
                        duration: widget.animationDuration,
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                  width: widget.thumbnailSize,
                    margin: EdgeInsets.all(widget.thumbnailPadding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(widget.thumbnailBorderRadius),
                      child: AnimateEase(
                        animate: widget.thumbnailAnimationType,
                        child: _buildThumbnail(widget.images[index].imageUrl),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildOverlaySlider() {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.localPosition.dx > MediaQuery.of(context).size.width / 2) {
          _prevPage();
        } else {
          _nextPage();
        }
      },
      child: Stack(
        children: [
          AnimateEase(
            animate: widget.imageAnimationType,
            child: _buildImage(widget.images[_currentIndex].imageUrl)),
          if (_currentIndex != _nextIndex)
            AnimateEase(
              animate: widget.imageAnimationType,
              duration: widget.animationDuration,
              child: _buildImage(widget.images[_nextIndex].imageUrl),
            ),
        ],
      ),
    );
  }

  Widget _buildImage(String image) {
    return image.startsWith('http')
        ? Image.network(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            loadingBuilder: (context, child, err) {
              if (err == null) return child;
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 30.0,
                  width: 30.0,
                  child: const CircularProgressIndicator(
                     strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (context, child, err) {
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 30.0,
                  width: 30.0,
                  child: const Icon(Icons.error_outline_outlined),
                ),
              );
            },
          )
        : Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
          );
  }

  Widget _buildThumbnail(String image) {
    return image.startsWith('http')
        ? Image.network(
            image,
            fit: BoxFit.cover,
            width: widget.thumbnailSize,
            height: widget.thumbnailSize,
            loadingBuilder: (context, child, err) {
              if (err == null) return child;
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 10.0,
                  width: 10.0,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (context, child, err) {
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 30.0,
                  width: 30.0,
                  child: const Icon(Icons.error_outline_outlined),
                ),
              );
            },
          )
        : Image.asset(
            image,
            fit: BoxFit.cover,
            width: widget.thumbnailSize,
            height: widget.thumbnailSize,
          );
  }
}

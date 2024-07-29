import 'package:animate_ease/animate_ease_type.dart';
import 'package:flutter/material.dart';
import 'package:slider_and_checkbox/image_check_list_model.dart';
class ImageCheckbox extends StatefulWidget {
  final double? imageBorderRadius;
  final Color? borderColor;
  final double? imageSize;
  final EdgeInsets? padding;
  final AnimateEaseType? animationType;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final List<ImageCheckListModel>? images;
  final Duration? animationDuration;
  final TextEditingController? nameController;

  const ImageCheckbox({
    super.key,
    required this.images,
    this.borderColor = Colors.amber,
    this.imageSize = 20.0,
    this.padding = const EdgeInsets.only(),
    this.animationType = AnimateEaseType.fadeIn,
    this.textColor = Colors.black,
    this.textSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.imageBorderRadius = 10.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.nameController,
  });

  @override
  ImageCheckboxState createState() => ImageCheckboxState();
}

class ImageCheckboxState extends State<ImageCheckbox> {
  static int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(),
      height: widget.imageSize,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.images!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                widget.nameController!.text = widget.images![index].name!;
              });
            },
            child: Padding(
              padding: widget.padding!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.imageSize! + 30.0,
                    height: widget.imageSize,
                    margin: widget.padding,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(widget.imageBorderRadius!),
                      border: _selectedIndex == index
                          ? Border.all(
                              width: 3,
                              color: widget.borderColor!,
                            )
                          : null,
                    ),
                    child: widget.images![index].imageUrl!.startsWith('http')
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(widget.imageBorderRadius!),
                          child: Image.network(
                            widget.images![index].imageUrl!,
                            fit: BoxFit.fill,
                            width: widget.imageSize! + 30.0,
                            height: widget.imageSize,
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
                          ),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(widget.imageBorderRadius!),
                          child: Image.asset(
                            widget.images![index].imageUrl!,
                            fit: BoxFit.contain,
                            width: widget.imageSize! + 30.0,
                            height: widget.imageSize,
                              errorBuilder: (context, child, err) {
                                return Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.0,
                                    width: 30.0,
                                    child: const Icon(Icons.error_outline_outlined,  color: Colors.red),
                                  ),
                                );
                              },
                          ),
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

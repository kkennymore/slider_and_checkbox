import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slider_and_checkbox/image_model.dart';
import 'package:slider_and_checkbox/slider_and_checkbox.dart';

void main() {
  testWidgets('SliderAndCheckbox widget displays images correctly', (WidgetTester tester) async {
    final images = [
      ImageModel(
        imageUrl: 'assets/image1.jpg',
        title: 'Image 1',
        subtitle: 'Subtitle 1',
      ),
      ImageModel(
        imageUrl: 'assets/image2.jpg',
        title: 'Image 2',
        subtitle: 'Subtitle 2',
      ),
      ImageModel(
        imageUrl: 'assets/image3.jpg',
        title: 'Image 3',
        subtitle: 'Subtitle 3',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SliderAndCheckbox(
            images: images,
            showControls: true,
            showOverlayText: true,
            showThumbnails: true,
          ),
        ),
      ),
    );

    // Verify that the images are displayed
    expect(find.byType(Image), findsNWidgets(3));

    // Verify that the controls are displayed
    expect(find.byType(Slider), findsOneWidget);
    expect(find.byType(Icon), findsNWidgets(2));

    // Verify that the overlay text is displayed
    expect(find.text('Image 1'), findsOneWidget);
    expect(find.text('Subtitle 1'), findsOneWidget);

    // Verify that the thumbnails are displayed
    expect(find.byType(Image), findsNWidgets(3));
  });
}
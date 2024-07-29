import 'package:flutter/material.dart';
import 'package:slider_and_checkbox/image_check_list_model.dart';
import 'package:slider_and_checkbox/image_checkbox.dart';
import 'package:slider_and_checkbox/image_model.dart';
import 'package:slider_and_checkbox/slider_and_checkbox.dart';

class ContentSliderAndCheckbox extends StatelessWidget {
  const ContentSliderAndCheckbox({super.key});
  static final _checkboxController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Content Slider And Checkbox"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: SliderAndCheckbox(
                  autoScroll: true,
                  animationDuration: Durations.extralong2,
                  showControls: true,
                  images: [
                    ImageModel(
                      imageUrl:
                          'https://plus.unsplash.com/premium_photo-1681335986551-dca3f6d7f0e9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      title: 'Title 1',
                      subtitle: 'Subtitle 1',
                    ),
                    ImageModel(
                      imageUrl:
                          'https://images.unsplash.com/photo-1638389746430-82c12a2d0bb2?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      title: 'Title 2',
                      subtitle: 'Subtitle 2',
                    ),
                    ImageModel(
                      imageUrl:
                          'https://images.unsplash.com/photo-1593697820980-a9d1a839aff7?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      title: 'Title 3',
                      subtitle: 'Subtitle 3',
                    ),
                    ImageModel(
                      imageUrl:
                          'https://images.unsplash.com/photo-1593697821094-53ed19153f21?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      title: 'Title 4',
                      subtitle: 'Subtitle 4',
                    ),
                    ImageModel(
                      imageUrl:
                          'https://images.unsplash.com/photo-1720725150899-7e1888cb7bfb?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MXx8fGVufDB8fHx8fA%3D%3D',
                      title: 'Title 5',
                      subtitle: 'Subtitle 5',
                    ),
                    ImageModel(
                      imageUrl:
                          'https://images.unsplash.com/photo-1705729742673-411e236935da?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEyfHx8ZW58MHx8fHx8',
                      title: 'Title 6',
                      subtitle: 'Subtitle 6',
                    ),
                    ImageModel(
                      imageUrl:
                          'https://images.unsplash.com/photo-1720722294053-9b01e4bbf40f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTh8fHxlbnwwfHx8fHw%3D',
                      title: 'Title 7',
                      subtitle: 'Subtitle 7',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text("Checkboxes"),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(),
                child: ImageCheckbox(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                  imageSize: 40.0,
                  images: [
                    ImageCheckListModel(
                      imageUrl:
                          "https://www.justalternativeto.com/wp-content/uploads/2022/03/Paystack.png",
                      name: "PayStack",
                    ),
                    ImageCheckListModel(
                      imageUrl:
                          "https://techuncode.com/wp-content/uploads/2023/09/FLUTTERWAVE-IMAGE-2.jpeg",
                      name: "FlutterWave",
                    ),
                    ImageCheckListModel(
                      imageUrl:
                          "https://blog.seerbit.com/hubfs/SeerBit%20Logotype_Red.png",
                      name: "Seerbit",
                    ),
                    ImageCheckListModel(
                      imageUrl:
                          "https://marketplace.whmcs.com/product/5499/images/icon200-3925b26f85013d112075982dc3756271.png",
                      name: "Monnify",
                    ),
                  ],
                  nameController: _checkboxController,
                  borderColor: Colors.amber,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.amberAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                ),
                onPressed: () async {
                  print("Checkbox: ${_checkboxController.text}");
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

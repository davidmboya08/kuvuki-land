import 'dart:io';

import 'package:ambulance_taxi/views/driver/verification_pending.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../utilis/app_colors.dart';
import '../../widget/intro_widget.dart';
import 'car_registration/vehical_color.dart';
import 'car_registration/vehical_make.dart';
import 'car_registration/vehical_model.dart';
import 'car_registration/vehical_model_year.dart';
import 'car_registration/vehical_number.dart';

class CarRegistrationTemplate extends StatefulWidget {
  const CarRegistrationTemplate({Key? key}) : super(key: key);

  @override
  State<CarRegistrationTemplate> createState() => _CarRegistrationTemplateState();
}

class _CarRegistrationTemplateState extends State<CarRegistrationTemplate> {



  String selectedVehicalMake =  '';
  String selectedVehicalModel =  '';
  String selectModelYear = '';
  PageController pageController = PageController();
  TextEditingController vehicalNumberController = TextEditingController();
  String vehicalColor = '';
  File? document;



  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          introWidgetWithoutLogos(title: 'Car Registration',subtitle: 'Complete the process detail'),

          const SizedBox(height: 20,),

          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PageView(
              onPageChanged: (int page){
                currentPage = page;
              },
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [


                VehicalMakePage(
                  selectedVehical: selectedVehicalMake,
                  onSelect: (String vehicalMake){
                    setState(() {
                      selectedVehicalMake = vehicalMake;
                    });
                  },
                ),

                VehicalModelPage(
                  selectedModel: selectedVehicalModel,
                  onSelect: (String vehicalModel){
                    setState(() {
                      selectedVehicalModel = vehicalModel;
                    });
                  },
                ),
                VehicalModelYearPage(
                  onSelect: (int year){
                    setState(() {
                      selectModelYear = year.toString();
                    });
                  },
                ),

                VehicalNumberPage(
                  controller: vehicalNumberController,
                ),

                VehicalColorPage(
                  onColorSelected: (String selectedColor){
                    vehicalColor = selectedColor;
                  },
                ),

              ],
            ),
          ),),

          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(()=> isUploading.value? Center(child: CircularProgressIndicator(),): FloatingActionButton(onPressed: (){


                  if(currentPage<8){
                    pageController.animateToPage(currentPage+1, duration: const Duration(seconds: 1), curve: Curves.easeIn);

                  }else{
                    uploadDriverCarEntry();
                  }


                },child: Icon(Icons.arrow_forward,color: Colors.white,),backgroundColor: AppColors.greenColor,)),
              )),


        ],
      ),
    );
  }


  var isUploading = false.obs;

  void uploadDriverCarEntry() async{

    isUploading(true);
    //String imageUrl = await Get.find<AuthController>().uploadImage(document!);

    Map<String,dynamic> carData = {
      'vehicle_make': selectedVehicalMake,
      'vehicle_model': selectedVehicalModel,
      'vehicle_year': selectModelYear,
      'vehicle_number': vehicalNumberController.text.trim(),
      'vehicle_color': vehicalColor,

    };

  // await database verification
    Get.off(()=>VerificaitonPendingScreen());
  }
}

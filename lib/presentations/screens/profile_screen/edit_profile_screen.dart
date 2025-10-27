import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_button.dart';
import '../../../controllers/profile_controller.dart';
import '../../../core/config/app_routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/custom_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  ProfileController controller = Get.put(ProfileController());



  File? selectedImage;
  String? profileImagePath;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16.w),
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColors.bottomBackColorB3E5FC,
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.r),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(width: 12.w),
            CustomText(
              text: "Edit Profile",
              color: AppColors.textColor000000,
              fontsize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: IconButton(
              onPressed: () {
                context.pushNamed(AppRoutes.settingsScreen);
              },
              icon: Assets.icons.settings.svg(),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomMainProfileImage(
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Pori_Moni_%28cropped%29.jpg/960px-Pori_Moni_%28cropped%29.jpg',
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Input fields box
            Container(
              width: 393.w,
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColors.textColorFFFFFF,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  // Name
                  CustomText(
                    text: "Name",
                    color: AppColors.textColor545454,
                    fontsize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    controller: namCtrl,
                    initialValue: "Jessika",
                    style: const TextStyle(color: AppColors.textColor545454),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: AppColors.textColorC7A8AD,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Address
                  CustomText(
                    text: "Address",
                    color: AppColors.textColor545454,
                    fontsize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: addressCtrl,
                    initialValue: "2431 AF AMSTERDAM",
                    style: const TextStyle(color: AppColors.textColor545454),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: AppColors.textColorC7A8AD,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Phone
                  CustomText(
                    text: "Phone",
                    color: AppColors.textColor545454,
                    fontsize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: phoneCtrl,
                    initialValue: "************",
                    style: const TextStyle(color: AppColors.textColor545454),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: AppColors.textColorC7A8AD,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 310.h),
                  CustomButton(title: 'Save Change', onpress: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white.withOpacity(.5),
        elevation: 3,
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
              border: const Border(
                  top: BorderSide(color: AppColors.primaryColorC79235, width: 0.25)),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 9.2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: 50.w,
                              ),
                              CustomText(text: 'Gallery')
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImageFromCamera();
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 50.w,
                              ),
                              CustomText(text: 'Camera')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Navigator.pop(context);
      selectedImage = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      Navigator.pop(context);
      selectedImage = File(pickedFile.path);
      setState(() {});
    }
  }

  TextEditingController namCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
}

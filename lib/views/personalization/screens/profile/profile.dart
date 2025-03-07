import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/appbar/appbar.dart';
import 'package:jukyo_ms/common/widgets/custom/images/circular_image.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/circular_container.dart';
import 'package:jukyo_ms/common/widgets/custom/texts/section_header.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/constants/sizes.dart';
import 'package:jukyo_ms/utils/helpers/helper.dart';
import 'package:jukyo_ms/utils/shimmers/shimmer.dart';
import 'package:jukyo_ms/views/personalization/controllers/user_controller.dart';
import 'package:jukyo_ms/views/personalization/screens/profile/widgets/change_name.dart';
import 'package:jukyo_ms/views/personalization/screens/profile/widgets/change_username.dart';
import 'package:jukyo_ms/views/personalization/screens/profile/widgets/profile_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = UserController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : ConstantImages.user;
                        return controller.imageUploading.value
                            ? const TShimmerEffect(
                                width: 110,
                                height: 110,
                                radius: 100,
                              )
                            : Positioned(
                                child: CustomCircularImage(
                                  image: image,
                                  width: 110,
                                  height: 110,
                                  isNetworkImage: networkImage.isNotEmpty,
                                ),
                              );
                      },
                    ),
                    Positioned(
                      top: 68,
                      left: 222,
                      child: GestureDetector(
                        onTap: () => controller.uploadUserProfilePicture(),
                        child: CustomCircularContainer(
                          backgroundColor: dark
                              ? ConstantColors.primary
                              : ConstantColors.white,
                          height: 36,
                          width: 36,
                          child: Icon(
                            Icons.create,
                            color: dark
                                ? ConstantColors.buttonSecondary
                                : ConstantColors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Details
              const SizedBox(
                height: ConstantSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              // Heading Profile Info
              CustomSectionHeader(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              CustomProfileInformation(
                title: 'Name:',
                value: controller.user.value.fullName,
                onTap: () => Get.to(() => const ChangeName()),
              ),
              CustomProfileInformation(
                title: 'Username:',
                value: controller.user.value.username,
                onTap: () => Get.to(() => const ChangeUsername()),
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              // Heading Personal Info
              CustomSectionHeader(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              CustomProfileInformation(
                title: 'User ID:',
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onTap: () {},
              ),
              CustomProfileInformation(
                title: 'E-Mail:',
                value: controller.user.value.email,
                onTap: () {},
              ),
              CustomProfileInformation(
                title: 'Phone Number:',
                value: controller.user.value.phoneNb,
                onTap: () {},
              ),
              CustomProfileInformation(
                title: 'Gender:',
                value: 'Male',
                onTap: () {},
              ),
              CustomProfileInformation(
                title: 'Date Of Birth:',
                value: '2 Dec, 2002',
                onTap: () {},
              ),
              const Divider(),
              const SizedBox(
                height: ConstantSizes.spaceBtwItems,
              ),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

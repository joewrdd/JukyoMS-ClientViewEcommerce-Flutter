import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jukyo_ms/common/widgets/custom/images/circular_image.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/shimmers/shimmer.dart';
import 'package:jukyo_ms/views/personalization/controllers/user_controller.dart';

class CustomUserProfileTile extends StatelessWidget {
  const CustomUserProfileTile({
    super.key,
    this.onPressed,
  });

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return ListTile(
      leading: Obx(
        () {
          final networkImage = controller.user.value.profilePicture;
          final image =
              networkImage.isNotEmpty ? networkImage : ConstantImages.user;
          return controller.imageUploading.value
              ? const TShimmerEffect(
                  width: 110,
                  height: 110,
                  radius: 100,
                )
              : CustomCircularImage(
                  image: image,
                  width: 50,
                  height: 50,
                  padding: 0,
                  isNetworkImage: networkImage.isNotEmpty,
                );
        },
      ),
      title: Obx(
        () {
          if (controller.isProfileLoading.value) {
            return const TShimmerEffect(width: 80, height: 15);
          }
          return Text(
            controller.user.value.username,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: ConstantColors.white),
          );
        },
      ),
      subtitle: Obx(
        () {
          if (controller.isProfileLoading.value) {
            return const TShimmerEffect(width: 80, height: 15);
          }
          return Text(
            controller.user.value.email,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: ConstantColors.white),
          );
        },
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Iconsax.edit,
          color: ConstantColors.light,
        ),
      ),
    );
  }
}

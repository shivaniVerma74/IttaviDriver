// ignore_for_file: file_names, prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names, must_be_immutable

import 'package:deliveryboy/Api/Config.dart';
import 'package:deliveryboy/Api/data_store.dart';
import 'package:deliveryboy/controller/pagelist_controller.dart';
import 'package:deliveryboy/helpar/fontfamily_model.dart';
import 'package:deliveryboy/screen/bottombar_screen.dart';
import 'package:deliveryboy/screen/login_Screen.dart';
import 'package:deliveryboy/screen/lorem_screen.dart';
import 'package:deliveryboy/screen/notification_screen.dart';
import 'package:deliveryboy/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/notificatio_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  NotificationController notificationController = Get.find();

  String? text;
  bool isLodding = false;
  PageListController pageListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.to(() => const BottoBarScreen());
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: WhiteColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: SizedBox(),
            backgroundColor: transparent,
            title: Text(
              "Profile",
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                fontSize: 16,
                color: BlackColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: CircleAvatar(
                            backgroundColor: WhiteColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: WhiteColor,
                              backgroundImage: NetworkImage(
                                Config.imageurl +
                                    getData.read("StoreLogin")["img"],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: gradient.btnGradient),
                              child: Image.asset("assets/Vector.png",
                                  color: WhiteColor)),
                        )
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(getData.read("StoreLogin")["title"],
                        style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            color: BlackColor,
                            fontSize: 20)),
                    SizedBox(height: Get.height * 0.005),
                    // Text(getData.read("StoreLogin")["slogan"],
                    //     style: TextStyle(
                    //         fontFamily: FontFamily.gilroyMedium,
                    //         color: greyColor,
                    //         fontSize: 16)),
                    // SizedBox(height: Get.height * 0.005),
                    Text(getData.read("StoreLogin")["email"],
                        style: TextStyle(
                            fontFamily: FontFamily.gilroyMedium,
                            color: greyColor,
                            fontSize: 16)),
                    SizedBox(height: Get.height * 0.03),
                    setting(
                      SettingName: "Notification",
                      image: "assets/Notification.png",
                      onTap: () {
                        notificationController.getNotificationData();
                        Get.to(() => NotificationScreen());
                      },
                    ),
                    // SizedBox(height: Get.height * 0.02),
                    GetBuilder<PageListController>(builder: (context) {
                      return pageListController.isLodding
                          ? ListView.builder(
                              itemCount: pageListController
                                  .dynamicPageData?.pagelist.length,
                              shrinkWrap: true,
                              itemExtent: 70,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Column(
                                    children: [
                                      setting(
                                        SettingName: pageListController
                                            .dynamicPageData
                                            ?.pagelist[index]
                                            .title,
                                        image: "assets/file.png",
                                        onTap: () {
                                          Get.to(() => Loream(
                                              title: pageListController
                                                  .dynamicPageData
                                                  ?.pagelist[index]
                                                  .title,
                                              discription: pageListController
                                                  .dynamicPageData
                                                  ?.pagelist[index]
                                                  .description));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    }),
                    // setting(
                    //   SettingName: "Delete Account",
                    //   image: "assets/trash.png",
                    //   onTap: () {
                    //     deleteSheet();
                    //   },
                    // ),
                    setting(
                      SettingName: "Logout",
                      image: "assets/logout.png",
                      onTap: () {
                        logoutSheet();
                      },
                    )
                  ]),
            ),
          ),
        ));
  }

  setting({String? image, SettingName, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: bgcolor),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(image!,
                        height: 25, color: gradient.defoultColor),
                    SizedBox(width: Get.width * 0.03),
                    Text(
                      SettingName,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy Bold",
                          color: BlackColor),
                    )
                  ],
                ),
                SizedBox(width: Get.width * 0.025),
                InkWell(
                  onTap: () {
                    // Get.to(() => const EditProfile());
                  },
                  child: Icon(Icons.keyboard_arrow_right_outlined,
                      color: BlackColor, size: 30),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.02),
        ],
      ),
    );
  }

  Future deleteSheet() {
    return Get.bottomSheet(
      Container(
        height: 220,
        width: Get.size.width,
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Delete Account".tr,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Gilroy Bold",
                color: gradient.defoultColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(
                color: greycolor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Are you sure you want to delete account?".tr,
              style: TextStyle(
                fontFamily: "Gilroy Medium",
                fontSize: 16,
                color: BlackColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancle".tr,
                        style: TextStyle(
                          color: gradient.defoultColor,
                          fontFamily: "Gilroy Bold",
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: greenColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      pageListController.deletAccount();
                      // deleteAccountController.deleteaccount();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Yes, Remove".tr,
                        style: TextStyle(
                          color: WhiteColor,
                          fontFamily: "Gilroy Bold",
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: gradient.btnGradient,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future logoutSheet() {
    return Get.bottomSheet(
      Container(
        height: 220,
        width: Get.size.width,
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Logout".tr,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: FontFamily.gilroyBold,
                  color: RedColor),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: greyColor),
            ),
            SizedBox(height: 10),
            Text(
              "Are you sure you want to log out?".tr,
              style: TextStyle(
                  fontFamily: FontFamily.gilroyMedium,
                  fontSize: 16,
                  color: BlackColor),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancle".tr,
                        style: TextStyle(
                            color: gradient.defoultColor,
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16),
                      ),
                      decoration: BoxDecoration(
                        color: greenColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        getData.remove('Firstuser');
                        getData.remove('Remember');
                        getData.remove("StoreLogin");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginscreen()));
                      });
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Yes, Logout".tr,
                        style: TextStyle(
                            color: WhiteColor,
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16),
                      ),
                      decoration: BoxDecoration(
                          gradient: gradient.btnGradient,
                          borderRadius: BorderRadius.circular(45)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}



// // ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, unused_local_variable
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:milkman/controller/notification_controller.dart';
// import 'package:milkman/model/fontfamily_model.dart';
// import 'package:milkman/utils/Colors.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   NotificationController notificationController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgcolor,
//       appBar: AppBar(
//         backgroundColor: WhiteColor,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: BlackColor,
//           ),
//         ),
//         title: Text(
//           "Notification".tr,
//           style: TextStyle(
//             fontSize: 17,
//             fontFamily: FontFamily.gilroyBold,
//             color: BlackColor,
//           ),
//         ),
//       ),
//       body: GetBuilder<NotificationController>(builder: (context) {
//         return Column(
//           children: [
//             Expanded(
//                 child: notificationController.isLoading
//                 // ? notificationController.notificationInfo?.notificationData.isNotEmpty
//                     ? ListView.builder(
//                   // reverse: true,
//                   itemCount: notificationController.notificationInfo?.notificationData.length,
//                   itemBuilder: (context, index) {
//                     // String time = "${DateFormat.jm().format(DateTime.parse("2023-03-20T${notificationController.notificationInfo?.notificationData[index].datetime.toString().split(" ").last}"))}";
//                     return Container(
//                       margin: EdgeInsets.all(10),
//                       child: ListTile(
//                         leading: Container(
//                           height: 60,
//                           width: 60,
//                           padding: EdgeInsets.all(15),
//                           child: Image.asset(
//                             "assets/Notification1.png",
//                             color: gradient.defoultColor,
//                           ),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color:
//                             gradient.defoultColor.withOpacity(0.1),
//                           ),
//                         ),
//                         title: Text(
//                           notificationController.notificationInfo?.notificationData[index].title ?? "",
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontFamily: FontFamily.gilroyBold,
//                             color: BlackColor,
//                           ),
//                         ),
//                         subtitle: Row(
//                           children: [
//                             Text(
//                               notificationController.notificationInfo?.notificationData[index].datetime.toString().split(" ").first ?? "",
//                               style: TextStyle(
//                                 color: greytext,
//                                 fontFamily: FontFamily.gilroyMedium,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             // Text(
//                             //   time,
//                             //   style: TextStyle(
//                             //     color: greytext,
//                             //     fontFamily: FontFamily.gilroyMedium,
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         color: WhiteColor,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     );
//                   },
//                 )
//                     : Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Padding(
//                       //   padding: const EdgeInsets.only(left: 30),
//                       //   child: Image.asset(
//                       //     "assets/images/bookingEmpty.png",
//                       //     height: 120,
//                       //     width: 120,
//                       //   ),
//                       // ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "We'll let you know when we\nget news for you"
//                             .tr,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: greytext,
//                           fontFamily: FontFamily.gilroyBold,
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               // : Center(
//               //     child: CircularProgressIndicator(
//               //       color: gradient.defoultColor,
//               //     ),
//               //   ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

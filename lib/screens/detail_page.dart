import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schaffen/utils/textstyle.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ScrollController _scrollController = ScrollController();
  bool _isPinned = false;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    initFollewers();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset >= 150.h && !_isPinned) {
        setState(() {
          _isPinned = true;
        });
      } else if (_scrollController.offset < 150.h && _isPinned) {
        setState(() {
          _isPinned = false;
        });
      }
    }
  }

  void initFollewers() {
    addedFollowers = List.generate(10, (index) => false);
  }

  void openModalSheet() {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxHeight: 200.h),
        builder: (context) => Container(
              width: 1.sw,
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(
                    color: Colors.black,
                    indent: 90.w,
                    endIndent: 90.w,
                    thickness: 3.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                      10.w.horizontalSpace,
                      Text(
                        'Invite',
                        style: textstyle(Colors.black, 18.sp, FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                      10.w.horizontalSpace,
                      Text(
                        'Add member',
                        style: textstyle(Colors.black, 18.sp, FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.group_add,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                      10.w.horizontalSpace,
                      Text(
                        'Add group',
                        style: textstyle(Colors.black, 18.sp, FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  List<bool> addedFollowers = [];

  bool _isExpanded = false;
  bool switchButton = false;
  String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vehicula ullamcorper erat, a convallis lorem bibendum in. Aliquam erat volutpat. In et est in massa consectetur hendrerit non vel massa. Additional details can go here. You can add as many widgets as you like in this section.';
  List buttonData = [
    {'name': 'Clear Chat', 'icon': Icons.delete, 'color': Colors.black},
    {'name': 'Encryption', 'icon': Icons.lock, 'color': Colors.black},
    {'name': 'Exit Community', 'icon': Icons.exit_to_app, 'color': Colors.red},
    {'name': 'Report', 'icon': Icons.thumb_down, 'color': Colors.red}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.red,
            floating: false,
            expandedHeight: 250.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl:
                    "https://i1.sndcdn.com/artworks-znF2kPhZ9vdA1mM0-EYdjgg-t500x500.jpg",
                fit: BoxFit.cover,
              ),
            ),
            toolbarHeight: 20.h,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(60.h),
                child: Container(
                  width: 1.sw,
                  height: 80.h,
                  decoration: const BoxDecoration(color: Colors.red),
                  padding: EdgeInsets.all(15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The Weekend",
                            style:
                                textstyle(Colors.white, 18.sp, FontWeight.bold),
                          ),
                          Text(
                            "Community \u2022 +11K Members",
                            style: textstyle(
                                Colors.white, 14.sp, FontWeight.normal),
                          )
                        ],
                      ),
                      _isPinned
                          ? GestureDetector(
                              onTap: () {
                                openModalSheet();
                              },
                              child: Icon(
                                Icons.more_vert,
                                size: 24.sp,
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Icon(
                                Icons.share,
                                size: 24.sp,
                                color: Colors.white,
                              ),
                            )
                    ],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _isExpanded
                              ? text
                              : text.length > 200
                                  ? '${text.substring(0, 200)}...'
                                  : text,
                          style:
                              textstyle(Colors.black, 17.sp, FontWeight.normal),
                        ),
                        if (text.length > 200)
                          TextSpan(
                            text: _isExpanded ? ' Read Less' : ' Read More',
                            style:
                                textstyle(Colors.red, 18.sp, FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                          ),
                      ],
                    ),
                  ),
                  10.h.verticalSpace,
                  SizedBox(
                    height: 25.h,
                    child: ListView.separated(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) {
                        return 5.w.horizontalSpace;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 6.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.h),
                              border: Border.all(color: Colors.red)),
                          child: Text(
                            index == 4 ? "+1" : 'Outdoor',
                            style:
                                textstyle(Colors.red, 14.sp, FontWeight.normal),
                          ),
                        ).animate().slideX(
                            delay: Duration(milliseconds: 50 * index),
                            begin: 1);
                      },
                    ),
                  ),
                  20.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Media, Docs and Links',
                        style: textstyle(Colors.black, 20.sp, FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 24.sp,
                      )
                    ],
                  ),
                  10.h.verticalSpace,
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) {
                        return 5.w.horizontalSpace;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.h),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://i1.sndcdn.com/artworks-znF2kPhZ9vdA1mM0-EYdjgg-t500x500.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ).animate().slideX(
                            delay: Duration(milliseconds: 50 * index),
                            begin: 1);
                      },
                    ),
                  ),
                  10.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mute notification',
                        style: textstyle(Colors.black, 16.sp, FontWeight.bold),
                      ),
                      Switch(
                          value: switchButton,
                          activeColor: Colors.red,
                          onChanged: (val) {
                            setState(() {
                              switchButton = val;
                            });
                          }),
                    ],
                  ),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: buttonData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return 10.h.verticalSpace;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Icon(
                            buttonData[index]['icon'],
                            color: buttonData[index]['color'],
                            size: 24.sp,
                          ),
                          10.w.horizontalSpace,
                          Text(
                            buttonData[index]['name'],
                            style: textstyle(buttonData[index]['color'], 16.sp,
                                FontWeight.bold),
                          )
                        ],
                      );
                    },
                  ),
                  20.h.verticalSpace,
                  isSearching
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 1.sw * 0.7,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.h),
                                      color: Colors.grey[100]),
                                  child: TextField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search Members',
                                        hintStyle: textstyle(Colors.grey, 14.sp,
                                            FontWeight.normal)),
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSearching = false;
                                });
                              },
                              child: Text(
                                'Cancel',
                                style: textstyle(
                                    Colors.black, 18.sp, FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Members',
                              style: textstyle(
                                  Colors.black, 20.sp, FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSearching = true;
                                });
                              },
                              child: CircleAvatar(
                                radius: 15.h,
                                backgroundColor: Colors.grey[200],
                                child: const Icon(Icons.search),
                              ),
                            )
                          ],
                        ),
                  10.h.verticalSpace,
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: addedFollowers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return 15.h.verticalSpace;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Animate(
                          effects: [
                            SlideEffect(
                                delay: Duration(milliseconds: 50 * index),
                                begin: const Offset(1, 0)),
                          ],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.h,
                                    backgroundColor: Colors.red,
                                  ),
                                  5.w.horizontalSpace,
                                  Column(
                                    children: [
                                      Text(
                                        'Yashika',
                                        style: textstyle(Colors.black, 16.sp,
                                            FontWeight.bold),
                                      ),
                                      Text(
                                        '29, India',
                                        style: textstyle(Colors.black, 14.sp,
                                            FontWeight.normal),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    addedFollowers[index] =
                                        !addedFollowers[index];
                                  });
                                },
                                child: Container(
                                  width: 100.w,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.h),
                                  decoration: BoxDecoration(
                                      color: addedFollowers[index]
                                          ? Colors.grey
                                          : Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(20.h)),
                                  child: Text(
                                    addedFollowers[index] ? "Following" : "Add",
                                    textAlign: TextAlign.center,
                                    style: textstyle(
                                        Colors.white, 16.sp, FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

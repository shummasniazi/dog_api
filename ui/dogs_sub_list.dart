import 'package:core/response_model/dog_sub_breed_images.dart';
import 'package:core/response_model/dogs_sub_breed_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/all_dogs/bloc.dart';
import '../bloc/all_dogs/event.dart';
import '../bloc/all_dogs/state.dart';

class DogsSubBreedListScreen extends StatefulWidget {
  const DogsSubBreedListScreen();

  @override
  State<DogsSubBreedListScreen> createState() => _DogsSubBreedListScreenState();
}

class _DogsSubBreedListScreenState extends State<DogsSubBreedListScreen> {
  DogsSubBreedList? dogsSubBreedList;
  AllDogsBloc? allDogsBloc;
  DogsSubBreedImages? dogsSubBreedImages;
  bool? isError = false;
  bool? isLoadingImages = false;

  TextEditingController breedController = TextEditingController();

  @override
  void initState() {
    allDogsBloc = AllDogsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllDogsBloc, AllDogsState>(
      bloc: allDogsBloc,
      listener: (context, state) {
        if (state is SubBreedLoadedState) {
          isError = false;
          dogsSubBreedList = state.subBreedListResponse;
        }
        if (state is SubBreedImagesLoadedState) {
          isError = false;
          isLoadingImages = false;
          dogsSubBreedImages = state.subBreedImagesResponse;
        }
        if (state is ErrorState) {
          isError = true;
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0.r),
                // Adjust the border radius as needed
                border: Border.all(
                  color: Colors.grey, // Border color
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: TextField(
                      controller: breedController,
                      decoration: const InputDecoration(
                        hintText: 'Enter text',
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              50.0.r), // Adjust the border radius as needed
                        ),
                        minimumSize: Size(20.0.w,
                            25.0.h), // Adjust width and height as needed
                      ),
                      onPressed: () {
                        allDogsBloc!
                            .add(FetchDogsSubBreedList(breedController.text));
                      },
                      child: const Text('Search'))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(20.w), child: const Text('Sub-Breeds')),
            dogsSubBreedList != null
                ? !isError!
                    ? SizedBox(
                        height: 50.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dogsSubBreedList!.message!.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.only(
                                    left: 15.w, bottom: 10.h, top: 10.h),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0
                                          .r), // Adjust the border radius as needed
                                    ), // Adjust width and height as needed
                                  ),
                                  onPressed: () {
                                    isLoadingImages = true;
                                    allDogsBloc!.add(FetchDogsSubBreedImages(
                                        breedController.text,
                                        dogsSubBreedList!.message![index]));
                                  },
                                  child:
                                      Text(dogsSubBreedList!.message![index]),
                                ));
                          },
                        ),
                      )
                    : const Center(
                        child: Text('No Category Found'),
                      )
                : Container(),
            !isLoadingImages!
                ? dogsSubBreedImages != null
                    ? !isError!
                        ? Expanded(
                            child: Container(
                              height: 50.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dogsSubBreedImages!.message!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.only(
                                          top: 5.h, bottom: 10.h),
                                      height: 200.h,
                                      width: 200.w,
                                      child: Image.network(
                                          dogsSubBreedImages!.message![index]));
                                },
                              ),
                            ),
                          )
                        : const Center(child: Text("No image found"))
                    : Container()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        );
      },
    );
  }
}

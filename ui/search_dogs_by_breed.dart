import 'package:core/response_model/dogs_by_breed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/all_dogs/bloc.dart';
import '../bloc/all_dogs/event.dart';
import '../bloc/all_dogs/state.dart';

class SearchDogsByBreedName extends StatefulWidget {
  const SearchDogsByBreedName({super.key});

  @override
  State<SearchDogsByBreedName> createState() => _SearchDogsByBreednameState();
}

class _SearchDogsByBreednameState extends State<SearchDogsByBreedName> {
  DogsByBreed? dogsByBreed;
  AllDogsBloc? allDogsBloc;
  bool isError = false;
  TextEditingController searchDogController = TextEditingController();

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
        if (state is DogsBreedLoadedState) {
          isError = false;
          dogsByBreed = state.dogsBreedResponse;
        }
        if (state is ErrorState) {
          isError = true;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                margin:
                    EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.h),
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
                        controller: searchDogController,
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
                              .add(FetchDogsByBreed(searchDogController.text));
                        },
                        child: const Text('Search'))
                  ],
                ),
              ),
              dogsByBreed != null
                  ? !isError
                      ? Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: dogsByBreed!.message!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin:
                                        EdgeInsets.only(top: 5.h, bottom: 10.h),
                                    height: 200.h,
                                    width: 200.w,
                                    child: Image.network(
                                        dogsByBreed!.message![index]));
                              },
                            ),
                          ),
                        )
                      : Container(
                          child: const Center(
                              child: Text(
                            'No breed found\nPlease Search another breed',
                            textAlign: TextAlign.center,
                          )),
                        )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}

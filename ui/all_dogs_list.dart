import 'package:core/response_model/all_dogs_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/all_dogs/bloc.dart';
import '../bloc/all_dogs/event.dart';
import '../bloc/all_dogs/state.dart';

class DogListPage extends StatefulWidget {
  const DogListPage({super.key});

  @override
  State<DogListPage> createState() => _DogListPageState();
}

class _DogListPageState extends State<DogListPage> {
  AllDogsResponse? dogResponse;

  List<Breeds>? breeds;

  AllDogsBloc? allDogsBloc;

  @override
  void initState() {
    allDogsBloc = AllDogsBloc();
    allDogsBloc!.add((FetchAllDogs()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllDogsBloc, AllDogsState>(
      bloc: allDogsBloc,
      listener: (context, state) {
        if (state is AllDogsLoadedState) {
          dogResponse = state.allDogsResponse;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: dogResponse != null
              ? Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: ListView(
                    children: [
                      if (dogResponse!.message != null)
                        for (var breedEntry
                            in dogResponse!.message!.toJson().entries)
                          ListTile(
                            title: Text(
                              breedEntry.key,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var subBreed in breedEntry.value)
                                  Text(
                                    'Sub-breed: $subBreed',
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15.sp),
                                  ),
                              ],
                            ),
                          ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

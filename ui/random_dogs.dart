import 'package:core/response_model/random_dogs_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets/back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/all_dogs/bloc.dart';
import '../bloc/all_dogs/event.dart';
import '../bloc/all_dogs/state.dart';

class DogDisplayPageBuilder extends StatefulWidget {
  const DogDisplayPageBuilder({super.key});

  @override
  _DogDisplayPageState createState() => _DogDisplayPageState();
}

class _DogDisplayPageState extends State<DogDisplayPageBuilder> {
  AllDogsBloc? allDogsBloc;
  RandomDogsResponse? randomDogsResponse;
  bool? isLoading = true;
  @override
  void initState() {
    super.initState();
    allDogsBloc = AllDogsBloc();
    allDogsBloc!.add(FetchRandomDogs());
  }

  _fetchRandomDog() {
    allDogsBloc!.add(FetchRandomDogs());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllDogsBloc, AllDogsState>(
      bloc: allDogsBloc,
      listener: (context, state) {
        if (state is RandomDogLoadedState) {
            isLoading = false;
          randomDogsResponse = state.randomDogsResponse;
        }else if(state is LoadingState){
            isLoading = true;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: !isLoading!? Center(
            child: randomDogsResponse != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(randomDogsResponse!.message!),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: _fetchRandomDog,
                        child: const Text('Fetch Another Dog'),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(),
          ):const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

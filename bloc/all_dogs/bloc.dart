import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:core/response_model/all_dogs_response.dart';
import 'package:core/response_model/dog_sub_breed_images.dart';
import 'package:core/response_model/dogs_by_breed.dart';
import 'package:core/response_model/dogs_sub_breed_list.dart';
import 'package:core/response_model/random_dogs_response.dart';
import 'package:network/repositories/dogs_repository_imp.dart';

import 'event.dart';
import 'state.dart';

class AllDogsBloc extends Bloc<AllDogsEvent, AllDogsState> {
  DogRepositoryImp repository = DogRepositoryImp();

  AllDogsBloc() : super(InitialState()) {
    on<AllDogsEvent>((event, emit) async {
      await _mapEventToState(event, emit);
    });
  }

  FutureOr<void> _mapEventToState(
      AllDogsEvent event, Emitter<AllDogsState> emit) async {
    if (event is FetchAllDogs) {
      await _mapEventFetchAllDogsToState(event, emit);
    }
    if (event is FetchDogsByBreed) {
      await _mapEventFetchDogsByBreedToState(event, emit);
    }
    if (event is FetchRandomDogs) {
      await _mapEventFetchRandomDogsToState(event, emit);
    }
    if (event is FetchDogsSubBreedList) {
      await _mapEventFetchDogsSubBreedToState(event, emit);
    }
    if (event is FetchDogsSubBreedImages) {
      await _mapEventFetchDogsSubBreedImagesToState(event, emit);
    }
  }

  FutureOr<void> _mapEventFetchAllDogsToState(
      FetchAllDogs event, Emitter<AllDogsState> emit) async {
    emit(LoadingState());
    AllDogsResponse response;
    try {
      response = await repository.getAllDogsList();

      if (response.status != null) {
        emit(AllDogsLoadedState(allDogsResponse: response));
      } else {
        emit(ErrorState(message: ""));
      }
    } catch (e) {
      emit(ErrorState(
          message: "Something went wrong! Please try again later.",
          status: ""));
    }
  }

  FutureOr<void> _mapEventFetchDogsByBreedToState(
      FetchDogsByBreed event, Emitter<AllDogsState> emit) async {
    emit(LoadingState());
    DogsByBreed response;
    try {
      response = await repository.getAllDogsByBreed(event.breed);
      if (response.status != null) {
        emit(DogsBreedLoadedState(dogsBreedResponse: response));
      } else {
        emit(ErrorState(message: ""));
      }
    } catch (e) {
      emit(ErrorState(
          message: "Something went wrong! Please try again later.",
          status: ""));
    }
  }

  FutureOr<void> _mapEventFetchRandomDogsToState(
      FetchRandomDogs event, Emitter<AllDogsState> emit) async {
    emit(LoadingState());
    RandomDogsResponse response;
    try {
      response = await repository.getRandomDogImage();
      if (response.status != null) {
        emit(RandomDogLoadedState(randomDogsResponse: response));
      } else {
        emit(ErrorState(message: ""));
      }
    } catch (e) {
      emit(ErrorState(
          message: "Something went wrong! Please try again later.",
          status: ""));
    }
  }

  FutureOr<void> _mapEventFetchDogsSubBreedToState(
      FetchDogsSubBreedList event, Emitter<AllDogsState> emit) async {
    emit(LoadingState());
    DogsSubBreedList response;
    try {
      response = await repository.getSubBreedList(event.breed);
      if (response.status != null) {
        emit(SubBreedLoadedState(subBreedListResponse: response));
      } else {
        emit(ErrorState(message: ""));
      }
    } catch (e) {
      emit(ErrorState(
          message: "Something went wrong! Please try again later.",
          status: ""));
    }
  }

  FutureOr<void> _mapEventFetchDogsSubBreedImagesToState(
      FetchDogsSubBreedImages event, Emitter<AllDogsState> emit) async {
    emit(LoadingState());
    DogsSubBreedImages response;
    try {
      response = await repository.getSubBreedImages(event.breed);
      if (response.status != null) {
        emit(SubBreedImagesLoadedState(subBreedImagesResponse: response));
      } else {
        emit(ErrorState(message: ""));
      }
    } catch (e) {
      emit(ErrorState(
          message: "Something went wrong! Please try again later.",
          status: ""));
    }
  }
}

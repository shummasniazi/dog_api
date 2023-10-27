import 'package:core/response_model/all_dogs_response.dart';
import 'package:core/response_model/dog_sub_breed_images.dart';
import 'package:core/response_model/dogs_by_breed.dart';
import 'package:core/response_model/dogs_sub_breed_list.dart';
import 'package:core/response_model/random_dogs_response.dart';

abstract class AllDogsState {}

class AllDogsLoadedState extends AllDogsState {
  AllDogsResponse? allDogsResponse;

  AllDogsLoadedState({this.allDogsResponse});
}

class DogsBreedLoadedState extends AllDogsState {
  DogsByBreed? dogsBreedResponse;

  DogsBreedLoadedState({this.dogsBreedResponse});
}

class LoadingState extends AllDogsState {}

class InitialState extends AllDogsState {}

class ErrorState extends AllDogsState {
  String? status;
  String? message;

  ErrorState({this.status, this.message});
}

class RandomDogLoadedState extends AllDogsState {
  RandomDogsResponse? randomDogsResponse;

  RandomDogLoadedState({this.randomDogsResponse});
}

class SubBreedLoadedState extends AllDogsState {
  DogsSubBreedList? subBreedListResponse;

  SubBreedLoadedState({this.subBreedListResponse});
}

class SubBreedImagesLoadedState extends AllDogsState {
  DogsSubBreedImages? subBreedImagesResponse;

  SubBreedImagesLoadedState({this.subBreedImagesResponse});
}

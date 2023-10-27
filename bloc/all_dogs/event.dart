import 'package:flutter/cupertino.dart';

abstract class AllDogsEvent {}

class InitEvent extends AllDogsEvent {}

class FetchAllDogs extends AllDogsEvent {}

class FetchDogsByBreed extends AllDogsEvent {
  String breed;

  FetchDogsByBreed(this.breed);
}

class FetchDogsSubBreedList extends AllDogsEvent {
  String breed;

  FetchDogsSubBreedList(this.breed);
}

class FetchDogsSubBreedImages extends AllDogsEvent {
  String breed;
  String subBreed;

  FetchDogsSubBreedImages(this.breed, this.subBreed);
}

class FetchRandomDogs extends AllDogsEvent {}

class LoadingSuccess extends AllDogsEvent {}

class FetchRandomDogsFail extends AllDogsEvent {}

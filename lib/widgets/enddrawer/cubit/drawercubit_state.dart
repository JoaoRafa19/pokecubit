part of 'drawercubit_cubit.dart';

@immutable
abstract class DrawerState {}

class DrawercubitInitial extends DrawerState {}
class DrawerLoading extends DrawerState {}
class DrawerConcluded extends DrawerState {}
class DrawerLoadingData extends DrawerState {}
class DrawerConcludedData extends DrawerState {}
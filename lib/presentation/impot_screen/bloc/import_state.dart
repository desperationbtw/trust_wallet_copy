part of 'import_bloc.dart';

abstract class ImportState {
  final List<ImportVariant> variants;

  ImportState(this.variants);
}

class ImportProgressState extends ImportState {
  ImportProgressState() : super([]);
}

class ImportContentState extends ImportState {
  ImportContentState(super.variants);
}

class ImportEmptyState extends ImportState {
  ImportEmptyState() : super([]);
}

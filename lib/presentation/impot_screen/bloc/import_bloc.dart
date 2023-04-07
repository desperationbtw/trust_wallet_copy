import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_wallet_scm/domain/enum/import_options.dart';
import 'package:trust_wallet_scm/domain/models/import_variant.dart';

part 'import_event.dart';
part 'import_state.dart';

class ImportBloc extends Bloc<ImportEvent, ImportState> {
  ImportBloc() : super(ImportProgressState()) {
    on<ImportInitEvent>(_handleImportInitEvent);
  }

  FutureOr<void> _handleImportInitEvent(ImportInitEvent event, Emitter<ImportState> emit) async {
    final variants = [
      ImportVariant(name: 'Aeternity', logo: 'assets/coins/457.webp', options: {
        ImportOptions.phrase,
        ImportOptions.address,
      }),
      ImportVariant(name: 'Aion', logo: 'assets/coins/425.webp', options: {
        ImportOptions.phrase,
        ImportOptions.privateKey,
        ImportOptions.address,
      }),
      ImportVariant(name: 'Algorand', logo: 'assets/coins/283.webp', options: {
        ImportOptions.phrase,
        ImportOptions.privateKey,
        ImportOptions.address,
      }),
      ImportVariant(name: 'Arbitrum', logo: 'assets/coins/10042221.webp', options: {
        ImportOptions.phrase,
        ImportOptions.keystore,
        ImportOptions.privateKey,
        ImportOptions.address,
      }),
      ImportVariant(name: 'Cosmos Hub', logo: 'assets/coins/118.webp', options: {
        ImportOptions.phrase,
        ImportOptions.privateKey,
        ImportOptions.address,
      }),
      ImportVariant(name: 'Aurora', logo: 'assets/coins/1323161554.webp', options: {
        ImportOptions.phrase,
        ImportOptions.keystore,
        ImportOptions.privateKey,
        ImportOptions.address,
      }),
      ImportVariant(name: 'Avalanche C-Chain', logo: 'assets/coins/10009000.webp', options: {
        ImportOptions.phrase,
        ImportOptions.keystore,
        ImportOptions.privateKey,
        ImportOptions.address,
      }),
      ImportVariant(name: 'BNB Beacon Chain', logo: 'assets/coins/714.webp', options: {
        ImportOptions.phrase,
        ImportOptions.privateKey,
        ImportOptions.address,
      }),
      ImportVariant(name: 'Bitcoin', logo: 'assets/coins/0.webp', options: {
        ImportOptions.phrase,
      }),
    ];

    // await Future.delayed(const Duration(milliseconds: 400));

    emit(ImportContentState(variants));
  }
}

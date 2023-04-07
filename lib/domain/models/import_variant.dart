import 'package:trust_wallet_scm/domain/enum/import_options.dart';

class ImportVariant {
  final String name;
  final String logo;
  final Set<ImportOptions> options;

  ImportVariant({
    required this.name,
    required this.logo,
    required this.options,
  });
}

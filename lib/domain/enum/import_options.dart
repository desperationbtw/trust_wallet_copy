enum ImportOptions {
  phrase('Фраза'),
  keystore('Keystore\nJSON'),
  privateKey('Приватный\nключ'),
  address('Адрес');

  final String text;
  const ImportOptions(this.text);
}

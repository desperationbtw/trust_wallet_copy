enum TokenType {
  ripple('XRP', 'XRP', 'assets/coins/144.webp'),
  bnbBeaconChain('BNB Beacon Chain', 'BNB', 'assets/coins/714.webp'),
  cronosChain('Cronos Chain', 'CRO', 'assets/coins/10000025.webp'),
  cryptoOrg('Crypro.org', 'CRO', 'assets/coins/10000025.webp'),
  ethereum('Ethereum', 'ETH', 'assets/coins/60.webp'),
  litecoin('Litecoin', 'LTC', 'assets/coins/2.webp'),
  near('NEAR', 'NEAR', 'assets/coins/397.webp'),
  bitcoin('Bitcoin', 'BTC', 'assets/coins/0.webp');

  final String short;
  final String name;
  final String logoAsset;

  const TokenType(this.name, this.short, this.logoAsset);
}

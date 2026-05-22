enum CurrencyEnum {
  usd("USD", "\$", "Dólar Americano"),
  gbp("GBP", "£", "Libra Esterlina"),
  eur("EUR", "€", "Euro"),
  brl("BRL", "R\$", "Real Brasileiro");

  final String coin;
  final String format;
  final String name;
  const CurrencyEnum(this.coin, this.format, this.name);
}
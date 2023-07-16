enum IntervalTime {
  m1('1m'),
  m3('3m'),
  m5('5m'),
  m15('15m'),
  m30('30m'),
  h1('1h'),
  h2('2h'),
  h4('4h'),
  h6('6h'),
  h8('8h'),
  h12('12h'),
  d1('1d'),
  d3('3d'),
  w1('1w'),
  M1('1M');

  final String time;
  const IntervalTime(this.time);
}

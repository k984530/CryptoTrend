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

IntervalTime returnTime(String t) {
  if (t == '1m') {
    return IntervalTime.m1;
  } else if (t == '3m') {
    return IntervalTime.m3;
  } else if (t == '5m') {
    return IntervalTime.m5;
  } else if (t == '15m') {
    return IntervalTime.m15;
  } else if (t == '30m') {
    return IntervalTime.m30;
  } else if (t == '1h') {
    return IntervalTime.h1;
  } else if (t == '2h') {
    return IntervalTime.h2;
  } else if (t == '4h') {
    return IntervalTime.h4;
  } else if (t == '6h') {
    return IntervalTime.h6;
  } else if (t == '8h') {
    return IntervalTime.h8;
  } else if (t == '12h') {
    return IntervalTime.h12;
  } else if (t == '1d') {
    return IntervalTime.d1;
  } else if (t == '3d') {
    return IntervalTime.d3;
  } else if (t == '1w') {
    return IntervalTime.w1;
  } else {
    return IntervalTime.M1;
  }
}

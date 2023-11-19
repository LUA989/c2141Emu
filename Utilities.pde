boolean getBit(int x, int pos) {
  return ((1 << pos) & x) != 0;
}

int setBit(int x, int pos) {
  return (1 << pos) | x;
}

int clearBit(int x, int pos) {
  return ~(1 << pos) & x;
}

int setBit(int x, int pos, boolean value) {
  if(value) {
    x = setBit(x, pos);
  } else {
    x = clearBit(x, pos);
  }
  
  return x;
}

int getValue(boolean[] bits) {
  int output = 0;
  for(int i = 0; i < min(bits.length, 32); i++) {
    output = setBit(output, i, bits[i]);
  }
  return output;
}

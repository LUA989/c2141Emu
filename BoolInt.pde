class BoolInt {
  boolean[] bits;
  
  BoolInt() {}
  
  BoolInt(boolean[] bits_) {
    bits = bits_;
  }
  
  BoolInt(int numberOfBits) {
    bits = new boolean[numberOfBits];
    for(int i = 0; i < numberOfBits; i++) {
      bits[i] = false;
    }
  }
  
  BoolInt(int value, int numberOfBits) {
    bits = new boolean[numberOfBits];
    for(int i = 0; i < numberOfBits; i++) {
      bits[i] = getBit(value, i);
    }
  }
  
  BoolInt(BoolInt integ) {
    bits = integ.bits;
  }
  
  void not() {
    for(int i = 0; i < bits.length; i++) {
      bits[i] = !bits[i];
    }
  }
  
  void and(BoolInt int2) {
    if(int2.bits.length <= bits.length) {
      for(int i = 0; i < min(bits.length, int2.bits.length); i++) {
        bits[i] &= int2.bits[i];
      }
    } else {
      System.err.println("Length of Boolean Integer is too big!");
    }
  }
  
  void or(BoolInt int2) {
    if(int2.bits.length <= bits.length) {
      for(int i = 0; i < min(bits.length, int2.bits.length); i++) {
        bits[i] |= int2.bits[i];
      }
    } else {
      System.err.println("Length of Boolean Integer is too big!");
    }
  }
  
  void xor(BoolInt int2) {
    if(int2.bits.length <= bits.length) {
      for(int i = 0; i < min(bits.length, int2.bits.length); i++) {
        bits[i] ^= int2.bits[i];
      }
    } else {
      System.err.println("Length of Boolean Integer is too big!");
    }
  }
  
  boolean add(BoolInt int2) {
    boolean carry = false;
    if(int2.bits.length <= bits.length) {
      for(int i = 0; i < min(bits.length, int2.bits.length); i++) {
        boolean oldBit = bits[i];
        bits[i] = (oldBit ^ int2.bits[i]) ^ carry;
        carry = (oldBit ^ int2.bits[i]) && carry || (oldBit && int2.bits[i]);
      }
    } else {
      System.err.println("Length of Boolean Integer is too much!");
    }
    return carry;
  }
  
  boolean sub(BoolInt int2) {
    int2.not();
    boolean carry = true;
    if(int2.bits.length <= bits.length) {
      for(int i = 0; i < min(bits.length, int2.bits.length); i++) {
        boolean oldBit = bits[i];
        bits[i] = (oldBit ^ int2.bits[i]) ^ carry;
        carry = (oldBit ^ int2.bits[i]) && carry || (oldBit && int2.bits[i]);
      }
    } else {
      System.err.println("Length of Boolean Integer is too much!");
    }
    return carry;
  }
  
  int getInt() {
    int output = 0;
    for(int i = 0; i < bits.length; i++) {
      output = setBit(output, i, bits[i]);
    }
    return output;
  }
  
  void setInt(int integ) {
    for(int i = 0; i < min(bits.length, 32); i++) {
      bits[i] = getBit(integ, i);
    }
  }
  
  String toString() {
    return "0x" + hex(getInt(), ceil(bits.length / 4));
  }
}

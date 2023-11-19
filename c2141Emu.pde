
BoolInt[] registers = new BoolInt[8];
BoolInt[] stack = new BoolInt[16];
byte[] opcodes = new byte[16];

void setup() {
  init();
  loadROM("roms/First Programs/inc.bin");
  exec();
  println("Registers:\n");
  printArray(registers);
}

void exec(byte opcode) {
  byte data = (byte)(opcode & 0xF);
  opcode = (byte)(((opcode & 0xF0) >> 4) & 0xF);
  
  switch(opcode) {
    case NOP:
    break;
    case NOT:
    registers[A].not();
    break;
    case AND:
    registers[A].and(registers[data & 0x7]);
    break;
    case OR:
    registers[A].or(registers[data & 0x7]);
    break;
    case XOR:
    registers[A].xor(registers[data & 0x7]);
    break;
    case ADD:
    registers[FLAGS].bits[0] = registers[A].add(registers[data & 0x7]);
    break;
    case SUB:
    registers[FLAGS].bits[0] = registers[A].sub(registers[data & 0x7]);
    break;
    case LDA:
    registers[A] = new BoolInt((int)data, 4);
    break;
    case CFA:
    registers[data & 0x7] = registers[A];
    break;
    case JMP:
    registers[PP] = new BoolInt((int)data, 4);
    registers[PP].sub(new BoolInt(1, 4));
    break;
    case JC:
    if(registers[FLAGS].bits[0]) {
      registers[PP] = new BoolInt((int)data, 4);
      registers[PP].sub(new BoolInt(1, 4));
    }
    break;
    case JNC:
    if(!registers[FLAGS].bits[0]) {
      registers[PP] = new BoolInt((int)data, 4);
      registers[PP].sub(new BoolInt(1, 4));
    }
    break;
    case STC:
    registers[FLAGS].bits[0] = true;
    break;
    case CLC:
    registers[FLAGS].bits[0] = false;
    break;
    case PSH:
    stack[registers[FLAGS].getInt()] = registers[A];
    registers[SP].add(new BoolInt(1, 4));
    break;
    case POP:
    registers[A] = stack[registers[FLAGS].getInt()];
    registers[SP].sub(new BoolInt(1, 4));
    break;
  }
}

void exec() {
  while(registers[PP].getInt() < 15) {
    exec(opcodes[registers[PP].getInt()]);
    delay(1000);
    printArray(registers);
    println();
    registers[PP].add(new BoolInt(1, 4));
  }
}

void init() {
  for(int i = 0; i < 16; i++) {
    registers[i & 0x7] = new BoolInt(0, 4);
    stack[i] = new BoolInt(0, 4);
    opcodes[i] = 0;
  }
}

void loadROM(String path) {
  byte[] commands = loadBytes(path);
  println("Loading ROM \"" + path + "\"...");
  opcodes = new byte[16];
  
  for(int i = 0; i < 16; i++) {
    opcodes[i] = 0;
  }
  
  for(int i = 0; i < min(16, commands.length); i++) {
    opcodes[i] = commands[i];
  }
  
  println("Loading Completed!");
}

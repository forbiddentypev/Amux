extern "C" void kmain();

static inline void outb(unsigned short port, unsigned char value) {
    asm volatile ("outb %0, %1" : : "a"(value), "Nd"(port));
}

static inline unsigned char inb(unsigned short port) {
    unsigned char ret;
    asm volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

static void serial_init() {
    outb(0x3F8 + 1, 0x00); // Disable all interrupts
    outb(0x3F8 + 3, 0x80); // Enable DLAB (set baud rate divisor)
    outb(0x3F8 + 0, 0x03); // Set divisor to 3 (lo byte) 38400 baud
    outb(0x3F8 + 1, 0x00); //                  (hi byte)
    outb(0x3F8 + 3, 0x03); // 8 bits, no parity, one stop bit
    outb(0x3F8 + 2, 0xC7); // Enable FIFO, clear them, with 14-byte threshold
    outb(0x3F8 + 4, 0x0B); // IRQs enabled, RTS/DSR set
}

static int serial_is_transmit_empty() {
    return inb(0x3F8 + 5) & 0x20;
}

extern "C" void kmain()
{
    volatile unsigned short *video = (volatile unsigned short*)0xB8000;
    
    // Print "Booting From Amux" to VGA
    const char *msg = "Booting From Amux";
    for (int i = 0; msg[i]; ++i) {
        video[1 + i] = 0x0F00 | (unsigned char)msg[i];
    }
    
    while (1) {
        __asm__ __volatile__("hlt");
    }
}

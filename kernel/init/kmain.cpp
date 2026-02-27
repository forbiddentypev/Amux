extern "C" void kmain();

extern "C" void kmain()
{
    const char *s = "Amux kernel booted\n";
    volatile unsigned short *video = (volatile unsigned short*)0xB8000;
    int col = 0;
    for (const char *p = s; *p; ++p) {
        unsigned char ch = *p;
        unsigned short attr = 0x0F;
        video[col++] = (attr << 8) | ch;
    }
    while (1) {
        __asm__ __volatile__("hlt");
    }
}

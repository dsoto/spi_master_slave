// SPI slave atmega328

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>


int main ()
{
    // set MISO as output
    DDRB = (1 << 4);
    // enable SPI
    SPCR = (1 << SPE);

    for(;;)
    {
        while(!(SPSR & (1 << SPIF)));
        int request = SPDR;
        if (request == 0x01) {
            SPDR = request << 1;
        }
        if (request == 0x02) {
            SPDR = request << 2;
        }

    }

}


// SPI slave atmega328

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

// todo: create internal counter and use interrupt architecture

volatile int i=0;

int main ()
{

    // set MISO as output
    DDRB = (1 << 4);
    // enable SPI
    SPCR |= (1 << SPE);
    // enable SPI interrupt
    SPCR |= (1 << SPIE);
    // enable global interrupts
    SREG = (1 << 7);

    for(;;)
    {

        i++;
        _delay_ms(50);
    }

}

ISR(SPI_STC_vect) {
    int request = SPDR;
    if (request == 0x01) {
        SPDR = request << 1;
    }
    if (request == 0x02) {
        // write high byte of counter variable to output register
        SPDR = i>>8;
        // wait until write is complete
        while(!(SPSR & (1<<SPIF)));
        // write out low byte to output register
        SPDR = i;
    }

}
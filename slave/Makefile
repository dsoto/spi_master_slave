MCU = atmega328
PROJECT = slave

# convert to hex file
$(PROJECT).hex: $(PROJECT).elf
	avr-objcopy -O ihex $(PROJECT).elf $(PROJECT).hex

# link libraries and startup code
$(PROJECT).elf: $(PROJECT).o
	avr-gcc -g -mmcu=$(MCU) -o $(PROJECT).elf $(PROJECT).o

# compile but do not yet link (-c supresses linking)
$(PROJECT).o: $(PROJECT).c
	avr-gcc -c -g -Os -mmcu=$(MCU) -o $(PROJECT).o $(PROJECT).c

# program the flash memory
program:$(PROJECT).hex
	avrdude -c usbtiny -p m328p -U flash:w:$(PROJECT).hex

bootload:$(PROJECT).hex
	avrdude -p m328p -c stk500v1 -P /dev/tty.usbserial-A700eYQo -b 57600 -F -U flash:w:slave.hex:i

fuse:$(PROJECT).hex
	avrdude -c usbtiny -p m328p -U lfuse:w:0xcc:m -U hfuse:w:0xd9:m -U efuse:w:0xff:m

clean:
	-rm *.o
	-rm *.hex
	-rm *.elf

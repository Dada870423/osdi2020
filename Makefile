#OSDI LAB 1

CC = aarch64-linux-gnu

all: kernel8.img

kernel8.img:  obj/main.o obj/uart.o obj/start.o
	${CC}-ld -Iinclude -T src/link.ld -o kernel8.elf obj/start.o obj/main.o obj/uart.o
	${CC}-objcopy -O binary kernel8.elf kernel8.img

obj/start.o: src/start.S
	${CC}-gcc -c src/start.S -o obj/start.o

obj/main.o: src/main.c
	${CC}-gcc -c src/main.c -o obj/main.o

obj/uart.o: src/uart.c
	${CC}-gcc -c src/uart.c -o obj/uart.o

clean:
	rm -f kernel8.elf
	rm -f obj/*

run:
	qemu-system-aarch64 -M raspi3 -kernel kernel8.img -serial null -serial stdio

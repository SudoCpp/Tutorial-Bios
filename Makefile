all:
	fasm Input.asm

run:
	qemu-system-x86_64 --drive format=raw,file=Input.bin

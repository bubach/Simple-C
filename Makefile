default:
	@echo Simple C Compiler
	@echo A port of Small C/386 to Linux
	@echo ------- building -------
	@cd src && gcc cc1.c cc2.c cc3.c cc4.c getarg.c -o ../bin/scc
	@cd src && as init.s -o../lib/init.o
	@echo ------- finished -------
	@echo Run "make install" as root please.
install:
	@rm -rf /usr/share/scc
	@mkdir /usr/share/scc
	@cp bin/scc /usr/bin
	@cp scripts/sc /usr/bin
	@cp scripts/sld /usr/bin
	@cp -r lib/* /usr/share/scc

	.text			# unix object-code files have segments. 
				# 	.text is where the code is.
				# 	These guys just have a knack for names.
	.align  16,0x90		# from crt0.S, 0x90 NOOP on Intel, no?
	.globl _start		# extraneous?
	.type _start,@function	
_start:				# GNU ld looks for _start. This is the address
				#   that goes in the ELF header, and the CPU 
				# begin execution of this program...
	popl %ecx		# get argc off the stack
	movl %ecx,argc		# save it to RAM as a  global symbol
	movl %esp,%ebx 		# snag argv 
	movl %ebx,argv  	# save also

	movl %esp,%eax 		# now there's some arithmatic to get to env
	andl $0xfffffff8,%esp	# I don't quite get this instruction.
	movl %ecx,%edx		# 
	addl %edx,%edx		# overly clever literal-less upshift
	addl %edx,%edx		#  	ditto
	addl %edx,%eax
	addl $4,%eax		#  now we know where environ is
	movl %eax, environ	#  name and store environ for C 

	.globl argc
	.globl argv

	call main		#  We hop over some cc function baggage,
				#  	i.e. I don't think we can just fall 
				#	into the C. This also skips over
				#	what's between here and our_world.




	movl argv, %ebx		# return value. probably don't want argc
	movl $1, %eax
	int $0x80


	.align  16,0x90	
	.size	_start,.-_start
	.globl environ
	.data
	.type environ,@object
	.align 4, 0
environ:
	.long 0
	.size environ,4
	.weak environ
	.type  argv,@object
	.align 4, 0
argc:	.long
	.long 0
argv:	.long 
	.long 0

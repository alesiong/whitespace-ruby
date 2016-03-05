require './wsv.rb'

WhiteSpace.new("fac.ws"){
	#fac
	push 100
	call :fac
	printnum
	exit

	label :fac
		dup
		push 1
		sub
		dup
		jz :end1
			call :fac
			mul
			ret
		label :end1
			discard
			ret
}

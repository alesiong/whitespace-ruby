require './wsv.rb'
WhiteSpace.new("fib.ws") {
push 1000
call :fib2
printnum
exit

label :fib
	dup
	push 2
	sub
	jn :end1
	dup
	push 1
	sub
	call :fib
	dup 2
	push 2
	sub
	call :fib
	add
	discard 1
	label :end1
		ret

label :fib2
	dup
	push 2
	sub
	jn :end
		push 0 #addr
		push 0 #value
		store
		push 1
		push 1
		store
		
		label :for
			push 1
			load
			dup
			push 0
			load
			add
			push 1
			swap
			store
			push 0
			swap
			store
			push 1
			sub
			dup
			push 2
			sub
			jn :endfor
			jump :for
		label :endfor
		discard
		push 1
		load
	label :end
		ret
}
=begin
if n 0
0
if n 1
1
a,b=0,1
1...n do a,b=b,a+b
b
1 1
=end

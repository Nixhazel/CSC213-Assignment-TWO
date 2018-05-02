.data
ent_a: .asciiz "\nEnter value of a: "
ent_b: .asciiz "\nEnter value of b: "
ent_c: .asciiz "\nEnter value of c: "
value_4: .float 4.0
value_2: .float 2.0
erro_msg: .asciiz "\nThis is a complex root, And your program has been terminated"
x1_ans: .asciiz "\nthe value of x1 is::  "
x2_ans: .asciiz "\nthe value of x2 is::  "
zero_value: .float 0.0
.text
main:
lwc1 $f15, zero_value
start_equation:
#ask user to enter a
li $v0, 4
la $a0, ent_a
syscall

li $v0, 6
syscall
mov.s $f14, $f0           # a is stored in $f14

#ask user to enter b
li $v0, 4
la $a0, ent_b
syscall

li $v0, 6
syscall
mov.s $f1, $f0           # b is stored in $f1

#ask user to enter c
li $v0, 4
la $a0, ent_c
syscall

li $v0, 6
syscall
mov.s $f2, $f0            # c is stored in $f2

# we are computing for d= b*b-4ac

# the value of b*b is stored in $f5
mul.s $f5, $f1, $f1

# putting 2.0 into  $f3
lwc1 $f3, value_2

# putting 4.0 int0  $f4
lwc1 $f4, value_4

#multiplying 4.0 by a
mul.s $f4,$f4, $f14

#multipying (4.0*a) by c
mul.s $f4, $f4, $f2            # 4.0*a*c is stored in $4

# this code is for b*b-4.0*a*c and storing it in $f6
sub.s $f6, $f5, $f4
mfc1 $t1, $f6
bltz $t1, start_complexroot

# this is computing the square root of D sqrt(d)
sqrt.s $f6, $f6

# making b into -b
sub.s $f7, $f15, $f1      # $f7 is holding -b

# this is  to solve for X1

# adding -b + sqrt (d)
add.s $f8, $f7, $f6

# $f9  is holding 2*a
mul.s $f9, $f3, $f14

# this divides -b + qrt(d) by 2*a
div.s $f10, $f8, $f9     # $f10 is holding x1

# this is to solve for X2

#substracting -b- sqrt(d)
sub.s $f11, $f7, $f6

# this is dividing -b-sqrt(d) by 2*a
div.s $f13, $f11, $f9      # $f13 is holding x2

# printing out x1
li $v0, 4
la $a0, x1_ans
syscall

li $v0, 2
mov.s $f12, $f10
syscall

# printing out x2
li $v0, 4
la $a0, x2_ans
syscall

li $v0, 2
mov.s $f12, $f13
syscall

b exit


end_equation:
start_complexroot:
#print out complex root then branch to exit
li $v0, 4
la $a0, erro_msg
syscall

b exit


end_complexroot:



exit:
li $v0, 10
syscall

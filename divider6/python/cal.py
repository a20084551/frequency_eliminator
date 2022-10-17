fi = 20*10**6 #20 MHz
print(format(fi,'.1E'))
fo= 6*10**6
print(format(fo,'.1E')) #A=67 MHz

N=32
N2=(2**N)/2
print(N2) #2147483648.0
M=(fo*2**N)/fi
print(M) #M=1288490188.8

c=1/(50*10**-9)
print(c)


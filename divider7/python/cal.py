fi = 20*10**6 #20 MHz
print(format(fi,'.1E'))
fo= fi*(36/8)
print(format(fo,'.1E')) #A=67 MHz


N=32
N2=(2**N)/2
print(N2) #(2N/2) = 2147483648
M=(fo*2**N)/fi
print(M) #M = 19327352832




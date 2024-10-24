[A,B,C,D] = linmod('ball1')
[num,den] = ss2tf(A,B,C,D);

step(num,den);
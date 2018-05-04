function w=lwbeta(k)
%logarithmic weighting
x=0.2;
w=(log(1+x)-log(k+x))/(log(1+x)-log(x));
clc;
clear all;

I=imread('lena.jpg'); 
N=5;
level=N;
B3 = [1/16 1/4 3/8 1/4 1/16];
h = B3'*B3;
A = double(I);
for level = 1:N
approx(:,:,level) = conv2(A, h, 'same'); %splot obrazu i filtru
D(:,:,level) = A - approx(:,:,level); % detal to r�nica mi�dzy obrazem pocz�tkowym a aproksymacj� 
A = approx(:,:,level);
end

D=abs(D(:,:,N));
J = (D > filter2(ones(3)/9, D)).* (D > mean2(D));

%[R C] = size(J);
%J(1:3, :) = 0;
%J(R-2:R, :) = 0;
%J(:, 1:3) = 0;
%J(:, C-2:C) = 0;

imshow(J);

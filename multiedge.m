function y=multiedge(obraz,s);
a=rgb2gray(obraz);
%utworzenie 3 mask dla operatora Sobela 
h1=[1 0 -1; 2 0 -2; 1 0 -1]; 
h2=[1 2 1;0 0 0;-1 -2 -1];
v=[1 2 1;2 4 2; 1 2 1];
%Splot obrazu z powy�szymi maskami
a1=filter2(h1,a);
a2=filter2(h2,a);
ns=h1;
for ii=1:s
nsh=conv2(ns,v);
p=max(max(ns))/max(max(nsh));
% Zwi�kszenie skali
ah1=filter2(v,a1)*p;
ah2=filter2(v,a2)*p;
ns=nsh;
% Rozr�nienie kraw�dzi i szumu
a1=a1.*(abs(a1)<=abs(ah1))+ah1.*(abs(a1)>abs(ah1));
a2=a2.*(abs(a2)<=abs(ah2))+ah2.*(abs(a2)>abs(ah2));
end
%Obraz ko�cowy jako suma uzyskanych obraz�w
e=(a1.^2+a2.^2);
% Eliminacja progowa - wi�ksze od otoczenia i jednocze�nie od �redniej
% ca�ego obrazu
y=(e>(filter2((ones(10))/100,e))).*(e>mean2(e));
imshow(y);
end
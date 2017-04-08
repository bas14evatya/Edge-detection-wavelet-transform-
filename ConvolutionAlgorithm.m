% ROW AND COLUMN CONVOLUTION ALGORITHM
% Jest to algorytm zaproponowany przez prof. Yahia Al-Halabi w artykule 
% "New wavelet-based techniques for edge detection" w Journal of
% Theoretical and Applied Information Technology 
% (http://www.jatit.org/volumes/research-papers/Vol23No1/5Vol23No1.pdf) 

%Wczytanie oraz przygotowanie obrazu do analizy. Obraz powinien by� w skali
%szaro�ci oraz macierz� typu uint8. 
function ConvolutionAlgorithm(obraz,wname);
I=rgb2gray(obraz);
I=double(I)/255;
[N,M] = size(I); 

%Utworzenie filtra g�rnoprzepustowego dla wybranej falki 
%HPD - high pass decomposition filter
[LO_D,HI_D,LO_R,HI_R] = wfilters(wname);

%Dla ka�dego wiersza i ka�dej kolumny wykonujemy splot z filtrem
%g�rnoprzepustowym.

for i=1:N
   %RDiff = Convolution (HI_D, IM(i, :))
    RDiff(i,:)= conv2(HI_D,I(i,:));  
end

for j=1:M
    %CDiff = Convolution (HI_D, IM( :, j));
    I1=I';
    CDiff(j,:)= conv2(HI_D,I1(j,:));
    CDiff1=CDiff';
end

%Nast�pnie uzyskane w ten spos�b 2 obrazy (jeden przy splocie po kolumnach,
%drugi po wierszach) ��czymy w jeden obraz. 
for i=1:N
   for j=1:M
      EM(i,j)=abs(CDiff1(i,j))+abs(RDiff(i,j)); 
   end
end

% W algorytmie w tym miejscu nast�puje jeszcze skalowanie tak, aby warto��
% ka�dego elementu w macierzy by�a z zakresu <0,1>. Nie jest to konieczne -
% ju� teraz warto�� ka�dego elementu macierzy EM mie�ci si� w tym zakresie.



%Tresholding - eliminacja progowa
%S�u�y do pokazania najbardziej istotnych pikseli. Zmieniaj�c warto�� progu
%mo�na zmieni� ilo�� pokazywanych kraw�dzi. 
prog=0.1;
for i=1:N
   for j=1:M
      if EM(i,j)<prog
      EM1(i,j)=0;
      else
      EM1(i,j)=1;
      end
   end
end

%Wy�wietlenie wyniku algorytmu oraz obrazu pocz�tkowego do por�wnania
subplot(1,2,1); imshow(I), title('Obraz poczatkowy');
subplot(1,2,2); imshow(EM1), title('Wykryte kraw�dzie');
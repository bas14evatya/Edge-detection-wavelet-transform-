function J = edgedet (obraz, N)
I=rgb2gray(obraz);
% undecimated wavelet transform - Stacjonarna Transformata Falkowa 
% UDWT - SWT (Stationary Wavelet Transform)
% ~ - wsp�czynniki aproksymacji, kt�re nie s� u�ywane
% detail - wsp�czynniki detali 
[~, detail] = a_trous(I, N);
% detail jest macierz� o wymiarach (a,b,N), gdzie a i b to wymiary obrazu,
% a N to poziom SWT  
% modu� z falkowych wsp�czynnik�w detali
D = abs( detail(:,:,N) );
% D to macierz warto�ci bezwzgl�dnej wsp�czynnik�w detali najwy�szego
% rz�du. W ten spos�b otrzymujemy tylko liczby dodatnie - liczby
% najbardziej odleg�e od zera odpowiadaj� najostrzejszym kraw�dziom. 
% odfiltrowanie najbardziej istotnych pikseli
J = (D>filter2(ones(3)/9,D)).*(D>mean2(D));
% zachowywane s� tylko te piksele, kt�rych warto�� jest wi�ksza od ich
% najbli�szego otoczenia, oraz jednocze�nie od �redniej warto�ci
% "Wyczyszczenie" kraw�dzi obrazu 
[R C] = size(J);
J(1:3, :) = 0;
J(R-2:R, :) = 0;
J(:, 1:3) = 0;
J(:, C-2:C) = 0;
subplot(1,2,1); imshow(I), title('Obraz poczatkowy');
subplot(1,2,2); imshow(J), title('Wykryte kraw�dzie');
clear all;
clc;

img = imread('kids.tif');
[n, m] = size(img);
%%%%%%%%%%%%%%%%% Echantillonnage %%%%%%%%%%%%%%%%%

fact = 15;

newN = floor(n / fact);
newM = floor(m / fact);
min_img = img((1:newN) * fact, (1:newM) * fact);

subplot(131), imshow(img), title('Original');
subplot(132), imshow(min_img), title('Min');

newN2 = n * fact;
newM2 = m * fact;
max_img = imresize(img, [newN2, newM2]);

subplot(133), imshow(max_img), title('Max');

%%%%%%%%%%%%%%%%% Quantification %%%%%%%%%%%%%%%%%


% *************** Niveau Noir et Blanc *************
%{
q = 2;
new_img = zeros(n, m);
for i = 1:n
  for j = 1:m
    L = 255 / q;
    if img(i, j) < L
      new_img(i, j) = 0;
    else
      new_img(i, j) = 1;
    end
  end
end
subplot(121), imshow(img), title('Original');
subplot(122), imshow(new_img), title('Niveau Noir et Blanc');
%}
  

%********************** 8 Niveau gris *****************************

%{
q = 8; 
new_img = zeros(n, m);
x = linspace(0, 255, q + 1); 
for i = 1:n
  for j = 1:m
    for niveau = 1:q
      if img(i, j) < (niveau + 1)
        new_img(i, j) = niveau - 1;
        break; 
      end
    end
  end
end


subplot(121), imshow(img), title('Original');
subplot(122), imshow(new_img, [0 q-1]), title('8 Niveau de gris');
%}

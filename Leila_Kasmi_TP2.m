clear all;
clc;

img = imread('kids.tif');
%im_noise = imnoise(img, 'salt & pepper', 0.05);
im_noise = imnoise(img, 'speckle', 0.1);
%im_noise = imnoise(img, 'gaussian', 0, 0.01);

%*********************** Filtres linéaires ***********************

%%%%%%%%%%%%%%%%% Filtre Moyennage %%%%%%%%%%%%%%%%%

h = ones(3,3) / 9;
im_mean = imfilter(img, h);
subplot(121), imshow(im_noise), title('Image originale');
subplot(122), imshow(im_mean), title('Filtre Moyen');


%%%%%%%%%%%%%%%%% Filtre gaussien %%%%%%%%%%%%%%%%%
%{
h = fspecial('gaussian', 5, 1);
im_gaus = imfilter(im_noise, h);
subplot(121), imshow(im_noise), title('Image originale');
subplot(122), imshow(im_gaus), title('Filtre gaussien');
%}

%*********************** Filtres non linéaires %***********************

%%%%%%%%%%%%%%%%% Filtre Median  et Max et Min %%%%%%%%%%%%%%%%%
%{
kernel_size = 3;
img_median = medfilt2(im_noise, [kernel_size kernel_size]);
img_min = ordfilt2(im_noise, 1, ones(kernel_size), 'symmetric');
img_max = ordfilt2(im_noise, kernel_size^2, ones(kernel_size), 'symmetric');

subplot(2,2,1), imshow(im_noise), title('Image originale')
subplot(2,2,2), imshow(img_median), title('Filtre médian')
subplot(2,2,3), imshow(img_min), title('Filtre min')
subplot(2,2,4), imshow(img_max), title('Filtre max')
%}

%*********************** Détecteurs de contours du premier ordre ***********************

%%%%%%%%%%%%%%%%% Filtre de Robert %%%%%%%%%%%%%%%%%
%{
hx=[-1 0; 0 1];
hy=[0 -1; 1 0];
Rx = imfilter(double(img), hx); 
Ry = imfilter(double(img), hy); 
R=sqrt(Rx.^2 + Ry.^2);

subplot(2,2,1); imshow(img);title('Image originale');
subplot(2,2,2); imshow(uint8(Rx));title('Contour Horizontal');
subplot(2,2,3); imshow(uint8(Ry));title('Contour Vertical');
subplot(2,2,4); imshow(uint8(R));title('Module du Contour');
%}

%%%%%%%%%%%%%%%%% Filtre de Perwitt %%%%%%%%%%%%%%%%%
%{
hx = [-1 0 1; -1 0 1; -1 0 1]; 
hy = hx';
Rx = filter2(hx, img);
Ry = filter2(hy, img);
R = sqrt(Rx.*Rx + Ry.*Ry);

subplot(2,2,1); imshow(img);title('Image originale');
subplot(2,2,2); imshow(uint8(Rx));title('Contour Horizontal');
subplot(2,2,3); imshow(uint8(Ry));title('Contour Vertical');
subplot(2,2,4); imshow(uint8(R));title('Module du Contour');
%}

%%%%%%%%%%%%%%%%% Filtre de Sobel %%%%%%%%%%%%%%%%%
%{
hx = [-1 0 1; -2 0 2; -1 0 1];
hy = [-1 -2 -1; 0 0 0; 1 2 1];

Rx = imfilter(double(img), hx); 
Ry = imfilter(double(img), hy);
R = sqrt(Rx.^2 + Ry.^2);

subplot(2,2,1); imshow(img);title('Image originale');
subplot(2,2,2); imshow(uint8(Rx));title('Contour Horizontal');
subplot(2,2,3); imshow(uint8(Ry));title('Contour Vertical');
subplot(2,2,4); imshow(uint8(R));title('Module du Contour');
%}

%*********************** Détecteurs de contours du second ordre ***********************

%%%%%%%%%%%%%%%%% Filtre de Laplace %%%%%%%%%%%%%%%%%

%{
h4 = [0 1 0; 1 -4 1; 0 1 0];  
h8 = [1 1 1; 1 -8 1; 1 1 1]; 

R4 =filter2(h4,img); 
R8 =filter2(h8,img); 

subplot(2,2,1); imshow(img); title('Image originale');
subplot(2,2,2); imshow(uint8(R4)); title('Contour 4-connexions');
subplot(2,2,3); imshow(uint8(R8)); title('Contour 8-connexions');
%}







clear;
close all;
% Localizzazione:
% Se fosse noto che lo sfondo è sempre uniforme e uguale potrei
% usare semplicemente otsu per segmentare. Dato che questa 
% supposizione è troppo limitante è necessario fare segmentazione
% tramite classificazione usando dei vettori di features di texture.
% Sono stati effettuati dei tentativi con le maschere di Laws e 
% i filtri di gabor (aggiungo slide presentazione)

im = imread("salvia_training.jpg");
im = rgb2gray(im);
%im = imresize(im, 0.5);
im = medfilt2(im, [23, 23]);
energy_masks = laws(im, 5); % output di 9 maschere della grandezza dell'immagine

%figure(1), imshow(im);
%figure(2), imshow(energy_masks{1});
%figure(3), imshow(energy_masks{2});
%figure(4), imshow(energy_masks{3});
%figure(5), imshow(energy_masks{4});
%figure(6), imshow(energy_masks{5});
%figure(7), imshow(energy_masks{6});
%figure(8), imshow(energy_masks{7});
%figure(9), imshow(energy_masks{8});
%figure(10), imshow(energy_masks{9});

matr_masks = cat(3, energy_masks{:});
matr_masks = im2double(matr_masks);
[righe, colonne, canali] = size(matr_masks);
matr_varianza = zeros(righe, colonne, canali);

% Calcolo varianza in una finestra specifica per ogni maschera
for i = 1:9
    % Dimensione della finestra
    windowSize = [7 7];
    
    % Crea un filtro di media normalizzato
    h = fspecial('average', windowSize);
    
    % Calcola la media locale
    meanLocal = imfilter(matr_masks(:,:,i), h, 'same');
    
    % Calcola la media locale dei quadrati
    meanSquareLocal = imfilter(matr_masks(:,:,i).^2, h, 'same');
    
    % Calcola la varianza locale
    localVariance = meanSquareLocal - meanLocal.^2;
    matr_varianza(:,:,i) = localVariance; 
end

% Ogni riga rappresenta un punto dati e la colonna le features
vettore_features = reshape(matr_varianza, righe*colonne, canali);
k = 2; % cluster: foglia/non foglia
id = kmeans(vettore_features, k);
img_fin = reshape(id, righe, colonne);
img_bin = imbinarize(img_fin, 1);
figure, imshow(img_bin);




%labels = bwlabel(imB);
%figure(2), imagesc(labels), axis image, colorbar;
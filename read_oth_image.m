clear;
close all;

% Immagini con sfondi differenti per irrobustire locator
num_img_training = 10; 
target_size = [1064, 1064, 3];
immagini_tr = zeros([target_size, num_img_training], 'uint8');
immagini_gt = false([target_size(1:2), num_img_training]);

% Sfondo legno
immagini_tr(:,:,:,1) = imresize(imread("Training/Legno/oleandro_training.png"), target_size(1:2));
immagini_tr(:,:,:,2) = imresize(imread("Training/Legno/ciclamino_training.png"), target_size(1:2));
immagini_tr(:,:,:,3) = imresize(imread("Training/Legno/ulivo_training.png"), target_size(1:2));
immagini_tr(:,:,:,4) = imresize(imread("Training/Legno/rosmarino_training.png"), target_size(1:2));
immagini_tr(:,:,:,5) = imresize(imread("Training/Legno/prezzemolo_training.png"), target_size(1:2));
immagini_tr(:,:,:,6) = imresize(imread("Training/Legno/edera_training.png"), target_size(1:2));
immagini_tr(:,:,:,7) = imresize(imread("Training/Legno/alloro_training.png"), target_size(1:2));
immagini_tr(:,:,:,8) = imresize(imread("Training/Legno/quercia_training.png"), target_size(1:2));
immagini_tr(:,:,:,9) = imresize(imread("Training/Legno/auroceraso_training.png"), target_size(1:2));
immagini_tr(:,:,:,10) = imresize(imread("Training/Legno/trifoglio_training.png"), target_size(1:2));

% Sfondo rosso

% Sfondo verde

% Sfondo blu

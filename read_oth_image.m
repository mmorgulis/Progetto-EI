clear;
close all;

% Immagini con sfondi differenti per irrobustire locator
num_img_oth = 10; 
target_size = [1064, 1064, 3];
immagini_sf = zeros([target_size, num_img_oth], 'uint8');

% Sfondo legno
immagini_sf(:,:,:,1) = imresize(imread("Training/Legno/oleandro_training.png"), target_size(1:2));
immagini_sf(:,:,:,2) = imresize(imread("Training/Legno/ciclamino_training.png"), target_size(1:2));
immagini_sf(:,:,:,3) = imresize(imread("Training/Legno/ulivo_training.png"), target_size(1:2));

% Sfondo rosso
immagini_sf(:,:,:,4) = imresize(imread("Training/Rosso/rosmarino_trainingR.jpg"), target_size(1:2));
immagini_sf(:,:,:,5) = imresize(imread("Training/Rosso/prezzemolo_trainingR.jpg"), target_size(1:2));
immagini_sf(:,:,:,6) = imresize(imread("Training/Rosso/edera_trainingR.jpg"), target_size(1:2));

% Sfondo verde
immagini_sf(:,:,:,7) = imresize(imread("Training/Verde/alloro_trainingG.jpg"), target_size(1:2));
immagini_sf(:,:,:,8) = imresize(imread("Training/Verde/quercia_trainingG.jpg"), target_size(1:2));
immagini_sf(:,:,:,9) = imresize(imread("Training/Verde/lauroceraso_trainingG.jpg"), target_size(1:2));

% Sfondo blu
immagini_sf(:,:,:,10) = imresize(imread("Training/Blu/trifoglio_trainingB.jpg"), target_size(1:2));

save("im_training_oth.mat", "immagini_sf", "num_img_oth");
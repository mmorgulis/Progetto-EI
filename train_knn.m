clear;
close all;

num_img_training = 6;
target_size = [1064, 1064, 3]; 
finestra = 11; % scelta empiricamente

% Preallocazione delle matrici
immagini_tr = zeros([target_size, num_img_training], 'uint8');
immagini_gt = false([target_size(1:2), num_img_training]);
immagini_test = zeros([target_size, num_img_training], 'uint8');
immagini_gt_test = false([target_size(1:2), num_img_training]);

% Caricamento e ridimensionamento immagini
immagini_tr(:,:,:,1) = imresize(imread("Training/oleandro_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,2) = imresize(imread("Training/salvia_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,3) = imresize(imread("Training/ulivo_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,4) = imresize(imread("Training/rosmarino_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,5) = imresize(imread("Training/prezzemolo_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,6) = imresize(imread("Training/edera_training.jpg"), target_size(1:2));

immagini_gt(:,:,1) = imresize(im2gray(imread("Gt/Train/gt_oleandro_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,2) = imresize(im2gray(imread("Gt/Train/gt_salvia_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,3) = imresize(im2gray(imread("Gt/Train/gt_ulivo_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,4) = imresize(im2gray(imread("Gt/Train/gt_rosmarino_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,5) = imresize(im2gray(imread("Gt/Train/gt_prezzemolo_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,6) = imresize(im2gray(imread("Gt/Train/gt_edera_training.png")) > 0, target_size(1:2));

% Prealloco le feature e le label
all_features = [];
all_labels = [];

for i = 1:num_img_training
    im = immagini_tr(:,:,:,i);
    gt = immagini_gt(:,:,i);
    
    features = compute_all_loc_features(im, finestra);
    [r, c, num_features] = size(features);
    features_reshaped = reshape(features, r * c, num_features);
    
    labels_reshaped = gt(:);
    
    all_features = [all_features; features_reshaped];
    all_labels = [all_labels; labels_reshaped];
end

X = all_features;
Y = all_labels;

% Creo e alleno il modello kNN
C = fitcknn(X, Y, 'NumNeighbors', 7);

save("data.mat", "C", "finestra", "target_size", "num_img_training");
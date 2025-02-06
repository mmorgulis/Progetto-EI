clear;
close all;

load("im_training.mat"); 
finestra = 11; % scelta empiricamente

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

save("locator.mat", "C", "finestra", "target_size", "num_img_training");
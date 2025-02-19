clear;
close all;

load("im_training.mat");
load("im_training_oth.mat");

finestra = 5; % scelta empiricamente

% Prealloco le feature e le label
all_features = [];
all_labels = [];

% Concateno le immagini lungo la quarta dimensione
images_combined = cat(4, immagini_tr, immagini_sf);
% Concateno gt lungo la 3 dimensione
gt_combined = cat(3, immagini_gt, immagini_gt_oth);

total_images = num_img_training + num_img_oth;

% Per ogni img calcolo le features 
for i = 1:total_images
    curr_img = images_combined(:,:,:,i);
    curr_gt = gt_combined(:,:,i);
    
    features = compute_all_loc_features(curr_img, finestra);
    [r, c, num_features] = size(features);
    features_reshaped = reshape(features, r * c, num_features);
    
    labels_reshaped = curr_gt(:);
    
    all_features = [all_features; features_reshaped];
    all_labels = [all_labels; labels_reshaped];
end

X = all_features;
Y = all_labels;
  
% Creo e alleno il modello kNN
C = fitcknn(X, Y, 'NumNeighbors', 5);

% Se voglio un modello più veloce ma meno preciso
% C = fitctree(X, Y, ...
%     'MaxNumSplits', 100, ...     % Limite profondità
%     'PruneCriterion', 'error');

save("locator.mat", "C", "finestra", "target_size", '-v7.3');
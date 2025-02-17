clear;
close all;

load("locator.mat"); 
load("im_training.mat");

[train_labels] = read_tr(); % leggo file delle etichette

features = [];
labels = [];
num_comp_conn = 14;

% Per ogni img trovo le foglie con il localizzatore
% e alleno il classificatore
for i = 1:num_img_training
    im = immagini_tr(:,:,:,i);
    gt = im2double(immagini_gt(:,:,i));
    % Se non avessi le gt :
    % leaf = localize_leaf(im);
    % leaf_labels = bwlabel(leaf);
    leaf_labels = bwlabel(gt);
    area = regionprops(leaf_labels, 'Area');
    filter = find([area.Area] >= 300); % potrebbe esserci del rumore
    labels_filtered = ismember(leaf_labels, filter);
    labels_final = bwlabel(labels_filtered);
    num_comp_conn = max(max(labels_final));
    
    % Le componenti connesse devono essere 14, cioè il numero delle
    % foglie di train per immagine
    if (num_comp_conn ~= 14)
        figure, imagesc(labels_final), axis image, colorbar;
        error("Errore numero componenti connesse");
    end

    % Per ogni componente connessa calcolo features
    for j = 1:num_comp_conn
        foglia_bin = labels_final == j;
        foglia_bin_3d = repmat(foglia_bin, [1 1 3]);
        foglia_rgb = im .* uint8(foglia_bin_3d);
        features_foglia = compute_all_class_features(foglia_rgb);
        features_reshaped = reshape(features_foglia, 1, []);
        features = [features; features_reshaped];
    end
end

%norm_features = normalize_feature(features);

X = features;
Y = train_labels;

Cl = fitcknn(X, Y, 'NumNeighbors', 7);

predicted_train = predict(Cl, X);
cm_train = confmat(Y, predicted_train);
figure(1);
show_confmat(cm_train.cm_raw, cm_train.labels);
title("Recall");
fprintf('Train Accuracy: %f\n', cm_train.accuracy);

save("classificator.mat", "Cl");
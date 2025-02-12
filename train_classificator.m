clear;
close all;

load("locator.mat"); 
load("im_training.mat");

[train_labels] = read(); % leggo file delle etichette

features = [];
labels = [];
% Per ogni img trovo le foglie con il localizzatore
% e alleno il classificatore
for i = 1:num_img_training
    im = immagini_tr(:,:,:,i);
    leaf = localize_leaf(im);
    leaf_labels = bwlabel(leaf);
    area = regionprops(leaf_labels, 'Area');
    filter = find([area.Area] >= 400); % le foglie hanno area maggiore
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
        labels = [labels; i];
    end
end

X = features;
Y = labels;

Cl = fitcknn(X, Y, 'NumNeighbors', 7);

% TEST CLASSIFICATORE
load("im_test.mat");

features_test = [];
test_labels = [];
for i = 1:num_img_training
    im = immagini_test(:,:,:,i);
    leaf = localize_leaf(im);
    leaf_labels = bwlabel(leaf);
    area = regionprops(leaf_labels, 'Area');
    filter = find([area.Area] >= 100);
    labels_filtered = ismember(leaf_labels, filter);
    labels_final = bwlabel(labels_filtered);
    num_comp_conn = max(max(labels_final));

    if (num_comp_conn ~= 6)
        figure, imagesc(labels_final), axis image, colorbar;
        error("Errore numero componenti connesse");
    end
    
    for j = 1:num_comp_conn
        foglia_bin = labels_final == j;
        foglia_bin_3d = repmat(foglia_bin, [1 1 3]);
        foglia_rgb = im .* uint8(foglia_bin_3d);
        features_test_foglia = compute_all_class_features(foglia_rgb);
        features_test_reshaped = reshape(features_test_foglia, 1, []);
        features_test = [features_test; features_test_reshaped];
        test_labels = [test_labels; i];
    end
end

predicted_train = predict(Cl, X);
predicted_test = predict(Cl, features_test);

cm_train = confmat(Y, predicted_train);
cm_test = confmat(test_labels, predicted_test);

figure(1);
show_confmat(cm_train.cm_raw, cm_train.labels);
title("Train");

figure(2);
show_confmat(cm_test.cm_raw, cm_test.labels);
title("Test");

fprintf('Train Accuracy: %f\n', cm_train.accuracy);
fprintf('Test Accuracy: %f\n', cm_test.accuracy);

save("classificator.mat", "Cl");
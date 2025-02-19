clear;
close all;

% TEST CLASSIFICATORE
load("im_test.mat");
load("classificator.mat");

features_test = [];
test_labels = read_te();
for i = 1:num_img_training
    im_test = immagini_test(:,:,:,i);
    gt_test = im2double(immagini_gt_test(:,:,i));

    % Se non ho le gt
    %leaf = localize_leaf(im_test);
    %leaf_labels = bwlabel(leaf);

    leaf_labels = bwlabel(gt_test);
    area = regionprops(leaf_labels, 'Area');
    filter = find([area.Area] >= 300);
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
        foglia_rgb = im_test .* uint8(foglia_bin_3d);
        features_test_foglia = compute_all_class_features(foglia_rgb);
        features_test_reshaped = reshape(features_test_foglia, 1, []);
        features_test = [features_test; features_test_reshaped];
    end
end

predicted_test = predict(Cl, features_test);

cm_test = confmat(test_labels, predicted_test);

figure(1);
show_confmat(cm_test.cm_raw, cm_test.labels);
title("Precision");

fprintf('Test Accuracy: %f\n', cm_test.accuracy);
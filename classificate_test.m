% TEST CLASSIFICATORE
load("im_test.mat");
load("classificator.mat");

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

%norm_features_test = normalize_feature(features_test);

predicted_test = predict(Cl, features_test);

cm_test = confmat(test_labels, predicted_test);

figure(1);
show_confmat(cm_test.cm_raw, cm_test.labels);
title("Precision");

fprintf('Test Accuracy: %f\n', cm_test.accuracy);
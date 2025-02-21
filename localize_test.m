clear;
close all;

load("locator.mat");   
load("im_test.mat");

% Calcolo le performance sul test-set
test_all_features = [];
for i = 1:num_img_training
    test_features = compute_all_loc_features(immagini_test(:,:,:,i), finestra);
    [tr, tc, t_num_features] = size(test_features);
    test_features_reshaped = reshape(test_features, tr * tc, t_num_features);
    
    % Predizione kNN per l'immagine corrente
    pred_labels = predict(C, test_features_reshaped);
    
    pred_image = reshape(pred_labels, [tr, tc]);
    
    % Post Processing
    pred_image = imfill(pred_image, "holes"); % slide
    
    gt_logical = logical(immagini_gt_test(:,:,i));
    pred_logical = logical(pred_image);

    % Visualizzo i risultati
    figure;
    subplot(1, 3, 1);
    imshow(immagini_test(:,:,:,i));
    title('Immagine di Test');
    
    subplot(1, 3, 2);
    imshow(pred_image, []);
    title('Predizione kNN');
    
    subplot(1, 3, 3);
    imshow(immagini_gt_test(:,:,i));
    title(['Ground Truth']);
    
    % Uso ConfMat
    cm_test = confmat(gt_logical, pred_logical);
    figure;
    show_confmat(cm_test.cm_raw, cm_test.labels);
    title("Test");
    
    fprintf('Test Accuracy: %f\n', cm_test.accuracy);
      
end


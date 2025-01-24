function img_bin = local_vector(img)

    % Per localizzare le foglie utilizzo un vettore di features
    % composto da:
    % 1. varianza
    % 2. colore medio nell'intorno

    im = im2double(img);
    [righe, colonne, ~] = size(im);
    features_vector = zeros(righe, colonne, 2);
    
    im_gray = im2gray(im);
    
    % Calcolo vettore features
    features_vector(:, :, 1) = compute_local_var(im_gray, 31);
    features_vector(:, :,2) = compute_local_col(im, 31); 
    
    % Uso k-means per classificare foglia/non foglia
    features_vector = reshape(features_vector, righe*colonne, 2);
    id = kmeans(features_vector, 2);
    img_fin = reshape(id, righe, colonne);
    img_bin = img_fin > 1;

end



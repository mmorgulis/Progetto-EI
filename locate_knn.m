function locate_knn()
    % Per fare knn leggo tutte le ground_truth
    % in cui 0 = sfondo e 1 = foglia e alleno knn
    immagini_tr = cell(1, 3); % array di celle 1x3
    immagini_tr{1} = imread("oleandro_training.jpg");
    immagini_tr{2} = imread("salvia_training.jpg");
    immagini_tr{3} = imread("ulivo_training.jpg");
    
end


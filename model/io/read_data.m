function [ dataset ] = read_data( data_path, n_imgs )
    %LOAD_DATA Load data and standardize data
    
    dataset = cell(1, n_imgs);
    for i = 1 : n_imgs
        img_path = [data_path, 'testimg', num2str(i), '.jpg'];
        img = imresize(single(imread(img_path)), [224, 224]);
        img(:, :, 1) = img(:, :, 1) - 103.939;
        img(:, :, 2) = img(:, :, 2) - 116.779;
        img(:, :, 3) = img(:, :, 3) - 123.68;
        dataset{1, i} = img;
    end 
end


function [ bu1, pool_map, pool_cord ] = forward( ...
    input_img, krnls, bias, fc_params, fc_bias )
    %FORWARD Generate VGG16 bottom-up saliency map.
    %   Args:
    %     input_img: Input image, size = [ 224 * 224 * 3 ]
    %     krnls: VGG16 convolutional kernels, 5*3 cell array
    %     bias: VGG16 convolutional bias, 5*3 cell array
    %     fc_params: VGG16 full-connected layer weights, 3*1 cell array
    %     fc_bias: VGG16 full-connected layer bias, 3*1 cell array
    %   Returns:
    %     bu1: bottom-up saliency map 1, 8*3 cell array
    %            i.e. convolutional feature map, corresponding to conv krnl
    %     pool_map: max pooling feature maps, 1*5 cell array
    %     pool_cord: max pooling coordinates, 1*5 cell array
    %     result: classification result,
    %               result(1): class probability, result(2): class id
    %   Notes:
    %       For VGG16 architecture, see 
    %         http://www.robots.ox.ac.uk/%7Evgg/research/very_deep/.
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    bu1 = cell(5, 3);
    pool_map = cell(1, 5);
    pool_cord = cell(1, 5);
    
    bu1{1, 1} = conv2d(input_img, krnls{1, 1}, bias{1, 1});
    bu1{1, 2} = conv2d(bu1{1, 1}, krnls{1, 2}, bias{1, 2});
    [pool_map{1}, pool_cord{1}] = maxpool(bu1{1, 2});

    bu1{2, 1} = conv2d(pool_map{1}, krnls{2, 1}, bias{2, 1});
    bu1{2, 2} = conv2d(bu1{2, 1}, krnls{2, 2}, bias{2, 2}); 
    [pool_map{2}, pool_cord{2}] = maxpool(bu1{2, 2});

    bu1{3, 1} = conv2d(pool_map{2}, krnls{3, 1}, bias{3, 1});
    bu1{3, 2} = conv2d(bu1{3, 1}, krnls{3, 2}, bias{3, 2});
    bu1{3, 3} = conv2d(bu1{3, 2}, krnls{3, 3}, bias{3, 3});
    [pool_map{3}, pool_cord{3}] = maxpool(bu1{3, 3});

    bu1{4, 1} = conv2d(pool_map{3}, krnls{4, 1}, bias{4, 1});
    bu1{4, 2} = conv2d(bu1{4, 1}, krnls{4, 2}, bias{4, 2});
    bu1{4, 3} = conv2d(bu1{4, 2}, krnls{4, 3}, bias{4, 3});
    [pool_map{4}, pool_cord{4}] = maxpool(bu1{4, 3});

    bu1{5, 1} = conv2d(pool_map{4}, krnls{5, 1}, bias{5, 1});
    bu1{5, 2} = conv2d(bu1{5, 1}, krnls{5, 2}, bias{5, 2});
    bu1{5, 3} = conv2d(bu1{5, 2}, krnls{5, 3}, bias{5, 3});   
    [pool_map{5}, pool_cord{5}] = maxpool(bu1{5, 3});
    
    x = conv2fc(pool_map{5});
    bu1{6, 1} = fcforward(x, fc_params{1}, fc_bias{1});
    bu1{7, 1} = fcforward(bu1{6, 1}, fc_params{2}, fc_bias{2});
    bu1{8, 1} = fcforward(bu1{7, 1}, fc_params{3}, fc_bias{3});
       
end


function [ y ] = fcforward(x, weights4d, b)
    %FCFORWARD full-connected layer feedforward
    %  weights4d: [ map_size * map_size * n_krnls * output_size ]
    %  weights4d -> W: [ output_size * n ]
    
    [map_size, ~, n_krnls, output_size] = size(weights4d);
    n = map_size * map_size * n_krnls;
    W = reshape(weights4d, [n, output_size])'; % Transportation
    y = max(W * x + b, 0); % ReLU
    
end










































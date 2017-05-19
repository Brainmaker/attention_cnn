function [ pooled_map, pooled_map_cord ] = maxpool( input_map )
    %MAXPOOL 2-D max pooling of multidimensional array
    %   Args:
    %     input_map: [ input_size * input_size * deepth ]
    %   Returns:
    %     pooled_map: [ pooled_size * pooled_size * deepth ]
    %     pooled_map_cord: max element coordinate in input,
    %                      [ coordinate * pooled_size * pooled_size * deepth ]
    %                      coordinate = ( row, col )
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    [input_size, ~, deepth] = size(input_map);
    pooled_size = input_size / 2;
    n_samples = pooled_size * pooled_size;
    
    pooled_map = zeros(deepth, n_samples);
    pooled_map_cord = zeros(pooled_size, pooled_size, 2, deepth);
    
    % input_map: [ (4*deepth) * pooled_size^2 ]
    input_map = pool2col(input_map);
    
    for i = 1 : deepth
        [pooled_map(i, :), id_patch] = max(input_map((4*i-3):(4*i), :));
        [col, row] = id2cord(id_patch, 2); % inverse      
        [row_cord, col_cord] = id2cord(1:n_samples, pooled_size); 
        pooled_map_cord(:, :, :, i) = ...
            cat(3, col2im(row+2*row_cord-2), col2im(col+2*col_cord-2));
    end
    pooled_map = col2im(pooled_map);
    
end


function [ row, col ] = id2cord( id, size_ )
    %ID2CORD
    id = id - 1;
    col = rem(id, size_) + 1;
    row = fix(id / size_) + 1;
end
































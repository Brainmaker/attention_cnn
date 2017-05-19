function [ output ] = pool2col( tensor3d )
    %POOL2COL Rearrange 2*2*deepth pooled map patch to matrix column
    %   Args:
    %     tensor3d: [ map_size * map_size * deepth ]
    %   Returns:
    %     output: [ (4*deepth) * (pooled_size*pooled_size) ]
    %   Notes:
    %     In VGG16, pooled_size = map_size / 2.
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    [map_size, ~, deepth] = size(tensor3d);
    pooled_size = map_size / 2;
    output = zeros(4*deepth, pooled_size^2);
    k = 1;
    for i = 1 : 2 : map_size
        for j = 1 : 2 : map_size
            patch = tensor3d(i:i+1, j:j+1, :);
            output(:, k) = reshape(patch, [4 * deepth, 1]);
            k = k + 1;
        end
    end
end


function [ td ] = backward(...
        input_img, prior, bu1, pool_map, pool_cord, krnl, fc_param, ...
        hp, use_contra ...
    )
    %BACKWARD Generate top-down saliency map
    %   Args:
    %     input_img: The original image.
    %     prior: Prior infomation.
    %     bu1: Buttom-up saliency map
    %     pool_map: Pooled map.
    %     pool_cord: Max element index in pool map
    %     krnl: Convolutional kernel.
    %     fc_param: Full-connected layer weights.
    %     hp: Hyperparameters
    %     use_contra: If this option is true, backward() will generate the pruned processing tree.
    %   Returns:
    %     td: Top-down saliency map, 8*3 cell array, corresponding to bu1.
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
   
    td = cell(8, 3);
    beta = hp.beta;

    td{8, 1} = calc_tdmap(prior, bu1{7, 1}, ...
        fcp2col(fc_param{3}), beta{8, 1});
    td{7, 1} = calc_tdmap(td{8, 1}, bu1{6, 1}, ...
        fcp2col(fc_param{2}), beta{7, 1});
    td{6, 1} = calc_tdmap(td{7, 1}, conv2fc(pool_map{5}), ...
        fcp2col(fc_param{1}), beta{6, 1});
    
    if use_contra
        % Generate uniform distribution
        uni_prior = ones(size(prior)) / numel(prior);
        
        uni_td_81 = calc_tdmap(uni_prior, bu1{7, 1}, ...
            fcp2col(fc_param{3}), beta{8, 1});
        uni_td_71 = calc_tdmap(uni_td_81, bu1{6, 1}, ...
            fcp2col(fc_param{2}), beta{7, 1});
        uni_td_61 = calc_tdmap(uni_td_71, conv2fc(pool_map{5}), ...
            fcp2col(fc_param{1}), beta{6, 1});
        td{6, 1} = trun_norm(td{6, 1} - uni_td_61);
    end
    pool_5 = fc2conv(td{6, 1}, 7, 512);
    
    unpool_map = unpool(pool_5, pool_cord{5});
    td{5, 3} = calc_tdmap(unpool_map, bu1{5, 2}, krnl{5, 3}, beta{5, 3});    
    td{5, 2} = calc_tdmap(td{5, 3}, bu1{5, 1}, krnl{5, 2}, beta{5, 2});
    td{5, 1} = calc_tdmap(td{5, 2}, pool_map{4}, krnl{5, 1}, beta{5, 1});
    
    unpool_map = unpool(td{5, 1}, pool_cord{4});
    td{4, 3} = calc_tdmap(unpool_map, bu1{4, 2}, krnl{4, 3}, beta{4, 3});
    td{4, 2} = calc_tdmap(td{4, 3}, bu1{4, 1}, krnl{4, 2}, beta{4, 2});
    td{4, 1} = calc_tdmap(td{4, 2}, pool_map{3}, krnl{4, 1}, beta{4, 1});
    
    unpool_map = unpool(td{4, 1}, pool_cord{3});
    td{3, 3} = calc_tdmap(unpool_map, bu1{3, 2}, krnl{3, 3}, beta{3, 3});
    td{3, 2} = calc_tdmap(td{3, 3}, bu1{3, 1}, krnl{3, 2}, beta{3, 2});
    td{3, 1} = calc_tdmap(td{3, 2}, pool_map{2}, krnl{3, 1}, beta{3, 1});
    
    unpool_map = unpool(td{3, 1}, pool_cord{2});
    td{2, 2} = calc_tdmap(unpool_map, bu1{2, 1}, krnl{2, 2}, beta{2, 2});
    td{2, 1} = calc_tdmap(td{2, 2}, pool_map{1}, krnl{2, 1}, beta{2, 1});
    
    unpool_map = unpool(td{2, 1}, pool_cord{1});
    td{1, 2} = calc_tdmap(unpool_map, bu1{1, 1}, krnl{1, 2}, beta{1, 2});
    td{1, 1} = calc_tdmap(td{1, 2}, input_img, krnl{1, 1}, beta{1, 1});
    
end







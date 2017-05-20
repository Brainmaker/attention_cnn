% -*- coding: utf-8 -*-
%
% Author: Wan Xiaolin <wanxl13@lzu.edu.cn>

clc;
clear all;

%% Load ConvNet Model.
data_path = '';
model_path = '';
save_path = '';
n_test_samples = 15;  % number of figures
data_testset = read_data(data_path, n_test_samples);
[param_conv_W, param_conv_b, param_fc_W, param_fc_b] = load_params(model_path);

%% Generate conv feature map, MWP, and competative MWP. 
result = cell(5, 4, n_test_samples);
for i = 1 : n_test_samples
    disp(['Processing test image ', ...
        num2str(i), '/', num2str(n_test_samples), '.']);
    
    % Generate Convolutional feature map, i.e. Bottom-up saliency map.
    [bu1_map, pool_map, pool_cord] = forward(...
        data_testset{i}, ...
        param_conv_W, param_conv_b, param_fc_W, param_fc_b);
    
    % Generate Top-down saliency map. (MWP)
    use_competitive_fc_tdmap = false;
    hp = load_hyperparams(false); % Using fake hyperparameters;  
    tdmap = backward( ...
        data_testset{i}, compet(bu1_map{8, 1}), ...
        bu1_map, pool_map, pool_cord, ...
        param_conv_W, param_fc_W, ...
        hp, use_competitive_fc_tdmap ...
    );
    
    % Generate Top-down saliency map, using processing tree pruning.
    use_competitive_fc_tdmap = false;
    hp = load_hyperparams(true); % Using hyperparameters;
    tree_pruning_tdmap = backward( ...
        data_testset{i}, compet(bu1_map{8, 1}), ...
        bu1_map, pool_map, pool_cord, ...
        param_conv_W, param_fc_W, ...
        hp, use_competitive_fc_tdmap ...
    );

    % Generate Top-down saliency map, using processing tree pruning and
    % prior information gain.
    prior_1 = []; % Given a specific prior.
    use_competitive_fc_tdmap_1 = true;
    hp = load_hyperparams(true); % Using hyperparameters;
    prior_tree_pruning_tdmap = backward( ...
        data_testset{i}, prior_1, ...
        bu1_map, pool_map, pool_cord, ...
        param_conv_W, param_fc_W, ...
        hp, use_competitive_fc_tdmap ...
    );

    prior_2 = []; % Given a specific prior.
    use_competitive_fc_tdmap_2 = true;
    hp = load_hyperparams(true); % Using hyperparameters;
    prior_tree_pruning_tdmap = backward( ...
        data_testset{i}, prior_2, ...
        bu1_map, pool_map, pool_cord, ...
        param_conv_W, param_fc_W, ...
        hp, use_competitive_fc_tdmap ...
    );
    
    for j = 2 : 5
        result{1, j-1, i} = gen_figs(bu1_map{j, 1});
        result{2, j-1, i} = gen_figs(tdmap{j, 1});
        result{3, j-1, i} = gen_figs(tree_pruning_tdmap{j, 1});
        result{4, j-1, i} = gen_figs(prior_tree_pruning_tdmap_1{j, 1});
        result{5, j-1, i} = gen_figs(prior_tree_pruning_tdmap_2{j, 1});
    end
end 

if ~isempty(save_path)
    save(save_path, result);
end
    
clearvars -except result

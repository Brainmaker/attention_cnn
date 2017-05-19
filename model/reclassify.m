% -*- coding: utf-8 -*-
%
% Author: Wan Xiaolin <wanxl13@lzu.edu.cn>

clc;
clear all;

%% Load ConvNet Model.
data_path = 'attention_cnn/data';
model_path = ['attention_cnn/params/', 'vgg16_model_params.mat'];
save_path = ['attention_cnn/results/', 'result_visual.mat'];
n_test_samples = 0;  % number of test samples.
data_testset = load_data(data_path, n_test_samples);
[param_conv_W, param_conv_b, param_fc_W, param_fc_b] = load_params(model_path);

%% 
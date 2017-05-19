function [ conv_krnl, conv_bias, fc_params, fc_bias, class_name ] = ... 
         load_params( model_path )
    %LOAD_PARAMS Load VGG16 model parameters
    %   Args:
    %     model_path:
    %   Returns:
    %     conv_krnl:
    %     conv_bias:
    %     fc_params_params:
    %     fc_params_bias:
    %     class_name:
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    conv_krnl = cell(5, 3);
    conv_bias = cell(5, 3);
    fc_params = cell(1, 3);
    fc_bias = cell(1, 3);

    vgg16_model = load(model_path);
    layers = vgg16_model.layers;
    meta = vgg16_model.meta;
    
    conv_krnl{1, 1} = layers{1, 1}.weights{1, 1};
    conv_krnl{1, 2} = layers{1, 3}.weights{1, 1};
    conv_krnl{2, 1} = layers{1, 6}.weights{1, 1};
    conv_krnl{2, 2} = layers{1, 8}.weights{1, 1};
    conv_krnl{3, 1} = layers{1, 11}.weights{1, 1};
    conv_krnl{3, 2} = layers{1, 13}.weights{1, 1};
    conv_krnl{3, 3} = layers{1, 15}.weights{1, 1};
    conv_krnl{4, 1} = layers{1, 18}.weights{1, 1};
    conv_krnl{4, 2} = layers{1, 20}.weights{1, 1};
    conv_krnl{4, 3} = layers{1, 22}.weights{1, 1};
    conv_krnl{5, 1} = layers{1, 25}.weights{1, 1};
    conv_krnl{5, 2} = layers{1, 27}.weights{1, 1};
    conv_krnl{5, 3} = layers{1, 29}.weights{1, 1};

    conv_bias{1, 1} = layers{1, 1}.weights{1, 2};
    conv_bias{1, 2} = layers{1, 3}.weights{1, 2};
    conv_bias{2, 1} = layers{1, 6}.weights{1, 2};
    conv_bias{2, 2} = layers{1, 8}.weights{1, 2};
    conv_bias{3, 1} = layers{1, 11}.weights{1, 2};
    conv_bias{3, 2} = layers{1, 13}.weights{1, 2};
    conv_bias{3, 3} = layers{1, 15}.weights{1, 2};
    conv_bias{4, 1} = layers{1, 18}.weights{1, 2};
    conv_bias{4, 2} = layers{1, 20}.weights{1, 2};
    conv_bias{4, 3} = layers{1, 22}.weights{1, 2};
    conv_bias{5, 1} = layers{1, 25}.weights{1, 2};
    conv_bias{5, 2} = layers{1, 27}.weights{1, 2};
    conv_bias{5, 3} = layers{1, 29}.weights{1, 2};

    fc_params{1} = layers{1, 32}.weights{1, 1};
    fc_params{2} = layers{1, 34}.weights{1, 1};
    fc_params{3} = layers{1, 36}.weights{1, 1};

    fc_bias{1} = layers{1, 32}.weights{1, 2};
    fc_bias{2} = layers{1, 34}.weights{1, 2};
    fc_bias{3} = layers{1, 36}.weights{1, 2};

    class_name = meta.classes.description;
    
end


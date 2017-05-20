function [ pred ] = predict( bu1_81, class_name )
    %PREDICT Generate prediction according to the output of fc_8.
    %   Args:
    %     bu1_81: The output of fc_8 (full-connected layer 8)
    %     class_name: A cell array of class name
    %   Returns:
    %     pred:
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    pred.cls_prob = 0;  % Class probability 
    pred.cls_id   = 0;  % Class ID
    pred.result   = ''; % Output string of classification results
    
    [pred.cls_prob, pred.cls_id] = max(softmax(bu1_81));
    pred.result = [ ...
        'Class Name: ', string(class_name{pred.cls_id}), '; ', ...
        'Class ID: ', num2str(pred.cls_id), '; ', ...
        'Class Probability: ', num2str(pred.cls_prob), ';'];
end


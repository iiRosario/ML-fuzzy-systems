function [gridpartition_back, gridpartition_hybrid, subtractive_back, subtractive_hybrid, fuzzycmeans_back, fuzzycmeans_clustering] = optimize(train_dataset, gridpartition_clustering, subtractive_clustering, fuzzycmeans_clustering)
    options = anfisOptions('OptimizationMethod', 0, 'InitialFIS', gridpartition_clustering);
    gridpartition_back = anfis(train_dataset,options);
    writeFIS(gridpartition_back, 'gridpartition_backpropagation');
    
    options = anfisOptions('OptimizationMethod', 1, 'InitialFIS', gridpartition_clustering);
    gridpartition_hybrid = anfis(train_dataset,options);
    writeFIS(gridpartition_hybrid, 'gridpartition_hybrid');

    options = anfisOptions('OptimizationMethod', 0, 'InitialFIS', subtractive_clustering);
    subtractive_back = anfis(train_dataset, options);
    writeFIS(subtractive_back, 'subtractive_backpropagation');
    
    options = anfisOptions('OptimizationMethod', 1, 'InitialFIS', subtractive_clustering);
    subtractive_hybrid = anfis(train_dataset, options);
    writeFIS(subtractive_hybrid, 'subtractive_hybrid');
    
    options = anfisOptions('OptimizationMethod', 0, 'InitialFIS', fuzzycmeans_clustering);
    fuzzycmeans_back = anfis(train_dataset, options);
    writeFIS(fuzzycmeans_back, 'fuzzycmeans_backpropagation');
    
    options = anfisOptions('OptimizationMethod', 1, 'InitialFIS', fuzzycmeans_clustering);
    fuzzycmeans_hybrid = anfis(train_dataset, options);
    writeFIS(fuzzycmeans_hybrid, 'fuzzycmeans_hybrid');
end
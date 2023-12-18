function [subtractive_clustering, fuzzycmeans_clustering, gridpartition_clustering] = rules_generator(in, out)
    options = genfisOptions('GridPartition');
    gridpartition_clustering = genfis(in, out, options);

    options = genfisOptions('SubtractiveClustering');
    subtractive_clustering = genfis(in, out, options);
    
    options = genfisOptions('FCMClustering');
    fuzzycmeans_clustering = genfis(in, out, options);
end
%Transfer function
num = [5];
den = [1 5 9 5];

%Finding a discrete transfer function
poles = roots(den);
inv_poles = -1./poles;
Ts = min(inv_poles) * (1/4);
[numd, dend] = c2dm(num, den, Ts, 'zoh');

%Get random input and output
out_sim = sim('discreteFunction');
inputs_sim = out_sim.InputRandom.Data;
outputs_sim = out_sim.DiscreteOut.Data;

%Constructing dataset
num_columns = 7;
num_rows = length(inputs_sim) - 3;

dataset = zeros(num_rows, num_columns);
dataset(:, 1) = outputs_sim(3 : end-1);
dataset(:, 2) = outputs_sim(2 : end-2);
dataset(:, 3) = outputs_sim(1 : end-3);
dataset(:, 4) = inputs_sim(3 : end-1);
dataset(:, 5) = inputs_sim(2 : end-2);
dataset(:, 6) = inputs_sim(1 : end-3);
dataset(:, 7) = outputs_sim(4 : end);

%Divide in training and test dataset by 70%
train_dataset = dataset(1:round(0.7 * num_rows), :); in = train_dataset(:, 1:6);
test_dataset = dataset(round(0.7 * num_rows), :); out = train_dataset(:, 7);

%Generate clusters and Optimize clusters
[gridpartition_clustering, subtractive_clustering, fuzzycmeans_clustering] = rules_generator(in, out);
[grd_back, grd_hybrid, sub_back, sub_hybrid, fcm_back, fcm_hybrid] = optimize(train_dataset, gridpartition_clustering, subtractive_clustering, fuzzycmeans_clustering);

%Test the fuzzy systems
test_p = test_dataset(:, 1:6);
test_t = test_dataset(:, 7);

train_results_grd_back = evalfis(test_p, grd_back);
train_results_grd_hybrid = evalfis(test_p, grd_hybrid);
train_results_sub_back = evalfis(test_p, sub_back);
train_results_sub_hybrid = evalfis(test_p, sub_hybrid);
train_results_fcm_back = evalfis(test_p, fcm_back);
train_results_fcm_hybrid = evalfis(test_p, fcm_hybrid);

%Calculate the mean square error
mse_gridpartition_backpropagation = immse(test_t, train_results_grd_back);
mse_gridpartition_hybrid = immse(test_t, train_results_grd_hybrid);
mse_subtraction_backpropagation = immse(test_t, train_results_sub_back);
mse_subtraction_hybrid = immse(test_t, train_results_sub_hybrid);
mse_fuzzycmeans_backpropagation = immse(test_t, train_results_fcm_back);
mse_fuzzycmeans_hybrid = immse(test_t, train_results_fcm_hybrid);
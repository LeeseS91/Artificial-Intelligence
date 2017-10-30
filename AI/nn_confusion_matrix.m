function [confusionmatrix N]=nn_confusion_matrix

% load MNIST datasets
load MNist0-4.mat;
load MNist5-9.mat;
load input_images.mat;
load numbers.mat;


M=1000;
% create a training set
rand_index_train0 = randperm(size(train0,1));
rand_index_train1 = randperm(size(train1,1));
rand_index_train2 = randperm(size(train2,1));
rand_index_train3 = randperm(size(train3,1));
rand_index_train4 = randperm(size(train4,1));
rand_index_train5 = randperm(size(train5,1));
rand_index_train6 = randperm(size(train6,1));
rand_index_train7 = randperm(size(train7,1));
rand_index_train8 = randperm(size(train8,1));
rand_index_train9 = randperm(size(train9,1));

train_sample0 = train0(rand_index_train0(1:M),:);
train_sample1 = train1(rand_index_train1(1:M),:);
train_sample2 = train2(rand_index_train2(1:M),:);
train_sample3 = train3(rand_index_train3(1:M),:);
train_sample4 = train4(rand_index_train4(1:M),:);
train_sample5 = train5(rand_index_train5(1:M),:);
train_sample6 = train6(rand_index_train6(1:M),:);
train_sample7 = train7(rand_index_train7(1:M),:);
train_sample8 = train8(rand_index_train8(1:M),:);
train_sample9 = train9(rand_index_train9(1:M),:);

% use only a random sample of N test points per digit
N = 500;
rand_index_test0 = randperm(size(test0,1));
rand_index_test1 = randperm(size(test1,1));
rand_index_test2 = randperm(size(test2,1));
rand_index_test3 = randperm(size(test3,1));
rand_index_test4 = randperm(size(test4,1));
rand_index_test5 = randperm(size(test5,1));
rand_index_test6 = randperm(size(test6,1));
rand_index_test7 = randperm(size(test7,1));
rand_index_test8 = randperm(size(test8,1));
rand_index_test9 = randperm(size(test9,1));

test_sample0 = test0(rand_index_test0(1:N),:);
test_sample1 = test1(rand_index_test1(1:N),:);
test_sample2 = test2(rand_index_test2(1:N),:);
test_sample3 = test3(rand_index_test3(1:N),:);
test_sample4 = test4(rand_index_test4(1:N),:);
test_sample5 = test5(rand_index_test5(1:N),:);
test_sample6 = test6(rand_index_test6(1:N),:);
test_sample7 = test7(rand_index_test7(1:N),:);
test_sample8 = test8(rand_index_test8(1:N),:);
test_sample9 = test9(rand_index_test9(1:N),:);

% create a batch test set
test = [test_sample0; test_sample1; test_sample2; test_sample3;...
    test_sample4; test_sample5; test_sample6; test_sample7; test_sample8;...
    test_sample9;];

% create training set
training=[train_sample0; train_sample1; train_sample2; train_sample3;...
    train_sample4; train_sample5; train_sample6; train_sample7; ...
    train_sample8; train_sample9];

% create the corresponding labels
group = [zeros(M,1); ones(M,1); 2*ones(M,1); 3*ones(M,1); 4*ones(M,1);...
    5*ones(M,1); 6*ones(M,1); 7*ones(M,1); 8*ones(M,1); 9*ones(M,1)];

labels = [zeros(N,1); ones(N,1); 2*ones(N,1); 3*ones(N,1); 4*ones(N,1);...
    5*ones(N,1); 6*ones(N,1); 7*ones(N,1); 8*ones(N,1); 9*ones(N,1)];

classifier = knnclassify(double(test), double(training), group, 3);

confusionmatrix=confusionmat(labels,classifier);




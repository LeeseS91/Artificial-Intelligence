function [classified confusionmat1]=classify_digits(digit1, digit2, digit3, digit4, digit5)

% load MNIST datasets
load MNist0-4.mat;
load MNist5-9.mat;
load input_images.mat;
load numbers.mat;

[digit1, digit2, digit3, digit4, digit5] = decomposer;

dimensions=size(digit1);

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


% create training set
training=[train_sample0; train_sample1; train_sample2; train_sample3;...
    train_sample4; train_sample5; train_sample6; train_sample7; ...
    train_sample8; train_sample9];

% create the corresponding labels
group = [zeros(M,1); ones(M,1); 2*ones(M,1); 3*ones(M,1); 4*ones(M,1);...
    5*ones(M,1); 6*ones(M,1); 7*ones(M,1); 8*ones(M,1); 9*ones(M,1)];

classifier1=zeros(dimensions(1,1),1);
classifier2=zeros(dimensions(1,1),1);
classifier3=zeros(dimensions(1,1),1);
classifier4=zeros(dimensions(1,1),1);
classifier5=zeros(dimensions(1,1),1);

for j=1:dimensions(1,1);
        classifier1(j) = knnclassify(double(digit1(j,:)), double(training), group, 3);
        classifier2(j) = knnclassify(double(digit2(j,:)), double(training), group, 3);
        classifier3(j) = knnclassify(double(digit3(j,:)), double(training), group, 3);
        classifier4(j) = knnclassify(double(digit4(j,:)), double(training), group, 3);
        classifier5(j) = knnclassify(double(digit5(j,:)), double(training), group, 3);
end
classified=zeros(dimensions(1,1),5);
classified=[classifier1, classifier2, classifier3, classifier4, classifier5];

accuracyvect1=[classifier1', classifier2', classifier3', classifier4', classifier5'];
numvect=[numbers(:,1)', numbers(:,2)', numbers(:,3)', numbers(:,4)', numbers(:,5)'];

confusionmat1=confusionmat(accuracyvect1, numvect);

end
% % run the classification through the hmm
% hmmclassfiy=zeros(length(classified),5);
% 
% for i=1:length(classified)
%    hmmclassfiy(i,:)=hmm_digits(classified(i,:));
% end
% 
% accuracyvect2=[hmmclassify(:,1)', hmmclassify(:,2)', hmmclassify(:,3)',...
%     hmmclassify(:,4)', hmmclassify(:,5)',];
% 
% % test accuracy with the hmm model included
% confusionmat2=confusionmat(accuracyvect2, numvect);

clear
% load MNIST datasets
load MNist0-4.mat;
load MNist5-9.mat;
load input_images.mat;
load numbers.mat;

% find the confusion matrix to work out emission probabilities
[probs M]=nn_confusion_matrix;

% reshape the input_images.mat to the correct format so that each digit can
% be classified
[digit1, digit2, digit3 digit4, digit5]=decomposer;

% classify the digits from input_images to be used for the inferred digit
% values in the hmm
[classified confusionmat1]=classify_digits(digit1, digit2, digit3, digit4, digit5);

% compute the CPTs 
[initial prob1 prob2 prob3 prob4]=part4;

% run the classification through the hmm to get new classification values
hmmclassify=zeros(length(classified),5);
for count=1:length(classified)
    hmmclassify(count,:)=hmm_digits(classified(count,:),probs, M ,initial, prob1, prob2, prob3, prob4);
end

% compute the various accuracys for each of the classifiers
accuracyvect2=[hmmclassify(:,1)', hmmclassify(:,2)', hmmclassify(:,3)',...
    hmmclassify(:,4)', hmmclassify(:,5)',];
numvect=[numbers(:,1)', numbers(:,2)', numbers(:,3)', numbers(:,4)', numbers(:,5)'];
confusionmat2=confusionmat(accuracyvect2, numvect);

% test accuracy with the hmm model included
digitaccuracy=sum(diag(confusionmat1))/5000;
digitaccuracyhmm=sum(diag(confusionmat2))/5000;

total1=0;
total2=0;
for i=1:1000
    if hmmclassify(i,:)==numbers(i,:)
        total1=total1+1;
    end
    if classified(i,:)==numbers(i,:)
        total2=total2+1;
    end
end
rowaccuracy= total2/1000;
rowaccuracyhmm= total1/1000;

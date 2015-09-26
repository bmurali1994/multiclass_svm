%This a function that models a given training data set and the corresponding labels
%and classifies the test data using the SVM classifier using a one vs. all relation 
%
%Created by Murali Raghu Babu
%
%The idea of this code was taken from the following: 
% http://www.mathworks.com/matlabcentral/fileexchange/33170-multi-class-support-vector-machine/
% http://www.mathworks.com/matlabcentral/fileexchange/39352-multi-class-svm

function [testlabels] = multisvm(traindata,trainlabels,testdata)

%training data as traindata, labels for the training data as trainlabels,
%and the testing data as testdata are the inputs for the fucntion.
%the output is testlabels containing the class of each of the testing data points


%finding the number of unique classes
uniqueclasses=unique(trainlabels);
count=length(uniqueclasses);

%initialising the testlabels vector
testlabels = zeros(size(testdata,1),1);

svmmodels=cell(k,1);

%building the SVM models on the training data
for k=1:count
    %we train an svm model for each class and only labels for the training
    %data belonging to that class is 1 and for the rest it is 0.
    labels=(trainlabels==uniqueclasses(k));
    svmmodels(k) = svmtrain(traindata,labels,'kernel_function','rbf');
end

%classifying the testdata
for j=1:size(testdata,1)
    
    for k=1:count
        if(svmclassify(svmmodels(k),testdata(j,:))) 
            break;
        end
    end
    %If the svmmodel of a particular class defined by k that classifies the
    %testdatapoint to be 1, then that datapoint is classified to be
    %belonging to the class-k.
    testlabels(j) = k;
end

%final result is available in the testlabels vector

%----------------------------------------------------
%or you could use the following instead of multisvm
%Mdl = fitcecoc(X,Y) %by default it uses an SVM to build on a
%multi-classmodel

%Mdl is a ClassificationECOC model. 
%By default, fitcecoc uses SVM binary learners, and uses a one-versus-one coding design. 
%You can access Mdl properties using dot notation.

%You can find more details here: http://in.mathworks.com/help/stats/fitcecoc.html
%----------------------------------------------------





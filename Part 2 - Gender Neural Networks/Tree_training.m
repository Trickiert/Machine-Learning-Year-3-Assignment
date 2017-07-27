%Training via Classifcation Tree

clear all;
close all;
clc
folder_male=dir('Male\');
folder_female=dir('Female\');
Number_male_images=length(folder_male)-2; % number of male images
Number_female_images=length(folder_female)-2; % number of female images
input_training_set=[];

% Construct the training set 
% each training feature vector (either for Male or Female images) is extracted 
% by using the DCT. Please see function get_featureVector
% dimension of the classifier is 64 (64 features)
for i=1:Number_male_images,
    Image=imread(['Male\' folder_male(i+2).name]);
    input_training_set=[input_training_set;get_featureVector(Image)'];   
    output_training_set{i,1}='male';
end
k=i;
for i=1:Number_female_images,
    Image=imread(['Female\' folder_female(i+2).name]);
    input_training_set=[input_training_set;get_featureVector(Image)'];
    output_training_set{k+i,1}='female';
   
end
% because we have 70 training samples, the input_training_set should be
% arranged in a matrix of 64 rows and 70 columns to train the network.
% Remember that this arrangement should be the other way around (64 columns and 70 rows)
% for the Bayes and Tree classifiers
input_training_set=input_training_set; % get the right arrangement for the input set. 
output_training_set=output_training_set'; % get the right arrangement for the output set


Target=strcmp('female',output_training_set)'; % Now, Target has logical values (0 and 1). This has to be converted into double.
% Target=repmat(Target,[64,1]);
% tree = fitctree(input_training_set,double(Target))
tree=fitctree(input_training_set,double(Target))
view(tree,'Mode','graph')
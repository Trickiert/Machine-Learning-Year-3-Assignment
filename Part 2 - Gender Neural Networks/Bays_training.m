%Training via a Naitive Bays classifier

clc;
clear all;

% male & Female file directories
folder_male=dir('Male\');
folder_female=dir('Female\');
Number_male_images=length(folder_male)-2; % number of male images
Number_female_images=length(folder_female)-2; % number of female images
input_training_set=[];

% Construct the training set
% each training feature vector (either for Male or Female images) is extracted
% by using the DCT.

%Male
for i=1:Number_male_images,
    Image=imread(['Male\' folder_male(i+2).name]);
    input_training_set=[input_training_set;get_featureVector(Image)'];
    output_training_set{i,1}='male';
end

k=i;

%Female
for i=1:Number_female_images,
    Image=imread(['Female\' folder_female(i+2).name]);
    input_training_set=[input_training_set;get_featureVector(Image)'];
    output_training_set{k+i,1}='female';
    
end

% We have 70 training samples, the input_training_set should be
% arranged in a matrix of 64 rows and 70 columns to train the network.

input_training_set=input_training_set; % get the right arrangement for the input set.
output_training_set=output_training_set'; % get the right arrangement for the output set

Target=strcmp('female',output_training_set)'; % Now, Target has logical values (0 and 1). This has to be converted into double.

key=27; % this is a value to initialise the RNG
rand('state',key);  % set the RNG to the initial value given above (27)

Mdl = fitcnb(input_training_set,double(Target))
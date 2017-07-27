clear;
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
input_training_set=input_training_set'; % get the right arrangement for the input set. 
output_training_set=output_training_set'; % get the right arrangement for the output set


Target=strcmp('female',output_training_set); % Now, Target has logical values (0 and 1). This has to be converted into double.

key=27; % this is a value to initialise the random number generator
rand('state',key);  % set the random generator to the initial value given above

net = newpr(input_training_set,double(Target),[35 20]); % create a network for non-linear classification, 35 neurons in first hidden layer 
% and 20 in the second.
net.layers{1}.transferFcn='tansig';  % transfer function for the neurons in first hidden layer is tangent sigmoid.
net.layers{2}.transferFcn='tansig';  % transfer function for the neurons in second hidden layer is tangent sigmoid.
net.layers{3}.transferFcn='purelin';  % transfer function for the neurons in the output layer is linear.
net.trainParam.epochs = 40;  % set to 40 the number of times the training samples will be used to train the network
net = train(net,input_training_set,double(Target)); % train the network with the training samples.



    

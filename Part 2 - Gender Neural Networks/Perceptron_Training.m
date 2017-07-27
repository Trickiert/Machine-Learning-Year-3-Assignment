%Training via Perceptron

clear all;

x = [0 0 1 1; 0 1 0 1];
t = [0 1 1 1];

clear;
folder_male=dir('Male\');
folder_female=dir('Female\');
Number_male_images=length(folder_male)-2; % number of male images
Number_female_images=length(folder_female)-2; % number of female images
input_training_set=[];

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

input_training_set=input_training_set'; % get the right arrangement for the input set. 
output_training_set=output_training_set'; % get the right arrangement for the output set


Target=strcmp('female',output_training_set); % Now, Target has logical values (0 and 1). This has to be converted into double.

key=27; % this is a value to initialise the random number generator
rand('state',key);  % set the random generator to the initial value given above


net = perceptron;
net = train(net,input_training_set,double(Target));
view(net)
y = net(x);
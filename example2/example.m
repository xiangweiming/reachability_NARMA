%% Obtain the input for reachable set computation
clc
clear
load data network net
figure
inputMin = [0.8,-0.2];
inputMax = [1.2,0.2];
K=50;
num_sim = 50;
num_division = [10,10];

%% Compute the reachable set for 2D input (input + y)
input_min = inputMin;
input_max = inputMax ;
for k = 1:1:K
    input = inputDiscretize(input_min,input_max,num_division);
    y = networkOutput(input,network);
    y_min = y{1}.min;
    y_max = y{1}.max;
    for i = 2:1:length(y)
        if y_min >= y{i}.min
            y_min = y{i}.min;
        end
        if y_max <= y{i}.max
            y_max = y{i}.max;
        end
    end
    input_min(2) = y_min;
    input_max(2) = y_max;
    Y_min(k) = y_min;
    Y_max(k) = y_max;       
end

Y_min = [inputMin(2), Y_min];
Y_max = [inputMax(2), Y_max];
   
k=0:1:K;

%figure
hold on;
fill([k fliplr(k)],[Y_min fliplr(Y_max)],'b','edgecolor','b');

%% Generate random trajectories of NARMA
%load data network net
input_min = inputMin;
input_max = inputMax;
%K=50;

for n=1:1:num_sim
    input_sequence = input_min(1)+ (input_max(1)-input_min(1))*rand(1,K);
    initial = rand(1)*(input_min(2)-input_max(2))+input_max(2);
    hold on
    input = [input_sequence(1);initial];
    for k = 1:1:K
        simy = sim(net,input);
        input = [input_sequence(k);simy];
        Simy(k) = simy;
    end
    SimY = [initial, Simy];
    k = 0:1:K;
    plot(k,SimY,'r')
end
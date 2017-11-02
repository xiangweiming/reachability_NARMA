function y = networkOutput(input,network)

layerNum = length(network.bias);
weight = network.weight;
bias = network.bias;
activeType =network.activeType;
inputNum = length(input);

for i= 1:1:inputNum
    %fprintf('Computation for input %i.\n',i)
    for j = 1:1:layerNum
        %fprintf('Computation for layer %i.\n',j);
        input{i} = layerOutput(j,input{i},network);
        %fprintf('Computation for layer %i finished.\n',j);
    end
end
y = input;
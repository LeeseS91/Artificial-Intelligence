function output=hmm_digits(inferred,probs, M,initial, prob1, prob2, prob3, prob4)

%         --------
%         TOPOLOGY
%         --------
%     (1)         (3)          (5)         (7)         (9)       
%   Trueval1 --> Trueval2 --> Trueval3 --> Trueval4 --> Trueval5 
%      |          |             |           |           |         
%      |          |             |           |           |           
%     (2)        (4)           (6)         (8)         (10)         
%  Inferred1    Inferred2    Inferred3   Inferred4   Inferred5       
%   

%number of nodes in our graphical model
N = 10;
%the directed acyclic graph (dag) is defined as a NxN matrix
dag = zeros(N,N);

%we assign an id to each node - the nodes must be numbered in topological 

True1 = 1;
True2 = 3;
True3 = 5;
True4 = 7;
True5 = 9;

Inf1 = 2;
Inf2 = 4;
Inf3 = 6;
Inf4 = 8;
Inf5 = 10;

%define the connections of the nodes 
dag(True1, [True2 Inf1]) = 1; 
dag(True2, [True3 Inf2]) = 1; 
dag(True3 ,[True4 Inf3]) = 1;
dag(True4 ,[True5 Inf4]) = 1;
dag(True5 ,Inf5) = 1;

%specify the node structure
%all the nodes are discrete, i.e. we can enumerate their possible states
discrete_nodes = [1 2 3 4 5 6 7 8 9 10];
%each node can take two possible values/states
node_sizes = [10 10 10 10 10 10 10 10 10 10];
%which nodes do we observe? 
onodes = [];

%create the Bayesian network
bnet = mk_bnet(dag, node_sizes,'names',{'True1','Inf1','True2','Inf2',...
    'True3', 'Inf3', 'True4','Inf4', 'True5', 'Inf5'},...
    'discrete', discrete_nodes, 'observed', onodes);


% [initial prob1 prob2 prob3 prob4]=part4;

%define the network's parameters by creating Conditional Probability
%Distributions (or Tables) (CPDs or CPTs)
CPT_True1 = zeros(10,1);
for i=1:10
    CPT_True1(i) = initial(i);
end
%everything is being carried out in topological order (we have defined the
%topology and the order of the nodes in the beginning)
CPT_True2 = zeros(10,10);
CPT_True3 = zeros(10,10);
CPT_True4 = zeros(10,10);
CPT_True5 = zeros(10,10);

for i=1:10
    for j=1:10
        CPT_True2(i,j)=prob1(i,j);
        CPT_True3(i,j)=prob2(i,j);
        CPT_True4(i,j)=prob3(i,j);
        CPT_True5(i,j)=prob4(i,j);
    end
end

% [probs M]=nn_confusion_matrix;

CPT_Inf1 = zeros(10,10);
CPT_Inf2 = zeros(10,10);
CPT_Inf3 = zeros(10,10);
CPT_Inf4 = zeros(10,10);
CPT_Inf5 = zeros(10,10);

% probs(probs==0)=0.00001;

for i=1:10
    for j=1:10
        CPT_Inf1(i,j)=probs(i,j)/M;
        CPT_Inf2(i,j)=probs(i,j)/M;
        CPT_Inf3(i,j)=probs(i,j)/M;
        CPT_Inf4(i,j)=probs(i,j)/M;
        CPT_Inf5(i,j)=probs(i,j)/M;
    end
end


%insert the tables in the BBN
bnet.CPD{True1} = tabular_CPD(bnet, True1, CPT_True1);
bnet.CPD{True2} = tabular_CPD(bnet, True2, CPT_True2);
bnet.CPD{True3} = tabular_CPD(bnet, True3, CPT_True3);
bnet.CPD{True4} = tabular_CPD(bnet, True4, CPT_True4);
bnet.CPD{True5} = tabular_CPD(bnet, True5, CPT_True5);

bnet.CPD{Inf1} = tabular_CPD(bnet, Inf1, CPT_Inf1);
bnet.CPD{Inf2} = tabular_CPD(bnet, Inf2, CPT_Inf2);
bnet.CPD{Inf3} = tabular_CPD(bnet, Inf3, CPT_Inf3);
bnet.CPD{Inf4} = tabular_CPD(bnet, Inf4, CPT_Inf4);
bnet.CPD{Inf5} = tabular_CPD(bnet, Inf5, CPT_Inf5);

% Here we use BNT to compute conditional probabilities given some
% evidence 

% we change the inference engine - now we are using junction inference
% algorithm 
engine = jtree_inf_engine(bnet);
evidence = cell(1,N);
evidence{Inf1}=inferred(1)+1;
evidence{Inf2}=inferred(2)+1;
evidence{Inf3}=inferred(3)+1;
evidence{Inf4}=inferred(4)+1;
evidence{Inf5}=inferred(5)+1;

% evidence{Inf1}=1;
% evidence{Inf2}=7;
% evidence{Inf3}=1;
% evidence{Inf4}=1;
% evidence{Inf5}=10;
%add the evidence to the engine


mpe=cell2mat(calc_mpe(engine, evidence));

output=[mpe(1)-1,mpe(3)-1,mpe(5)-1,mpe(7)-1,mpe(9)-1];

% other way

% [engine, loglik] = enter_evidence(engine, evidence);
% 
% 
% margTrue1 = marginal_nodes(engine, True1);
% margTrue2 = marginal_nodes(engine, True2);
% margTrue3 = marginal_nodes(engine, True3);
% margTrue4 = marginal_nodes(engine, True4);
% margTrue5 = marginal_nodes(engine, True5);
% 
% one=argmax([margTrue1.T]);
% two=argmax([margTrue2.T]);
% three=argmax([margTrue3.T]);
% four=argmax([margTrue4.T]);
% five=argmax([margTrue5.T]);
% 
% output=[one-1, two-1, three-1, four-1, five-1];

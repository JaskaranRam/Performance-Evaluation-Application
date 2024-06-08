%A16 Solution - Jaskaran Ram

clear all;

N = 200;
Z = 2*60; %Think time in seconds
S_Controller = 10/1000; %AVG Service x Block
Cv = 0.25; %Erlang coefficient variation
P = 0.9;

S_SAN = 12/1000; %Normal ditribuited
sigma = 1/1000;
K = 10; %Capacity of Jobs

%Shortest Queue Policy for disks
S_disk = [30/1000, 40/1000, 35/1000];


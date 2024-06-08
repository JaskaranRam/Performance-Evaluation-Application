% A02 - Jaskaran Ram - 03/10/2023
% CODICE IDENTICO PER TUTTI E 3 I FILE, BASTA CAMBIARE IL NOME DEL FILE SORGENTE NELLA SECONDA RIGA

clear all;

File1 = csvread("Trace1.csv");
IN = [];
OUT = [];

t = 0;
for i = 1:length(File1(:,1))
	t = t + File1(i,1);
	IN(i,1) = t;
end

OUT(1,1) = IN(1,1) + File1(1,2);
for i = 2:length(File1(:,2))
	if(IN(i,1) < OUT(i-1,1))
		OUT(i,1) = OUT(i-1,1) + File1(i,2);
	else
		OUT(i,1) = IN(i,1) + File1(i,2);
	end  

end

% Response Time
M = [IN,OUT];
RT = M(:,2) - M(:,1);
AVG_RT = mean(RT)


T = M(end,2) - M(1,1)
length = length(IN);


%Utilization
matrice = [IN, ones(length,1); OUT, -ones(length, 1)];
matrice = sortrows(matrice,1);
matrice(:,3) = cumsum(matrice(:,2));
interval = matrice(2:end,1) - matrice(1:end-1, 1);
B = T - sum( (matrice(1:end-1,3) == 0) .*interval ) 

U = B/T


%Frequency idle
N_idle = sum( matrice(:,3) == 0)
Freq = N_idle/ T

%Average idle time
clear length
for i=1:length(matrice) -1
	if(matrice(i,3) == 0)
		matrice(i,4)  =  matrice(i+1,1) - matrice (i,1);
	else
		matrice(i,4) = 0;
	end
end

AVG_IDLE_T  = sum(matrice(:,4)) / N_idle


% FILE 1 : AVG_RT = 12,4794  U = 0,8500  Freq = 0.0403  AVG_IDLE_T = 3.7254

% FILE 2 : AVG_RT = 59,2297  U = 0,8498  Freq = 0.0147  AVG_IDLE_T = 10.2023

% FILE 2 : AVG_RT = 244.9103 U = 0,8495  Freq = 0.0065  AVG_IDLE_T = 23,1406

%First assignment 29/09/2023 Jaskaran Ram

clear all

% Leggo File
fid = fopen('barrier.log', 'r');  
log_text = textscan(fid, '%s', 'Delimiter', '\n');
log_text = log_text{1};
fclose(fid);

% Inizializza le matrici per "_IN_" e "_OUT_"
IN_dates = [];
OUT_dates = [];

% Scansiona il testo dei log
for i = 1:length(log_text)
    % Estrai la data e l'annotazione dal testo dei log
    log_entry = log_text{i};
    last_two_chars = log_entry(end-1:end);
    if strcmp(last_two_chars, '_]')
        % Questo è un "_IN_"
        timestamp = extractBetween(log_entry, '[', '][_');
        IN_dates = [IN_dates; datetime(timestamp, 'InputFormat', 'uuuu:DDD:HH:mm:ss:S')];
    elseif strcmp(last_two_chars, 'T]')
        % Questo è un "_OUT_"
        timestamp = extractBetween(log_entry, '[', '][_');
        OUT_dates = [OUT_dates; datetime(timestamp, 'InputFormat', 'uuuu:DDD:HH:mm:ss:S')];
    end
end

IN_dates.Format ='uuuu/MM/dd HH:mm:ss:S';
OUT_dates.Format ='uuuu/MM/dd HH:mm:ss:S';

% Crea la matrice con le colonne "_IN_" e "_OUT_"
log_matrix = [IN_dates, OUT_dates];

% Numero di Arrivi
NA = size (log_matrix,1);
% Numero di Job Completati 
NC = size (log_matrix,1);

% T espresso in datetime
T = log_matrix(end,2) - log_matrix(1,1);


% T in secondi 
T_in_secondi = seconds(T);


% 1) Arrival Rate and Throughput  Lambda = 0.0160  X = 0.0160 
Lambda = NA / T_in_secondi; 
X = NC / T_in_secondi;


% 2) Average inter-arrival time   AVG_IA = 62.4764 s
deltaT = log_matrix(2:end,1) - log_matrix(1:end-1, 1);
AVG_IA = mean(deltaT);
seconds(AVG_IA) 


% 6) Average response time  AVG_IA = 174.2906 s
RT = log_matrix(:,2) - log_matrix(:,1);
AVG_RT = seconds(mean(RT));   % espersso in secondi 


% 5)  Average Number of Jobs   N = 2.7913
W = sum(RT);
N = W / T;

% 3) Utilization = 0.7262
% 7) Probability of having m parts in the machine (with m = 0, 1, 2)   BusyTime = 45,346 s
% Calcola i secondi totali da log_matrix(:,1) e log_matrix(:,2)
seconds1 = day(log_matrix(:,1))*86400 + hour(log_matrix(:,1))*3600 + minute(log_matrix(:,1))*60 + second(log_matrix(:,1));
seconds2 = day(log_matrix(:,2))*86400 + hour(log_matrix(:,2))*3600 + minute(log_matrix(:,2))*60 + second(log_matrix(:,2));
M = [seconds1, ones(NA, 1); seconds2, -ones(NA, 1)];
M = sortrows(M, 1); 
M(:, 3) = cumsum(M(:,2));  % sommatoria dei job per ogni istante 
interval = M(2:end,1) - M(1:end-1,1);   %intervallo tra cui cambia il num di Job 
(M(1:end-1,3) == 0) .* interval;
B = T_in_secondi - sum(ans); 
U = B/T_in_secondi;

datetime_vector = M(:,1);
durata=diff(datetime_vector);
durata(2000) = 0;
Y_0 = sum((M(:,3) ==0) .*(durata)) / T_in_secondi;   % 0.2620
Y_1 = sum((M(:,3) ==1) .*(durata)) / T_in_secondi;   % 0.1958
Y_2 = sum((M(:,3) ==2) .*(durata)) / T_in_secondi;   % 0.1341


% 4) Average Service Time  ST = 45.3463 
ST = B/NC;


% 8) Probability of having a response time less than , (with  = 30 sec, 3 min)  P = 66.70 %
(sum(seconds(RT) < 210) / NC) * 100;
 

% 9) Probability of having an inter-arrival time shorter than , (with  = 1 min    P = 62.6 %
seconds(deltaT) < 60;
sum(ans)
(ans/NC) * 100;


% 10) Probability of having a service time longer than , (with  = 1 min)  P = 26.8 %
St = zeros(size(IN_dates));
for i = 1:length(IN_dates)
    if i == 1
        % Se siamo al primo elemento, C{i-1} non è definito, quindi usiamo 0
        St(i) = seconds(OUT_dates(i) - IN_dates(i));
    else
        St(i) = seconds(OUT_dates(i) - max(IN_dates(i), OUT_dates(i-1)));
    end
end
PrS = sum((St > 60)) / NC; 
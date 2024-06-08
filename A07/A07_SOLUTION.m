% Jaskaran Ram - A07 - The Floor is lava

clear all;

s = 0;
t = 0;

roundTime = 0;
RT = [];
roundIndex = 1;
winners = 0;
losers = 0;

while roundIndex < 100000
    if s == 0
        roundTime = 0;
        if rand() <= 0.7
            if rand() <= 0.8
                ns = 1;
                dt = -log(prod(rand(4,1)))/1.5;
            else
                ns = 0;
                losers = losers + 1;
                dt = -log(rand())/0.5;
                RT(roundIndex,1) = roundTime + dt;
                dt = dt + 5;
                roundIndex = roundIndex + 1;
            end
        else
            if rand()<= 0.3
                ns = 2;
                dt = 3 + (6-3)*rand();
            else
                ns = 0;
                losers = losers + 1;
                dt = -log(rand())/0.25;
                RT(roundIndex,1) = roundTime + dt;
                dt = dt + 5;
                roundIndex = roundIndex + 1;
            end
        end

        roundTime = roundTime + dt;
    end

    if s == 1
        if rand() <= 0.5
            if rand() <= 0.25
                ns = 2;
                dt = -log(prod(rand(3,1)))/2;
            else
                ns = 0;
                losers = losers + 1;
                dt = -log(rand())/0.4;
                RT(roundIndex,1) = roundTime + dt;
                dt = dt + 5;
                roundIndex = roundIndex + 1;
            end
        else
            if rand() <= 0.6
                ns = 2;
                dt = -log(rand())/0.15;
            else
                ns = 0;
                losers = losers + 1;
                dt = -log(rand())/0.2;
                RT(roundIndex,1) = roundTime + dt;
                dt = dt + 5;
                roundIndex = roundIndex + 1;
            end

        end
        roundTime = roundTime + dt;
    end

    if s == 2
        if rand()<=0.6
            ns = 3;
            dt = -log(prod(rand(5,1)))/4;
        else
            ns = 0;
            losers = losers + 1;
            dt = -log(prod(rand(5,1)))/4;           
            RT(roundIndex,1) = roundTime + dt;
            dt = dt + 5;
            roundIndex = roundIndex + 1;
        end
        roundTime = roundTime + dt;
    end

    if s == 3
        winners = winners + 1;
        ns = 0;
        RT(roundIndex,1) = roundTime + dt;
        dt = 5;
        roundIndex = roundIndex + 1;
    end
    
    s = ns;
    t = t + dt;

end

fprintf(1, "Wining rate based on %g matches: %g\n", roundIndex, winners/roundIndex);
fprintf(1, "Average duration of match: %g\n", mean(RT(:,1)));
fprintf(1, "Throughput game/hour: %g\n", roundIndex*60/t);




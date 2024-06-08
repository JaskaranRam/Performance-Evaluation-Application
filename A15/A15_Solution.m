%A15 Solution - Jaskaran Ram

clear all;

N = 80;
Z = 40; %Think Time
S = [0, 50/1000, 2/1000, 80/1000, 80/1000, 120/1000];

P = [
     0 , 1,  0 ,  0 ,  0 , 0  ;
     0.1, 0, 0.4, 0.5,  0 , 0  ;
     0 , 0,  0 ,  0 , 0.6, 0.4;
     0 , 1,  0 ,  0 ,  0 , 0  ;
     0 , 1,  0 ,  0 ,  0 , 0  ;
     0 , 1,  0 ,  0 ,  0 , 0  ;];

P0 = [
     0 , 1,  0 ,  0 ,  0 , 0  ;
     0, 0, 0.4, 0.5,  0 , 0  ;
     0 , 0,  0 ,  0 , 0.6, 0.4;
     0 , 1,  0 ,  0 ,  0 , 0  ;
     0 , 1,  0 ,  0 ,  0 , 0  ;
     0 , 1,  0 ,  0 ,  0 , 0  ;];

l = [1,0,0,0,0,0];
Vk = l * inv(eye(6) -P0);
Dk =Vk .* S;

for k=1:6
    Qk(k) = 0;
end
for n = 1:N
    for k = 1:6
        if(k == 1)
            Rk(k) = Dk(k);
        else
            Rk(k) = Dk(k) * (1+Qk(k)); 
        end
    end
    
    X = n/(Z + sum(Rk));
        
    for k=1:6
        Qk(k)= X*Rk(k);
    end
end

Uk = Dk * X;

fprintf(1, "1. The throughput of the system (X): %g\n", X);
fprintf(1, "2. The average system response time (R): %f\n", sum(Rk));
fprintf(1, "3. The utilization of the [2] ApplicationServer : %f, [4] DBMS: %f, [5] Disk 1 : %f, and [6] Disk 2: %f \n", Uk(2),Uk(4:6));
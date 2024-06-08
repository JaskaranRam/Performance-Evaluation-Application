%Jaskaran Ram - Assignment A08

clear all;

lm = 0.33;
ml = 0.6;
mh = 0.4;
hm = 1;

p_dl = 0.6;
p_dm = 0.3;
p_dh = 0.1;

p_down = 0.05;
p = 6;

Q = [ -(lm + p_down) lm 0 p_down;
      ml -(ml + mh + p_down) mh p_down;
      0 hm -(hm + p_down ) p_down;
      p_dl*p p_dm*p p_dh*p -p*(p_dl + p_dm + p_dh)
    ]

%Start from Medium
p0 = [0, 1, 0, 0];
[t, Sol] = ode45(@(t,x) Q'*x, [0 8], p0');
figure;
plot(t, Sol, "-");
legend("Low","Medium","High","Down");

%Start from Down
p1 = [0, 0, 0, 1];
[t, Sol] = ode45(@(t,x) Q'*x, [0 8], p1');
figure;
plot(t, Sol, "-");
legend("Low","Medium","High","Down");



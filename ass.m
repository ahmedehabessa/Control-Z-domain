J = 3.2284E-6;
b = 3.5077E-6;
K = 0.0274;
R = 4;
L = 2.75E-6;
s = tf('s');
P_motor = K/(s*((J*s+b)*(L*s+R)+K^2));

sys_cl = feedback(P_motor,1)

Ts = 0.001;
dP_motor = c2d(P_motor, Ts, 'zoh');

sys_cl = feedback(dP_motor,1);



%before pid 
[x1,t] = step(sys_cl,.5);
stairs(t,x1)
xlabel('Time (seconds)')
ylabel('Position (radians)')
title('Stairstep Response: Original')


%pid
Kp = 100;
Ki = 200;
Kd = 10;

C = Kp + Ki/s + Kd*s;
dC = c2d(C,Ts,'tustin')


sys_cl = feedback(dC*dP_motor,1)


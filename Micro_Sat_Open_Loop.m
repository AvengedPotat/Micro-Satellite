%% Q2_3_4
constants;
T = 1;
b = [0 0 1];
a = [J_s 0 0];
q1 = tf(b,a)
[A,B,C,D] = tf2ss(b,a)
Poles = pole(q1)
%% Q7 function ss and damp
constants;
A = [0 1 0 0 ; 0 0 -w_mode^2/(1-alpha) -2*c_damp*w_mode/(1-alpha) ; 0 0 0 1 ; 0 0 -w_mode^2/(1-alpha) -2*c_damp*w_mode/(1-alpha)];
B = [0 ; 1/(J_s*(1-alpha)) ; 0 ; alpha-2/(J_s*(1-alpha))];
C = [1 0 0 0];
D = [0];
sys = ss(A,B,C,D);
damp(sys)
%% Q9 linmod 
constants;
[A,B,C,D] = linmod('Q9_linmod');
sys = ss(A,B,C,D)
damp(sys);
%% Q10-13 step, initial, ctrb and obsv 
constants;
A = [0 1 0 0 ; 0 0 -w_mode^2/(1-alpha) -2*c_damp*w_mode/(1-alpha) ; 0 0 0 1 ; 0 0 -w_mode^2/(1-alpha) -2*c_damp*w_mode/(1-alpha)];
B = [0 ; 1/(J_s*(1-alpha)) ; 0 ; alpha/(J_s*(1-alpha))];
C = [1 0 0 0];
D = [0];
sys = ss(A,B,C,D);
figure(1);
step(sys)
grid;
x0 = [0 ; 0 ; 1 ; 0];
figure(2);
initial(sys,x0)
figure(3);
bode(sys)
figure(4);
nichols(sys)
Co = ctrb(sys)
Co_rank = rank(Co)
Ob = obsv(sys)
Ob_rank = rank(Ob)
%% H_inf satellite
clear; clc;
[a,b,c,d]=linmod('HinfDesign1');
P=ss(a,b,c,d);
ni=3; no=1;
K0=ltiblock.gain('K0',no,ni);
CLO=lft(P,K0);

W1=300*tf(1,[700 1]); W2=1;
CLOW=blkdiag(W1,W2)*CLO;

opt=hinfstructOptions('RandomStart',3);
[CL,normHinf]=hinfstruct(CLOW,opt);
K=ss(CL.Blocks.K0);
sim('HinfDesign1_closed');
%% No dev ???
clear; clc;
[a,b,c,d]=linmod('HinfDesign1_nodev');
P=ss(a,b,c,d);
ni=2; no=1;
K0=ltiblock.gain('K0',no,ni);
CLO=lft(P,K0);

W1=300*tf(1,[50 1]); W2=1;
CLOW=blkdiag(W1,W2)*CLO;

opt=hinfstructOptions('RandomStart',3);
[CL,normHinf]=hinfstruct(CLOW,opt);
K=ss(CL.Blocks.K0);
sim('HinfDesign1_nodev_closed');
%% Integrator
%clear; clc;
del=0;
[a,b,c,d]=linmod('HinfDesign2');
P=ss(a,b,c,d);
ni=4; no=1;
K0=ltiblock.gain('K0',no,ni);
CLO=lft(P,K0);

W1=0.4; W2=0.8; W3=0.3;
CL12=blkdiag(W1,W2)*CLO(1:2,1);
CL3=W3*CLO(3,2);
CLOW=blkdiag(CL12,CL3);

opt=hinfstructOptions('RandomStart',3);
[CL,normHinf]=hinfstruct(CLOW,opt);
K=ss(CL.Blocks.K0);
delc=0; sim('HinfDesign2_closed');
%% Multi model
clear; clc;
del=0;
[a,b,c,d]=linmod('HinfDesign2');
P1=ss(a,b,c,d);

del=0.3;
[a,b,c,d]=linmod('HinfDesign2');
P2=ss(a,b,c,d);

del=-0.3;
[a,b,c,d]=linmod('HinfDesign2');
P3=ss(a,b,c,d);

ni=4; no=1;
K0=ltiblock.gain('K0',no,ni);
CLO_central=lft(P1,K0);
CLO_wc1=lft(P2,K0);
CLO_wc2=lft(P3,K0);

W1=0.4; W2=0.8; W3=0.3;
CL12_central=blkdiag(W1,W2)*CLO_central(1:2,1);
CL12_wc1=blkdiag(W1,W2)*CLO_wc1(1:2,1);
CL12_wc2=blkdiag(W1,W2)*CLO_wc2(1:2,1);
CL3_central=W3*CLO_central(3,2);
CL3_wc1=W3*CLO_wc1(3,2);
CL3_wc2=W3*CLO_wc2(3,2);
CLOW_central=blkdiag(CL12_central,CL3_central);
CLOW_wc1=blkdiag(CL12_wc1,CL3_wc1);
CLOW_wc2=blkdiag(CL12_wc2,CL3_wc2);

r0=0.3; r1=0.9; r2=0.3;
CLOW=blkdiag(r0*CLOW_central,r1*CLOW_wc1,r2*CLOW_wc2);

opt=hinfstructOptions('RandomStart',3);
[CL,normHinf]=hinfstruct(CLOW,opt);
K=ss(CL.Blocks.K0);

delc=0.3; sim('HinfDesign2_closed');

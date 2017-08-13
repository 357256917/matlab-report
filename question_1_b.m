%% question b
n=200;
A1 = gallery('poisson',n); 
b = ones(n^2,1);
A = A1 + 0.01*speye(n^2);
tol = 10^-8;

tic; 
maxit=1000;
[x,flag,relres,iter] = cgs(A,b,tol,maxit);  
time_cgs=toc;
min_x=min(x);
fprintf('%d is the minimum value of x. \n',min_x);

%get an ilu(0) preconditioner
maxit0 = 10000;
option.type = 'nofill';
option.droptol = 0.5;
[P1_L,P1_U] = ilu(A, option );
[x0,flag0,relres0,iter0] = cgs(A,b,tol,maxit0,P1_L,P1_U);
time_ilu0 = toc - time_cgs;


%using the Crout version of ILU
maxit1 = 10000;
option.type = 'crout';
option.droptol = 0.5;
[P2_L,P2_U] = ilu(A, option);
[x1,flag1,relres1,iter1] = cgs(A,b,tol,maxit1,P2_L,P2_U);
time_ilu1 = toc-time_cgs- time_ilu0;

speedup_ilu0 = (time_cgs-time_ilu0)/time_cgs;
speedup_ilu1 = (time_cgs-time_ilu1)/time_cgs;



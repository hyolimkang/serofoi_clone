functions {
row_vector lambda_yexpo_fun (row_vector lambda,
                             int Ymax){

 row_vector[Ymax] lambda_yexpo;
  int StartDec1 = Ymax - 4;
  int StartDec2 = 1;
  int EndDec1   = Ymax;
  int EndDec2   = StartDec1-1;

   for (j in StartDec1: EndDec1) lambda_yexpo[j] = lambda[2];
   for (k in StartDec2: EndDec2) lambda_yexpo[k] = lambda[1];
   return lambda_yexpo;
  }
}




data {
     int<lower=0> Nobs;
     int Npos[Nobs];
     int Ntotal[Nobs];
     int Age[Nobs];
     int <lower=1>Ymax;
     matrix[Nobs, Ymax] AgeExpoMatrix;
     int <lower=1>NDecades;
}

parameters {
   
   row_vector<lower=0>[NDecades +1]lambda;
   real<lower=0> sigma;
   real<lower=0> nu;
}

transformed parameters {
  real P[Nobs];
  real ScalerDotProduct[Nobs];
  row_vector<lower=0>[Ymax] foi;


 foi = lambda_yexpo_fun (lambda,Ymax);

 for (i in 1:Nobs){
   ScalerDotProduct[i] = dot_product(AgeExpoMatrix[i,], foi);
   P[i] = 1 - exp(-ScalerDotProduct[i]);
 }
}

model 
{
  for (i in 1:Nobs)
    Npos[i] ~ binomial(Ntotal[i], P[i]) ;
      sigma ~ cauchy(0, 1);
         nu ~ cauchy(0, 1);

    lambda[2] ~ student_t(nu, lambda[1], sigma);
    lambda[1] ~ normal(0, 1);

}


generated quantities{
  vector[Nobs] Npos_sim;
  vector[Nobs] P_sim;
  vector[Nobs] logLikelihood;
  for(i in 1:Nobs){
    Npos_sim[i] = binomial_rng(Ntotal[i], P[i]);
    P_sim[i] = Npos_sim[i] / Ntotal[i];
    logLikelihood[i] = binomial_lpmf(Npos[i] | Ntotal[i], P[i]);
  }
}
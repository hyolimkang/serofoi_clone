data {
     int<lower=0> Nobs;
     int Npos[Nobs];
     int Ntotal[Nobs];
     int Age[Nobs];
     int <lower=1>Ymax;
     matrix[Nobs, Ymax] AgeExpoMatrix;
}

parameters {
   row_vector[Ymax] log_foi;
   real<lower=0> sigma;
   real<lower=0> nu;
   real kappa;
}

transformed parameters {
  real P[Nobs];
  real ScalerDotProduct[Nobs];
  row_vector<lower=0>[Ymax] foi;
 for(i in 1:Ymax)
  foi[i] = exp(log_foi[i]);
  
 for (i in 1:Nobs){
   ScalerDotProduct[i] = dot_product(AgeExpoMatrix[i,], foi);
   P[i] = 1 - exp(-ScalerDotProduct[i]);
 }
 
}

model {
  for (i in 1:Nobs)
  Npos[i] ~ beta_binomial(Ntotal[i], kappa * P[i], kappa * (1 - P[i]));
  kappa ~ pareto(1, 1.5);
   
  sigma ~ cauchy(0, 1);
  nu ~ cauchy(0, 1);
  
  for(i in 2:Ymax)
    log_foi[i] ~ student_t(nu, log_foi[i - 1], sigma);
  log_foi[1] ~ normal(-6, 4);
}


generated quantities{
  vector[Nobs] Npos_sim;
  vector[Nobs] P_sim;
  vector[Nobs] logLikelihood;
  for(i in 1:Nobs){
    Npos_sim[i] = binomial_rng(Ntotal[i], P[i]);
    P_sim[i] = Npos_sim[i] / Ntotal[i];
    logLikelihood[i] = binomial_lpmf(Npos[i] | Ntotal[i], P[i]);
    
    Npos_sim[i] = beta_binomial_rng(Ntotal[i], kappa * P[i], kappa * (1 - P[i]));
    P_sim[i] = Npos_sim[i] / Ntotal[i];
    logLikelihood[i] = beta_binomial_lpmf(Npos[i] | Ntotal[i], kappa * P[i], kappa * (1 - P[i]));
    
  }
}
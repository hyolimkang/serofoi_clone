

## Compiling models from stan

MDecades5_t     <- stan_model('stanmodels/decades5_foi_st_fixed.stan')
saveRDS(MDecades5_t, 'stanmodels/MDecades5_t.RDS')

MDecades4_t     <- stan_model('stanmodels/decades4_foi_st_fixed.stan')
saveRDS(MDecades4_t, 'stanmodels/MDecades4_t.RDS')

MDecades3_t     <- stan_model('stanmodels/decades3_foi_st.stan')
saveRDS(MDecades3_t, 'stanmodels/MDecades3_t.RDS')

MDecades2_t     <- stan_model('stanmodels/decades2_foi_st.stan')
saveRDS(MDecades2_t, 'stanmodels/MDecades2_t.RDS')

MDecades1_t     <- stan_model('stanmodels/decades1_foi_st.stan')
saveRDS(MDecades1_t, 'stanmodels/MDecades1_t.RDS')


## Reading compiled models in .RDS

MDecades5_t    <- readRDS('stanmodels/MDecades5_t.RDS')
MDecades4_t    <- readRDS('stanmodels/MDecades4_t.RDS')
MDecades3_t    <- readRDS('stanmodels/MDecades3_t.RDS')
MDecades2_t    <- readRDS('stanmodels/MDecades2_t.RDS')
MDecades1_t    <- readRDS('stanmodels/MDecades1_t.RDS')


# For Run model function

if (age_max > 40) {
  NDecades <- 5
  ModDecades <-  MDecades5_t
  modelD_name <- '5Dec-T'
}

if (age_max < 41 & age_max >30) {
  NDecades <- 4
  ModDecades <-  MDecades4_t
  modelD_name <- '4Dec-T'
}

if (age_max <31 & age_max >20) {
  NDecades <- 3
  ModDecades <-  MDecades3_t
  modelD_name <- '3Dec-T'
}
if (age_max <21 & age_max >10) {
  NDecades <- 2
  ModDecades <-  MDecades2_t
  modelD_name <- '2Dec-T'
}

if (age_max <11) {
  NDecades <- 1
  ModDecades <-  MDecades1_t
  modelD_name <- '1Dec-T'
}



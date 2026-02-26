> # ============================================
> # AIM 6: HIERARCHICAL MULTINOMIAL LOGISTIC REGRESSION
  > # ============================================
> 
  > library(nnet)
> library(pscl)
> 
  > # Define the blocks
  > # Block 1: Demographics
  > # Block 2: Relationship Competency (Aim 2)
  > # Block 3: Self-Competency (Aim 3)
  > # Block 4: IPV Beliefs (Aim 4) - excluding peer_dv_exposure (placed in Block 5)
  > # Block 5: Environmental Exposure (Aim 5) - including peer_dv_exposure
  > 
  > # First, create a substance use count variable (avoids binary variable overfitting)
  > data$substance_count <- rowSums(cbind(
    +     as.numeric(data$tobacco == "Y"),
    +     as.numeric(data$cannabis == "Y"),
    +     as.numeric(data$cocaine == "Y"),
    +     as.numeric(data$amphetamines == "Y"),
    +     as.numeric(data$inhalants == "Y"),
    +     as.numeric(data$sedatives == "Y"),
    +     as.numeric(data$hallucinogens == "Y"),
    +     as.numeric(data$opioids == "Y")
    + ), na.rm = FALSE)
  > 
    > cat("=== Substance count distribution ===\n")
  === Substance count distribution ===
    > print(table(data$substance_count, useNA = "ifany"))
  
  0    1    2    3    4    5    7    8 <NA> 
    116   29   18    4    1    1    1    2   34 
  > 
    > # Check complete cases for each block
    > block1_vars <- c("age", "gender")
  > block2_vars <- c("personal_conflict", "partner_conflict", "positive_support", 
                     +                  "negative_family_comm", "coping", "interpersonal", 
                     +                  "caregiver_relationship", "relationship_tension")
  > block3_vars <- c("inadequacy", "locus_control", "self_esteem", "self_reliance")
  > block4_vars <- c("justify_women", "justify_men", "dv_prevalence_belief", 
                     +                  "need_help_belief", "service_awareness", "advocacy_interest")
  > block5_vars <- c("ace_score", "unfair_treatment", "social_stress", 
                     +                  "alcohol_use", "peer_dv_exposure", "substance_count")
  > 
    > all_vars <- c("ipv_group3", block1_vars, block2_vars, block3_vars, block4_vars, block5_vars)
  > cat("\n=== Complete cases by cumulative block ===\n")
  
  === Complete cases by cumulative block ===
    > cat("Block 1 (Demo):", sum(complete.cases(data[, c("ipv_group3", block1_vars)])), "\n")
  Block 1 (Demo): 138 
  > cat("Block 1+2 (+RelComp):", sum(complete.cases(data[, c("ipv_group3", block1_vars, block2_vars)])), "\n")
  Block 1+2 (+RelComp): 74 
  > cat("Block 1+2+3 (+SelfComp):", sum(complete.cases(data[, c("ipv_group3", block1_vars, block2_vars, block3_vars)])), "\n")
  Block 1+2+3 (+SelfComp): 62 
  > cat("Block 1+2+3+4 (+Beliefs):", sum(complete.cases(data[, c("ipv_group3", block1_vars, block2_vars, block3_vars, block4_vars)])), "\n")
  Block 1+2+3+4 (+Beliefs): 43 
  > cat("Block 1+2+3+4+5 (Full):", sum(complete.cases(data[, all_vars])), "\n")
  Block 1+2+3+4+5 (Full): 24 
  > # ============================================
  > # AIM 6: APPROACH 1 - DOMAIN-LEVEL COMPARISON
    > # Run each domain separately to compare variance explained
    > # ============================================
  > 
    > cat("=============================================================\n")
  =============================================================
    > cat("APPROACH 1: DOMAIN-LEVEL MODEL COMPARISON\n")
  APPROACH 1: DOMAIN-LEVEL MODEL COMPARISON
  > cat("Each domain run separately with demographics as baseline\n")
  Each domain run separately with demographics as baseline
  > cat("=============================================================\n\n")
  =============================================================
    
    > 
    > # Model 0: Demographics only (baseline)
    > cat("--- MODEL 0: DEMOGRAPHICS ONLY (BASELINE) ---\n")
  --- MODEL 0: DEMOGRAPHICS ONLY (BASELINE) ---
    > m0 <- multinom(ipv_group3 ~ age + gender, data = data, maxit = 500)
  # weights:  12 (6 variable)
  initial  value 151.608496 
  iter  10 value 108.961240
  final  value 108.961231 
  converged
  > cat("N =", nrow(m0$fitted.values), "\n")
  N = 138 
  > print(pR2(m0))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 151.608496 
  final  value 109.999484 
  converged
  llh       llhNull            G2      McFadden          r2ML          r2CU 
  -1.089612e+02 -1.099995e+02  2.076507e+00  9.438714e-03  1.493451e-02  1.874010e-02 
  > 
    > # Model A: Relationship Competency (Aim 2)
    > cat("\n--- MODEL A: RELATIONSHIP COMPETENCY (Aim 2) ---\n")
  
  --- MODEL A: RELATIONSHIP COMPETENCY (Aim 2) ---
    > mA <- multinom(ipv_group3 ~ personal_conflict + partner_conflict + positive_support + 
                       +                    negative_family_comm + coping + interpersonal + 
                       +                    caregiver_relationship + relationship_tension + age + gender, 
                     +                data = data, maxit = 500)
  # weights:  36 (22 variable)
  initial  value 81.297309 
  iter  10 value 47.516158
  iter  20 value 35.543741
  iter  30 value 33.725444
  iter  40 value 33.049370
  final  value 33.019869 
  converged
  > cat("N =", nrow(mA$fitted.values), "\n")
  N = 74 
  > print(pR2(mA))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 81.297309 
  final  value 51.636341 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -33.0198687 -51.6363412  37.2329449   0.3605304   0.3953756   0.5255489 
  > 
    > # Model B: Self-Competency (Aim 3)
    > cat("\n--- MODEL B: SELF-COMPETENCY (Aim 3) ---\n")
  
  --- MODEL B: SELF-COMPETENCY (Aim 3) ---
    > mB <- multinom(ipv_group3 ~ inadequacy + locus_control + self_esteem + self_reliance + 
                       +                    age + gender, data = data, maxit = 500)
  # weights:  24 (14 variable)
  initial  value 108.762617 
  iter  10 value 74.096368
  iter  20 value 70.464971
  final  value 70.375026 
  converged
  > cat("N =", nrow(mB$fitted.values), "\n")
  N = 99 
  > print(pR2(mB))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 108.762617 
  final  value 80.917945 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -70.3750260 -80.9179449  21.0858379   0.1302915   0.1918344   0.2383064 
  > 
    > # Model C: IPV Beliefs (Aim 4)
    > cat("\n--- MODEL C: IPV BELIEFS (Aim 4) ---\n")
  
  --- MODEL C: IPV BELIEFS (Aim 4) ---
    > mC <- multinom(ipv_group3 ~ justify_women + justify_men + dv_prevalence_belief + 
                       +                    need_help_belief + service_awareness + advocacy_interest + age + gender, 
                     +                data = data, maxit = 500)
  # weights:  30 (18 variable)
  initial  value 87.888983 
  iter  10 value 49.185006
  iter  20 value 45.288464
  iter  30 value 45.222266
  final  value 45.221245 
  converged
  > cat("N =", nrow(mC$fitted.values), "\n")
  N = 80 
  > print(pR2(mC))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 87.888983 
  final  value 55.703927 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -45.2212454 -55.7039266  20.9653624   0.1881857   0.2305406   0.3067449 
  > 
    > # Model D: Environmental Exposure (Aim 5)
    > cat("\n--- MODEL D: ENVIRONMENTAL EXPOSURE (Aim 5) ---\n")
  
  --- MODEL D: ENVIRONMENTAL EXPOSURE (Aim 5) ---
    > mD <- multinom(ipv_group3 ~ ace_score + unfair_treatment + social_stress + 
                       +                    alcohol_use + peer_dv_exposure + substance_count + age + gender, 
                     +                data = data, maxit = 500)
  # weights:  30 (18 variable)
  initial  value 51.634778 
  iter  10 value 16.773619
  iter  20 value 11.942806
  iter  30 value 11.264269
  iter  40 value 11.077237
  iter  50 value 11.068747
  iter  60 value 11.057875
  iter  70 value 11.052850
  final  value 11.052268 
  converged
  > cat("N =", nrow(mD$fitted.values), "\n")
  N = 47 
  > print(pR2(mD))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 51.634778 
  iter  10 value 25.941183
  final  value 25.941182 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -11.0522683 -25.9411819  29.7778271   0.5739489   0.4693066   0.7021154 
  > 
    > # Also demographics-only models matched to each domain's sample
    > cat("\n\n--- DEMOGRAPHICS-ONLY BASELINES (MATCHED SAMPLES) ---\n")
  
  
  --- DEMOGRAPHICS-ONLY BASELINES (MATCHED SAMPLES) ---
    > cat("(To fairly compare delta R-squared)\n\n")
  (To fairly compare delta R-squared)
  
  > 
    > # Get complete cases for each domain
    > ccA <- complete.cases(data[, c("ipv_group3", "age", "gender", block2_vars)])
  > ccB <- complete.cases(data[, c("ipv_group3", "age", "gender", block3_vars)])
  > ccC <- complete.cases(data[, c("ipv_group3", "age", "gender", block4_vars)])
  > ccD <- complete.cases(data[, c("ipv_group3", "age", "gender", block5_vars)])
  > 
    > m0A <- multinom(ipv_group3 ~ age + gender, data = data[ccA,], maxit = 500)
  # weights:  12 (6 variable)
  initial  value 81.297309 
  iter  10 value 49.708780
  final  value 49.676695 
  converged
  > m0B <- multinom(ipv_group3 ~ age + gender, data = data[ccB,], maxit = 500)
  # weights:  12 (6 variable)
  initial  value 108.762617 
  iter  10 value 79.243422
  final  value 79.243317 
  converged
  > m0C <- multinom(ipv_group3 ~ age + gender, data = data[ccC,], maxit = 500)
  # weights:  12 (6 variable)
  initial  value 87.888983 
  iter  10 value 53.561559
  final  value 53.548584 
  converged
  > m0D <- multinom(ipv_group3 ~ age + gender, data = data[ccD,], maxit = 500)
  # weights:  12 (6 variable)
  initial  value 51.634778 
  iter  10 value 25.478452
  iter  20 value 25.466888
  final  value 25.466296 
  converged
  > 
    > cat("Demo baseline (Aim 2 sample, n=", sum(ccA), "):\n", sep="")
  Demo baseline (Aim 2 sample, n=74):
    > print(pR2(m0A))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 81.297309 
  final  value 51.636341 
  converged
  llh      llhNull           G2     McFadden         r2ML         r2CU 
  -49.67669460 -51.63634117   3.91929313   0.03795092   0.05158530   0.06856921 
  > cat("\nDemo baseline (Aim 3 sample, n=", sum(ccB), "):\n", sep="")
  
  Demo baseline (Aim 3 sample, n=99):
    > print(pR2(m0B))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 108.762617 
  final  value 80.917945 
  converged
  llh      llhNull           G2     McFadden         r2ML         r2CU 
  -79.24331736 -80.91794491   3.34925510   0.02069538   0.03326500   0.04132347 
  > cat("\nDemo baseline (Aim 4 sample, n=", sum(ccC), "):\n", sep="")
  
  Demo baseline (Aim 4 sample, n=80):
    > print(pR2(m0C))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 87.888983 
  final  value 55.703927 
  converged
  llh      llhNull           G2     McFadden         r2ML         r2CU 
  -53.54858394 -55.70392662   4.31068536   0.03869283   0.05245757   0.06979723 
  > cat("\nDemo baseline (Aim 5 sample, n=", sum(ccD), "):\n", sep="")
  
  Demo baseline (Aim 5 sample, n=47):
    > print(pR2(m0D))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 51.634778 
  iter  10 value 25.941183
  final  value 25.941182 
  converged
  llh      llhNull           G2     McFadden         r2ML         r2CU 
  -25.46629637 -25.94118190   0.94977107   0.01830624   0.02000508   0.02992900 
  > # ============================================
  > # AIM 6: APPROACH 2 - REDUCED HIERARCHICAL MODEL
    > # Best predictors from each domain
    > # ============================================
  > 
    > cat("=============================================================\n")
  =============================================================
    > cat("APPROACH 2: REDUCED HIERARCHICAL MULTINOMIAL REGRESSION\n")
  APPROACH 2: REDUCED HIERARCHICAL MULTINOMIAL REGRESSION
  > cat("Strongest predictors from each domain\n")
  Strongest predictors from each domain
  > cat("=============================================================\n\n")
  =============================================================
    
    > 
    > # Check complete cases with reduced variable set
    > reduced_vars <- c("ipv_group3", "age", "gender", 
                        +                   "relationship_tension", "negative_family_comm",
                        +                   "locus_control", "inadequacy",
                        +                   "justify_women", "dv_prevalence_belief",
                        +                   "social_stress", "peer_dv_exposure", "ace_score")
  > cat("Complete cases for reduced model:", sum(complete.cases(data[, reduced_vars])), "\n\n")
  Complete cases for reduced model: 56 
  
  > 
    > # Create analysis dataset with complete cases
    > aim6_data <- data[complete.cases(data[, reduced_vars]), ]
  > cat("Analysis sample: N =", nrow(aim6_data), "\n")
  Analysis sample: N = 56 
  > cat("Group sizes:\n")
  Group sizes:
    > print(table(aim6_data$ipv_group3))
  
  No IPV   Victim Only Bidirectional 
  8             5            43 
  > 
    > # BLOCK 1: Demographics only
    > cat("\n\n--- BLOCK 1: DEMOGRAPHICS ---\n")
  
  
  --- BLOCK 1: DEMOGRAPHICS ---
    > h1 <- multinom(ipv_group3 ~ age + gender, data = aim6_data, maxit = 500)
  # weights:  12 (6 variable)
  initial  value 61.522288 
  iter  10 value 37.972985
  iter  20 value 37.962462
  final  value 37.962085 
  converged
  > print(summary(h1))
  Call:
    multinom(formula = ipv_group3 ~ age + gender, data = aim6_data, 
             maxit = 500)
  
  Coefficients:
    (Intercept)         age genderFemale
  Victim Only    1.10124804 -0.10411277     1.001543
  Bidirectional  0.09615498  0.06935586     0.376763
  
  Std. Errors:
    (Intercept)       age genderFemale
  Victim Only      3.865568 0.1956766    1.1833954
  Bidirectional    2.582852 0.1279510    0.8059356
  
  Residual Deviance: 75.92417 
  AIC: 87.92417 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h1))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh      llhNull           G2     McFadden         r2ML         r2CU 
  -37.96208466 -39.00536784   2.08656637   0.02674717   0.03657450   0.04865682 
  > 
    > # BLOCK 2: + Relationship Competency
    > cat("\n\n--- BLOCK 2: + RELATIONSHIP COMPETENCY ---\n")
  
  
  --- BLOCK 2: + RELATIONSHIP COMPETENCY ---
    > h2 <- multinom(ipv_group3 ~ age + gender + 
                       +                    relationship_tension + negative_family_comm, 
                     +                data = aim6_data, maxit = 500)
  # weights:  18 (10 variable)
  initial  value 61.522288 
  iter  10 value 35.758392
  iter  20 value 35.494392
  iter  30 value 35.493674
  final  value 35.493654 
  converged
  > print(summary(h2))
  Call:
    multinom(formula = ipv_group3 ~ age + gender + relationship_tension + 
               negative_family_comm, data = aim6_data, maxit = 500)
  
  Coefficients:
    (Intercept)         age genderFemale relationship_tension negative_family_comm
  Victim Only      1.713257 -0.19775570    1.3123902            1.1766423          -0.01425145
  Bidirectional   -2.882434  0.03475085    0.6436265            0.5827156           0.09188104
  
  Std. Errors:
    (Intercept)      age genderFemale relationship_tension negative_family_comm
  Victim Only      7.266234 0.218422    1.2470687            0.6674033            0.1819471
  Bidirectional    4.244186 0.133106    0.8585057            0.4834925            0.1042111
  
  Residual Deviance: 70.98731 
  AIC: 90.98731 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h2))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh      llhNull           G2     McFadden         r2ML         r2CU 
  -35.49365439 -39.00536784   7.02342690   0.09003154   0.11787220   0.15681107 
  > 
    > # BLOCK 3: + Self-Competency
    > cat("\n\n--- BLOCK 3: + SELF-COMPETENCY ---\n")
  
  
  --- BLOCK 3: + SELF-COMPETENCY ---
    > h3 <- multinom(ipv_group3 ~ age + gender + 
                       +                    relationship_tension + negative_family_comm +
                       +                    locus_control + inadequacy, 
                     +                data = aim6_data, maxit = 500)
  # weights:  24 (14 variable)
  initial  value 61.522288 
  iter  10 value 35.555028
  iter  20 value 31.097940
  iter  30 value 30.958021
  iter  40 value 30.957980
  final  value 30.957971 
  converged
  > print(summary(h3))
  Call:
    multinom(formula = ipv_group3 ~ age + gender + relationship_tension + 
               negative_family_comm + locus_control + inadequacy, data = aim6_data, 
             maxit = 500)
  
  Coefficients:
    (Intercept)        age genderFemale relationship_tension negative_family_comm
  Victim Only     -3.847164 -0.1442082    1.5158467            1.0861485          -0.03191732
  Bidirectional   -8.909897  0.1128631    0.8181985            0.5335221           0.01379867
  locus_control inadequacy
  Victim Only       0.2115518 0.01090556
  Bidirectional     0.1301641 0.18581743
  
  Std. Errors:
    (Intercept)       age genderFemale relationship_tension negative_family_comm
  Victim Only      8.689542 0.2526441     1.385529            0.7168576            0.2090249
  Bidirectional    5.691030 0.1653375     1.050641            0.5636418            0.1183736
  locus_control inadequacy
  Victim Only       0.1588380  0.2353798
  Bidirectional     0.1095542  0.1763138
  
  Residual Deviance: 61.91594 
  AIC: 89.91594 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h3))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -30.9579709 -39.0053678  16.0947938   0.2063151   0.2497937   0.3323126 
  > 
    > # BLOCK 4: + IPV Beliefs
    > cat("\n\n--- BLOCK 4: + IPV BELIEFS ---\n")
  
  
  --- BLOCK 4: + IPV BELIEFS ---
    > h4 <- multinom(ipv_group3 ~ age + gender + 
                       +                    relationship_tension + negative_family_comm +
                       +                    locus_control + inadequacy +
                       +                    justify_women + dv_prevalence_belief, 
                     +                data = aim6_data, maxit = 500)
  # weights:  30 (18 variable)
  initial  value 61.522288 
  iter  10 value 30.810471
  iter  20 value 24.659734
  iter  30 value 23.973218
  iter  40 value 23.846218
  iter  50 value 23.844873
  iter  60 value 23.843596
  final  value 23.843575 
  converged
  > print(summary(h4))
  Call:
    multinom(formula = ipv_group3 ~ age + gender + relationship_tension + 
               negative_family_comm + locus_control + inadequacy + justify_women + 
               dv_prevalence_belief, data = aim6_data, maxit = 500)
  
  Coefficients:
    (Intercept)         age genderFemale relationship_tension negative_family_comm
  Victim Only    -14.766726 -0.14769998    1.4587805            2.3985965          -0.26908546
  Bidirectional   -5.062683  0.02666558    0.5122603            0.7095356          -0.07899978
  locus_control inadequacy justify_women dv_prevalence_belief
  Victim Only     -0.06950267  0.2126599    0.38029419            0.1804163
  Bidirectional    0.14157820  0.1582846   -0.02150863            0.1552552
  
  Std. Errors:
    (Intercept)       age genderFemale relationship_tension negative_family_comm
  Victim Only      11.60587 0.2455147     1.686289            1.2298062            0.2836481
  Bidirectional     6.12681 0.1913503     1.196146            0.7127766            0.1719885
  locus_control inadequacy justify_women dv_prevalence_belief
  Victim Only       0.2156161  0.2756262    0.18856970           0.13200807
  Bidirectional     0.1261183  0.1968155    0.06644482           0.08895496
  
  Residual Deviance: 47.68715 
  AIC: 83.68715 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h4))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -23.8435751 -39.0053678  30.3235854   0.3887104   0.4181209   0.5562464 
  > 
    > # BLOCK 5: + Environmental Exposure
    > cat("\n\n--- BLOCK 5: + ENVIRONMENTAL EXPOSURE (FULL MODEL) ---\n")
  
  
  --- BLOCK 5: + ENVIRONMENTAL EXPOSURE (FULL MODEL) ---
    > h5 <- multinom(ipv_group3 ~ age + gender + 
                       +                    relationship_tension + negative_family_comm +
                       +                    locus_control + inadequacy +
                       +                    justify_women + dv_prevalence_belief +
                       +                    social_stress + peer_dv_exposure + ace_score, 
                     +                data = aim6_data, maxit = 500)
  # weights:  39 (24 variable)
  initial  value 61.522288 
  iter  10 value 27.673233
  iter  20 value 20.753548
  iter  30 value 14.734280
  iter  40 value 14.279524
  iter  50 value 14.198368
  iter  60 value 14.198302
  iter  70 value 14.198217
  final  value 14.198208 
  converged
  > print(summary(h5))
  Call:
    multinom(formula = ipv_group3 ~ age + gender + relationship_tension + 
               negative_family_comm + locus_control + inadequacy + justify_women + 
               dv_prevalence_belief + social_stress + peer_dv_exposure + 
               ace_score, data = aim6_data, maxit = 500)
  
  Coefficients:
    (Intercept)          age genderFemale relationship_tension negative_family_comm
  Victim Only    -22.646611 -5.822426753  -11.0472985           54.7012331           -3.6328469
  Bidirectional   -5.533538  0.009869452    0.8581596            0.7817984           -0.0329399
  locus_control inadequacy justify_women dv_prevalence_belief social_stress
  Victim Only      -2.9665084  5.0287582    5.26237998            3.6645137    -8.7117844
  Bidirectional     0.1489899  0.1541267   -0.01415996            0.1419419    -0.0567693
  peer_dv_exposure ace_score
  Victim Only        -12.7679439  6.459735
  Bidirectional       -0.1038032  0.123904
  
  Std. Errors:
    (Intercept)        age genderFemale relationship_tension negative_family_comm
  Victim Only     0.7161289 28.0146534     2.763290             5.562652           20.7640204
  Bidirectional   6.2902142  0.2006167     1.323883             0.839560            0.1681264
  locus_control inadequacy justify_women dv_prevalence_belief social_stress
  Victim Only      18.6979530 26.3432102   24.66518532          27.19224497    43.2486383
  Bidirectional     0.1926657  0.2117181    0.06908524           0.09226411     0.2063978
  peer_dv_exposure  ace_score
  Victim Only          7.5834125 24.6018846
  Bidirectional        0.3598185  0.2488771
  
  Residual Deviance: 28.39642 
  AIC: 76.39642 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h5))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -14.1982082 -39.0053678  49.6143192   0.6359935   0.5876860   0.7818269 
  > 
    > # Z-scores and p-values for final model
    > cat("\n--- FINAL MODEL Z-SCORES ---\n")
  
  --- FINAL MODEL Z-SCORES ---
    > z <- summary(h5)$coefficients / summary(h5)$standard.errors
  > print(round(z, 3))
  (Intercept)    age genderFemale relationship_tension negative_family_comm
  Victim Only       -31.624 -0.208       -3.998                9.834               -0.175
  Bidirectional      -0.880  0.049        0.648                0.931               -0.196
  locus_control inadequacy justify_women dv_prevalence_belief social_stress
  Victim Only          -0.159      0.191         0.213                0.135        -0.201
  Bidirectional         0.773      0.728        -0.205                1.538        -0.275
  peer_dv_exposure ace_score
  Victim Only             -1.684     0.263
  Bidirectional           -0.288     0.498
  > 
    > cat("\n--- FINAL MODEL P-VALUES ---\n")
  
  --- FINAL MODEL P-VALUES ---
    > p <- (1 - pnorm(abs(z), 0, 1)) * 2
  > print(round(p, 4))
  (Intercept)    age genderFemale relationship_tension negative_family_comm
  Victim Only         0.000 0.8354       0.0001               0.0000               0.8611
  Bidirectional       0.379 0.9608       0.5168               0.3518               0.8447
  locus_control inadequacy justify_women dv_prevalence_belief social_stress
  Victim Only          0.8739     0.8486        0.8311               0.8928        0.8404
  Bidirectional        0.4393     0.4666        0.8376               0.1239        0.7833
  peer_dv_exposure ace_score
  Victim Only             0.0922    0.7929
  Bidirectional           0.7730    0.6186
  > 
    > cat("\n--- FINAL MODEL ODDS RATIOS ---\n")
  
  --- FINAL MODEL ODDS RATIOS ---
    > print(round(exp(coef(h5)), 3))
  (Intercept)   age genderFemale relationship_tension negative_family_comm locus_control
  Victim Only         0.000 0.003        0.000         5.707471e+23                0.026         0.051
  Bidirectional       0.004 1.010        2.359         2.185000e+00                0.968         1.161
  inadequacy justify_women dv_prevalence_belief social_stress peer_dv_exposure ace_score
  Victim Only      152.743       192.940               39.037         0.000            0.000   638.892
  Bidirectional      1.167         0.986                1.153         0.945            0.901     1.132
  > 
    > cat("\n--- FINAL MODEL OR CONFIDENCE INTERVALS ---\n")
  
  --- FINAL MODEL OR CONFIDENCE INTERVALS ---
    > print(round(exp(confint(h5)), 3))
  , , Victim Only
  
  2.5 %       97.5 %
    (Intercept)          0.000000e+00 0.000000e+00
  age                  0.000000e+00 2.077153e+21
  genderFemale         0.000000e+00 4.000000e-03
  relationship_tension 1.050765e+19 3.100143e+28
  negative_family_comm 0.000000e+00 1.249225e+16
  locus_control        0.000000e+00 4.240219e+14
  inadequacy           0.000000e+00 4.048957e+24
  justify_women        0.000000e+00 1.907508e+23
  dv_prevalence_belief 0.000000e+00 5.464607e+24
  social_stress        0.000000e+00 1.071094e+33
  peer_dv_exposure     0.000000e+00 8.128000e+00
  ace_score            0.000000e+00 5.579423e+23
  
  , , Bidirectional
  
  2.5 %  97.5 %
    (Intercept)          0.000 893.419
  age                  0.682   1.496
  genderFemale         0.176  31.593
  relationship_tension 0.422  11.328
  negative_family_comm 0.696   1.345
  locus_control        0.796   1.693
  inadequacy           0.770   1.767
  justify_women        0.861   1.129
  dv_prevalence_belief 0.962   1.381
  social_stress        0.630   1.416
  peer_dv_exposure     0.445   1.825
  ace_score            0.695   1.844
  
  > 
    > # HIERARCHICAL COMPARISON TABLE
    > cat("\n\n=== HIERARCHICAL MODEL COMPARISON ===\n")
  
  
  === HIERARCHICAL MODEL COMPARISON ===
    > cat("Block | Variables Added                    | Nagelkerke R2 | Delta R2\n")
  Block | Variables Added                    | Nagelkerke R2 | Delta R2
  > cat("------+------------------------------------+---------------+---------\n")
  ------+------------------------------------+---------------+---------
    > r2_h1 <- pR2(h1)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > r2_h2 <- pR2(h2)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > r2_h3 <- pR2(h3)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > r2_h4 <- pR2(h4)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > r2_h5 <- pR2(h5)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > cat(sprintf("  1   | Demographics                       | %.3f         | %.3f\n", r2_h1, r2_h1))
  1   | Demographics                       | 0.049         | 0.049
  > cat(sprintf("  2   | + Relationship Competency           | %.3f         | %.3f\n", r2_h2, r2_h2 - r2_h1))
  2   | + Relationship Competency           | 0.157         | 0.108
  > cat(sprintf("  3   | + Self-Competency                   | %.3f         | %.3f\n", r2_h3, r2_h3 - r2_h2))
  3   | + Self-Competency                   | 0.332         | 0.176
  > cat(sprintf("  4   | + IPV Beliefs                       | %.3f         | %.3f\n", r2_h4, r2_h4 - r2_h3))
  4   | + IPV Beliefs                       | 0.556         | 0.224
  > cat(sprintf("  5   | + Environmental Exposure            | %.3f         | %.3f\n", r2_h5, r2_h5 - r2_h4))
  5   | + Environmental Exposure            | 0.782         | 0.226
  > 
    > # Likelihood ratio tests between blocks
    > cat("\n\n=== LIKELIHOOD RATIO TESTS (Block comparisons) ===\n")
  
  
  === LIKELIHOOD RATIO TESTS (Block comparisons) ===
    > cat("Block 2 vs 1 (Relationship Competency):\n")
  Block 2 vs 1 (Relationship Competency):
    > lr_21 <- -2 * (logLik(h1) - logLik(h2))
  > df_21 <- h2$edf - h1$edf
  > cat("  Chi-sq =", round(as.numeric(lr_21), 3), ", df =", df_21, ", p =", round(pchisq(as.numeric(lr_21), df_21, lower.tail = FALSE), 4), "\n")
  Chi-sq = 4.937 , df = 4 , p = 0.2938 
  > 
    > cat("Block 3 vs 2 (Self-Competency):\n")
  Block 3 vs 2 (Self-Competency):
    > lr_32 <- -2 * (logLik(h2) - logLik(h3))
  > df_32 <- h3$edf - h2$edf
  > cat("  Chi-sq =", round(as.numeric(lr_32), 3), ", df =", df_32, ", p =", round(pchisq(as.numeric(lr_32), df_32, lower.tail = FALSE), 4), "\n")
  Chi-sq = 9.071 , df = 4 , p = 0.0593 
  > 
    > cat("Block 4 vs 3 (IPV Beliefs):\n")
  Block 4 vs 3 (IPV Beliefs):
    > lr_43 <- -2 * (logLik(h3) - logLik(h4))
  > df_43 <- h4$edf - h3$edf
  > cat("  Chi-sq =", round(as.numeric(lr_43), 3), ", df =", df_43, ", p =", round(pchisq(as.numeric(lr_43), df_43, lower.tail = FALSE), 4), "\n")
  Chi-sq = 14.229 , df = 4 , p = 0.0066 
  > 
    > cat("Block 5 vs 4 (Environmental Exposure):\n")
  Block 5 vs 4 (Environmental Exposure):
    > lr_54 <- -2 * (logLik(h4) - logLik(h5))
  > df_54 <- h5$edf - h4$edf
  > cat("  Chi-sq =", round(as.numeric(lr_54), 3), ", df =", df_54, ", p =", round(pchisq(as.numeric(lr_54), df_54, lower.tail = FALSE), 4), "\n")
  Chi-sq = 19.291 , df = 6 , p = 0.0037 
  > # ============================================
  > # AIM 6: APPROACH 2 - REDUCED HIERARCHICAL MODEL
    > # Best predictors from each domain
    > # ============================================
  > 
    > cat("=============================================================\n")
  =============================================================
    > cat("APPROACH 2: REDUCED HIERARCHICAL MULTINOMIAL REGRESSION\n")
  APPROACH 2: REDUCED HIERARCHICAL MULTINOMIAL REGRESSION
  > cat("Strongest predictors from each domain\n")
  Strongest predictors from each domain
  > cat("=============================================================\n\n")
  =============================================================
    
    > 
    > # Check complete cases with reduced variable set
    > reduced_vars <- c("ipv_group3", "age", "gender", 
                        +                   "relationship_tension", "negative_family_comm",
                        +                   "locus_control", "inadequacy",
                        +                   "justify_women", "dv_prevalence_belief",
                        +                   "social_stress", "peer_dv_exposure", "ace_score")
  > cat("Complete cases for reduced model:", sum(complete.cases(data[, reduced_vars])), "\n\n")
  Complete cases for reduced model: 56 
  
  > 
    > # Create analysis dataset with complete cases
    > aim6_data <- data[complete.cases(data[, reduced_vars]), ]
  > cat("Analysis sample: N =", nrow(aim6_data), "\n")
  Analysis sample: N = 56 
  > cat("Group sizes:\n")
  Group sizes:
    > print(table(aim6_data$ipv_group3))
  
  No IPV   Victim Only Bidirectional 
  8             5            43 
  > 
    > # BLOCK 1: Demographics only
    > cat("\n\n--- BLOCK 1: DEMOGRAPHICS ---\n")
  
  
  --- BLOCK 1: DEMOGRAPHICS ---
    > h1 <- multinom(ipv_group3 ~ age + gender, data = aim6_data, maxit = 500)
  # weights:  12 (6 variable)
  initial  value 61.522288 
  iter  10 value 37.972985
  iter  20 value 37.962462
  final  value 37.962085 
  converged
  > print(summary(h1))
  Call:
    multinom(formula = ipv_group3 ~ age + gender, data = aim6_data, 
             maxit = 500)
  
  Coefficients:
    (Intercept)         age genderFemale
  Victim Only    1.10124804 -0.10411277     1.001543
  Bidirectional  0.09615498  0.06935586     0.376763
  
  Std. Errors:
    (Intercept)       age genderFemale
  Victim Only      3.865568 0.1956766    1.1833954
  Bidirectional    2.582852 0.1279510    0.8059356
  
  Residual Deviance: 75.92417 
  AIC: 87.92417 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h1))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh      llhNull           G2     McFadden         r2ML         r2CU 
  -37.96208466 -39.00536784   2.08656637   0.02674717   0.03657450   0.04865682 
  > 
    > # BLOCK 2: + Relationship Competency
    > cat("\n\n--- BLOCK 2: + RELATIONSHIP COMPETENCY ---\n")
  
  
  --- BLOCK 2: + RELATIONSHIP COMPETENCY ---
    > h2 <- multinom(ipv_group3 ~ age + gender + 
                       +                    relationship_tension + negative_family_comm, 
                     +                data = aim6_data, maxit = 500)
  # weights:  18 (10 variable)
  initial  value 61.522288 
  iter  10 value 35.758392
  iter  20 value 35.494392
  iter  30 value 35.493674
  final  value 35.493654 
  converged
  > print(summary(h2))
  Call:
    multinom(formula = ipv_group3 ~ age + gender + relationship_tension + 
               negative_family_comm, data = aim6_data, maxit = 500)
  
  Coefficients:
    (Intercept)         age genderFemale relationship_tension negative_family_comm
  Victim Only      1.713257 -0.19775570    1.3123902            1.1766423          -0.01425145
  Bidirectional   -2.882434  0.03475085    0.6436265            0.5827156           0.09188104
  
  Std. Errors:
    (Intercept)      age genderFemale relationship_tension negative_family_comm
  Victim Only      7.266234 0.218422    1.2470687            0.6674033            0.1819471
  Bidirectional    4.244186 0.133106    0.8585057            0.4834925            0.1042111
  
  Residual Deviance: 70.98731 
  AIC: 90.98731 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h2))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh      llhNull           G2     McFadden         r2ML         r2CU 
  -35.49365439 -39.00536784   7.02342690   0.09003154   0.11787220   0.15681107 
  > 
    > # BLOCK 3: + Self-Competency
    > cat("\n\n--- BLOCK 3: + SELF-COMPETENCY ---\n")
  
  
  --- BLOCK 3: + SELF-COMPETENCY ---
    > h3 <- multinom(ipv_group3 ~ age + gender + 
                       +                    relationship_tension + negative_family_comm +
                       +                    locus_control + inadequacy, 
                     +                data = aim6_data, maxit = 500)
  # weights:  24 (14 variable)
  initial  value 61.522288 
  iter  10 value 35.555028
  iter  20 value 31.097940
  iter  30 value 30.958021
  iter  40 value 30.957980
  final  value 30.957971 
  converged
  > print(summary(h3))
  Call:
    multinom(formula = ipv_group3 ~ age + gender + relationship_tension + 
               negative_family_comm + locus_control + inadequacy, data = aim6_data, 
             maxit = 500)
  
  Coefficients:
    (Intercept)        age genderFemale relationship_tension negative_family_comm
  Victim Only     -3.847164 -0.1442082    1.5158467            1.0861485          -0.03191732
  Bidirectional   -8.909897  0.1128631    0.8181985            0.5335221           0.01379867
  locus_control inadequacy
  Victim Only       0.2115518 0.01090556
  Bidirectional     0.1301641 0.18581743
  
  Std. Errors:
    (Intercept)       age genderFemale relationship_tension negative_family_comm
  Victim Only      8.689542 0.2526441     1.385529            0.7168576            0.2090249
  Bidirectional    5.691030 0.1653375     1.050641            0.5636418            0.1183736
  locus_control inadequacy
  Victim Only       0.1588380  0.2353798
  Bidirectional     0.1095542  0.1763138
  
  Residual Deviance: 61.91594 
  AIC: 89.91594 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h3))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -30.9579709 -39.0053678  16.0947938   0.2063151   0.2497937   0.3323126 
  > 
    > # BLOCK 4: + IPV Beliefs
    > cat("\n\n--- BLOCK 4: + IPV BELIEFS ---\n")
  
  
  --- BLOCK 4: + IPV BELIEFS ---
    > h4 <- multinom(ipv_group3 ~ age + gender + 
                       +                    relationship_tension + negative_family_comm +
                       +                    locus_control + inadequacy +
                       +                    justify_women + dv_prevalence_belief, 
                     +                data = aim6_data, maxit = 500)
  # weights:  30 (18 variable)
  initial  value 61.522288 
  iter  10 value 30.810471
  iter  20 value 24.659734
  iter  30 value 23.973218
  iter  40 value 23.846218
  iter  50 value 23.844873
  iter  60 value 23.843596
  final  value 23.843575 
  converged
  > print(summary(h4))
  Call:
    multinom(formula = ipv_group3 ~ age + gender + relationship_tension + 
               negative_family_comm + locus_control + inadequacy + justify_women + 
               dv_prevalence_belief, data = aim6_data, maxit = 500)
  
  Coefficients:
    (Intercept)         age genderFemale relationship_tension negative_family_comm
  Victim Only    -14.766726 -0.14769998    1.4587805            2.3985965          -0.26908546
  Bidirectional   -5.062683  0.02666558    0.5122603            0.7095356          -0.07899978
  locus_control inadequacy justify_women dv_prevalence_belief
  Victim Only     -0.06950267  0.2126599    0.38029419            0.1804163
  Bidirectional    0.14157820  0.1582846   -0.02150863            0.1552552
  
  Std. Errors:
    (Intercept)       age genderFemale relationship_tension negative_family_comm
  Victim Only      11.60587 0.2455147     1.686289            1.2298062            0.2836481
  Bidirectional     6.12681 0.1913503     1.196146            0.7127766            0.1719885
  locus_control inadequacy justify_women dv_prevalence_belief
  Victim Only       0.2156161  0.2756262    0.18856970           0.13200807
  Bidirectional     0.1261183  0.1968155    0.06644482           0.08895496
  
  Residual Deviance: 47.68715 
  AIC: 83.68715 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h4))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -23.8435751 -39.0053678  30.3235854   0.3887104   0.4181209   0.5562464 
  > 
    > # BLOCK 5: + Environmental Exposure
    > cat("\n\n--- BLOCK 5: + ENVIRONMENTAL EXPOSURE (FULL MODEL) ---\n")
  
  
  --- BLOCK 5: + ENVIRONMENTAL EXPOSURE (FULL MODEL) ---
    > h5 <- multinom(ipv_group3 ~ age + gender + 
                       +                    relationship_tension + negative_family_comm +
                       +                    locus_control + inadequacy +
                       +                    justify_women + dv_prevalence_belief +
                       +                    social_stress + peer_dv_exposure + ace_score, 
                     +                data = aim6_data, maxit = 500)
  # weights:  39 (24 variable)
  initial  value 61.522288 
  iter  10 value 27.673233
  iter  20 value 20.753548
  iter  30 value 14.734280
  iter  40 value 14.279524
  iter  50 value 14.198368
  iter  60 value 14.198302
  iter  70 value 14.198217
  final  value 14.198208 
  converged
  > print(summary(h5))
  Call:
    multinom(formula = ipv_group3 ~ age + gender + relationship_tension + 
               negative_family_comm + locus_control + inadequacy + justify_women + 
               dv_prevalence_belief + social_stress + peer_dv_exposure + 
               ace_score, data = aim6_data, maxit = 500)
  
  Coefficients:
    (Intercept)          age genderFemale relationship_tension negative_family_comm
  Victim Only    -22.646611 -5.822426753  -11.0472985           54.7012331           -3.6328469
  Bidirectional   -5.533538  0.009869452    0.8581596            0.7817984           -0.0329399
  locus_control inadequacy justify_women dv_prevalence_belief social_stress
  Victim Only      -2.9665084  5.0287582    5.26237998            3.6645137    -8.7117844
  Bidirectional     0.1489899  0.1541267   -0.01415996            0.1419419    -0.0567693
  peer_dv_exposure ace_score
  Victim Only        -12.7679439  6.459735
  Bidirectional       -0.1038032  0.123904
  
  Std. Errors:
    (Intercept)        age genderFemale relationship_tension negative_family_comm
  Victim Only     0.7161289 28.0146534     2.763290             5.562652           20.7640204
  Bidirectional   6.2902142  0.2006167     1.323883             0.839560            0.1681264
  locus_control inadequacy justify_women dv_prevalence_belief social_stress
  Victim Only      18.6979530 26.3432102   24.66518532          27.19224497    43.2486383
  Bidirectional     0.1926657  0.2117181    0.06908524           0.09226411     0.2063978
  peer_dv_exposure  ace_score
  Victim Only          7.5834125 24.6018846
  Bidirectional        0.3598185  0.2488771
  
  Residual Deviance: 28.39642 
  AIC: 76.39642 
  > cat("Model fit:\n")
  Model fit:
    > print(pR2(h5))
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  llh     llhNull          G2    McFadden        r2ML        r2CU 
  -14.1982082 -39.0053678  49.6143192   0.6359935   0.5876860   0.7818269 
  > 
    > # Z-scores and p-values for final model
    > cat("\n--- FINAL MODEL Z-SCORES ---\n")
  
  --- FINAL MODEL Z-SCORES ---
    > z <- summary(h5)$coefficients / summary(h5)$standard.errors
  > print(round(z, 3))
  (Intercept)    age genderFemale relationship_tension negative_family_comm
  Victim Only       -31.624 -0.208       -3.998                9.834               -0.175
  Bidirectional      -0.880  0.049        0.648                0.931               -0.196
  locus_control inadequacy justify_women dv_prevalence_belief social_stress
  Victim Only          -0.159      0.191         0.213                0.135        -0.201
  Bidirectional         0.773      0.728        -0.205                1.538        -0.275
  peer_dv_exposure ace_score
  Victim Only             -1.684     0.263
  Bidirectional           -0.288     0.498
  > 
    > cat("\n--- FINAL MODEL P-VALUES ---\n")
  
  --- FINAL MODEL P-VALUES ---
    > p <- (1 - pnorm(abs(z), 0, 1)) * 2
  > print(round(p, 4))
  (Intercept)    age genderFemale relationship_tension negative_family_comm
  Victim Only         0.000 0.8354       0.0001               0.0000               0.8611
  Bidirectional       0.379 0.9608       0.5168               0.3518               0.8447
  locus_control inadequacy justify_women dv_prevalence_belief social_stress
  Victim Only          0.8739     0.8486        0.8311               0.8928        0.8404
  Bidirectional        0.4393     0.4666        0.8376               0.1239        0.7833
  peer_dv_exposure ace_score
  Victim Only             0.0922    0.7929
  Bidirectional           0.7730    0.6186
  > 
    > cat("\n--- FINAL MODEL ODDS RATIOS ---\n")
  
  --- FINAL MODEL ODDS RATIOS ---
    > print(round(exp(coef(h5)), 3))
  (Intercept)   age genderFemale relationship_tension negative_family_comm locus_control
  Victim Only         0.000 0.003        0.000         5.707471e+23                0.026         0.051
  Bidirectional       0.004 1.010        2.359         2.185000e+00                0.968         1.161
  inadequacy justify_women dv_prevalence_belief social_stress peer_dv_exposure ace_score
  Victim Only      152.743       192.940               39.037         0.000            0.000   638.892
  Bidirectional      1.167         0.986                1.153         0.945            0.901     1.132
  > 
    > cat("\n--- FINAL MODEL OR CONFIDENCE INTERVALS ---\n")
  
  --- FINAL MODEL OR CONFIDENCE INTERVALS ---
    > print(round(exp(confint(h5)), 3))
  , , Victim Only
  
  2.5 %       97.5 %
    (Intercept)          0.000000e+00 0.000000e+00
  age                  0.000000e+00 2.077153e+21
  genderFemale         0.000000e+00 4.000000e-03
  relationship_tension 1.050765e+19 3.100143e+28
  negative_family_comm 0.000000e+00 1.249225e+16
  locus_control        0.000000e+00 4.240219e+14
  inadequacy           0.000000e+00 4.048957e+24
  justify_women        0.000000e+00 1.907508e+23
  dv_prevalence_belief 0.000000e+00 5.464607e+24
  social_stress        0.000000e+00 1.071094e+33
  peer_dv_exposure     0.000000e+00 8.128000e+00
  ace_score            0.000000e+00 5.579423e+23
  
  , , Bidirectional
  
  2.5 %  97.5 %
    (Intercept)          0.000 893.419
  age                  0.682   1.496
  genderFemale         0.176  31.593
  relationship_tension 0.422  11.328
  negative_family_comm 0.696   1.345
  locus_control        0.796   1.693
  inadequacy           0.770   1.767
  justify_women        0.861   1.129
  dv_prevalence_belief 0.962   1.381
  social_stress        0.630   1.416
  peer_dv_exposure     0.445   1.825
  ace_score            0.695   1.844
  
  > 
    > # HIERARCHICAL COMPARISON TABLE
    > cat("\n\n=== HIERARCHICAL MODEL COMPARISON ===\n")
  
  
  === HIERARCHICAL MODEL COMPARISON ===
    > cat("Block | Variables Added                    | Nagelkerke R2 | Delta R2\n")
  Block | Variables Added                    | Nagelkerke R2 | Delta R2
  > cat("------+------------------------------------+---------------+---------\n")
  ------+------------------------------------+---------------+---------
    > r2_h1 <- pR2(h1)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > r2_h2 <- pR2(h2)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > r2_h3 <- pR2(h3)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > r2_h4 <- pR2(h4)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > r2_h5 <- pR2(h5)["r2CU"]
  fitting null model for pseudo-r2
  # weights:  6 (2 variable)
  initial  value 61.522288 
  final  value 39.005368 
  converged
  > cat(sprintf("  1   | Demographics                       | %.3f         | %.3f\n", r2_h1, r2_h1))
  1   | Demographics                       | 0.049         | 0.049
  > cat(sprintf("  2   | + Relationship Competency           | %.3f         | %.3f\n", r2_h2, r2_h2 - r2_h1))
  2   | + Relationship Competency           | 0.157         | 0.108
  > cat(sprintf("  3   | + Self-Competency                   | %.3f         | %.3f\n", r2_h3, r2_h3 - r2_h2))
  3   | + Self-Competency                   | 0.332         | 0.176
  > cat(sprintf("  4   | + IPV Beliefs                       | %.3f         | %.3f\n", r2_h4, r2_h4 - r2_h3))
  4   | + IPV Beliefs                       | 0.556         | 0.224
  > cat(sprintf("  5   | + Environmental Exposure            | %.3f         | %.3f\n", r2_h5, r2_h5 - r2_h4))
  5   | + Environmental Exposure            | 0.782         | 0.226
  > 
    > # Likelihood ratio tests between blocks
    > cat("\n\n=== LIKELIHOOD RATIO TESTS (Block comparisons) ===\n")
  
  
  === LIKELIHOOD RATIO TESTS (Block comparisons) ===
    > cat("Block 2 vs 1 (Relationship Competency):\n")
  Block 2 vs 1 (Relationship Competency):
    > lr_21 <- -2 * (logLik(h1) - logLik(h2))
  > df_21 <- h2$edf - h1$edf
  > cat("  Chi-sq =", round(as.numeric(lr_21), 3), ", df =", df_21, ", p =", round(pchisq(as.numeric(lr_21), df_21, lower.tail = FALSE), 4), "\n")
  Chi-sq = 4.937 , df = 4 , p = 0.2938 
  > 
    > cat("Block 3 vs 2 (Self-Competency):\n")
  Block 3 vs 2 (Self-Competency):
    > lr_32 <- -2 * (logLik(h2) - logLik(h3))
  > df_32 <- h3$edf - h2$edf
  > cat("  Chi-sq =", round(as.numeric(lr_32), 3), ", df =", df_32, ", p =", round(pchisq(as.numeric(lr_32), df_32, lower.tail = FALSE), 4), "\n")
  Chi-sq = 9.071 , df = 4 , p = 0.0593 
  > 
    > cat("Block 4 vs 3 (IPV Beliefs):\n")
  Block 4 vs 3 (IPV Beliefs):
    > lr_43 <- -2 * (logLik(h3) - logLik(h4))
  > df_43 <- h4$edf - h3$edf
  > cat("  Chi-sq =", round(as.numeric(lr_43), 3), ", df =", df_43, ", p =", round(pchisq(as.numeric(lr_43), df_43, lower.tail = FALSE), 4), "\n")
  Chi-sq = 14.229 , df = 4 , p = 0.0066 
  > 
    > cat("Block 5 vs 4 (Environmental Exposure):\n")
  Block 5 vs 4 (Environmental Exposure):
    > lr_54 <- -2 * (logLik(h4) - logLik(h5))
  > df_54 <- h5$edf - h4$edf
  > cat("  Chi-sq =", round(as.numeric(lr_54), 3), ", df =", df_54, ", p =", round(pchisq(as.numeric(lr_54), df_54, lower.tail = FALSE), 4), "\n")
  Chi-sq = 19.291 , df = 6 , p = 0.0037 
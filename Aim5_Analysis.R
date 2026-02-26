> # ============================================
> # AIM 5, VARIABLE 1: ACE SCORE
  > # Adverse Childhood Experiences (10 binary items, 0-10 scale)
  > # ============================================
> 
  > cat("==========================================\n")
==========================================
  > cat("VARIABLE 1: ACE SCORE\n")
VARIABLE 1: ACE SCORE
> cat("==========================================\n\n")
==========================================
  
  > 
  > # Step 1: One-Way ANOVA
  > cat("--- STEP 1: ONE-WAY ANOVA ---\n")
--- STEP 1: ONE-WAY ANOVA ---
  > anova_ace <- aov(ace_score ~ ipv_group3, data = data)
> print(summary(anova_ace))
Df Sum Sq Mean Sq F value Pr(>F)  
ipv_group3   2   59.4   29.71   3.828 0.0255 *
  Residuals   88  682.9    7.76                 
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
115 observations deleted due to missingness
> 
  > # Group means
  > cat("\n--- GROUP MEANS ---\n")

--- GROUP MEANS ---
  > print(aggregate(ace_score ~ ipv_group3, data = data, 
                    +                 FUN = function(x) c(Mean = mean(x), SD = sd(x), N = length(x))))
ipv_group3 ace_score.Mean ace_score.SD ace_score.N
1        No IPV       2.066667     2.789436   15.000000
2   Victim Only       2.272727     2.195036   11.000000
3 Bidirectional       3.938462     2.866165   65.000000
> 
  > # Step 2: Tukey Post Hoc
  > cat("\n--- STEP 2: TUKEY POST HOC ---\n")

--- STEP 2: TUKEY POST HOC ---
  > print(TukeyHSD(anova_ace))
Tukey multiple comparisons of means
95% family-wise confidence level

Fit: aov(formula = ace_score ~ ipv_group3, data = data)

$ipv_group3
diff        lwr      upr     p adj
Victim Only-No IPV        0.2060606 -2.4301497 2.842271 0.9810425
Bidirectional-No IPV      1.8717949 -0.0305009 3.774091 0.0547846
Bidirectional-Victim Only 1.6657343 -0.4994214 3.830890 0.1645191

> 
  > # Step 3: Eta-Squared
  > cat("\n--- STEP 3: ETA-SQUARED ---\n")

--- STEP 3: ETA-SQUARED ---
  > SS_between <- summary(anova_ace)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_ace)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.08 
> 
  > # Step 4: Cohen's d (3 pairwise comparisons)
  > cat("\n--- STEP 4: COHEN'S D ---\n")

--- STEP 4: COHEN'S D ---
> library(effectsize)
> 
> subset1 <- droplevels(data[data$ipv_group3 %in% c("No IPV", "Victim Only"), ])
> subset2 <- droplevels(data[data$ipv_group3 %in% c("No IPV", "Bidirectional"), ])
> subset3 <- droplevels(data[data$ipv_group3 %in% c("Victim Only", "Bidirectional"), ])
> 
> cat("No IPV vs Victim Only:\n")
No IPV vs Victim Only:
> print(cohens_d(ace_score ~ ipv_group3, data = subset1))
Cohen's d |        95% CI
-------------------------
  -0.08     | [-0.86, 0.70]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> cat("\nNo IPV vs Bidirectional:\n")

No IPV vs Bidirectional:
  > print(cohens_d(ace_score ~ ipv_group3, data = subset2))
Cohen's d |         95% CI
--------------------------
-0.66     | [-1.22, -0.08]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cat("\nVictim Only vs Bidirectional:\n")

Victim Only vs Bidirectional:
> print(cohens_d(ace_score ~ ipv_group3, data = subset3))
Cohen's d |        95% CI
-------------------------
  -0.60     | [-1.24, 0.05]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > # Step 5: Multiple Regression
  > cat("\n--- STEP 5: MULTIPLE REGRESSION ---\n")

--- STEP 5: MULTIPLE REGRESSION ---
  > library(lm.beta)
> model_ace <- lm(ace_score ~ ipv_group3 + age + gender, data = data)
> cat("Summary:\n")
Summary:
  > print(summary(model_ace))

Call:
  lm(formula = ace_score ~ ipv_group3 + age + gender, data = data)

Residuals:
  Min     1Q Median     3Q    Max 
-4.301 -2.058 -0.700  2.285  6.270 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)  
(Intercept)              1.31092    2.05906   0.637   0.5260  
ipv_group3Victim Only    0.10325    1.12199   0.092   0.9269  
ipv_group3Bidirectional  1.81141    0.80920   2.239   0.0278 *
  age                      0.03040    0.09588   0.317   0.7519  
genderFemale             0.41863    0.60580   0.691   0.4914  
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.807 on 86 degrees of freedom
(115 observations deleted due to missingness)
Multiple R-squared:  0.08691,	Adjusted R-squared:  0.04444 
F-statistic: 2.046 on 4 and 86 DF,  p-value: 0.09499

> cat("\nStandardized Coefficients:\n")

Standardized Coefficients:
  > print(lm.beta(model_ace))

Call:
  lm(formula = ace_score ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
  (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
NA              0.01178542              0.28651874              0.03313529 
genderFemale 
0.07228675 

> # ============================================
> # AIM 5, VARIABLE 2: UNFAIR TREATMENT (DISC)
  > # 13 items, 4-point Likert, range 13-52
  > # ============================================
> 
  > cat("==========================================\n")
==========================================
  > cat("VARIABLE 2: UNFAIR TREATMENT (DISC)\n")
VARIABLE 2: UNFAIR TREATMENT (DISC)
> cat("==========================================\n\n")
==========================================
  
  > 
  > # Step 1: One-Way ANOVA
  > cat("--- STEP 1: ONE-WAY ANOVA ---\n")
--- STEP 1: ONE-WAY ANOVA ---
  > anova_unfair <- aov(unfair_treatment ~ ipv_group3, data = data)
> print(summary(anova_unfair))
Df Sum Sq Mean Sq F value  Pr(>F)   
ipv_group3    2    822   411.0   6.215 0.00277 **
  Residuals   111   7342    66.1                   
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
92 observations deleted due to missingness
> 
  > cat("\n--- GROUP MEANS ---\n")

--- GROUP MEANS ---
  > print(aggregate(unfair_treatment ~ ipv_group3, data = data, 
                    +                 FUN = function(x) c(Mean = mean(x), SD = sd(x), N = length(x))))
ipv_group3 unfair_treatment.Mean unfair_treatment.SD unfair_treatment.N
1        No IPV             17.409091            5.803604          22.000000
2   Victim Only             20.166667            6.206058          12.000000
3 Bidirectional             24.037500            8.866726          80.000000
> 
  > # Step 2: Tukey Post Hoc
  > cat("\n--- STEP 2: TUKEY POST HOC ---\n")

--- STEP 2: TUKEY POST HOC ---
  > print(TukeyHSD(anova_unfair))
Tukey multiple comparisons of means
95% family-wise confidence level

Fit: aov(formula = unfair_treatment ~ ipv_group3, data = data)

$ipv_group3
diff       lwr       upr     p adj
Victim Only-No IPV        2.757576 -4.175819  9.690971 0.6131945
Bidirectional-No IPV      6.628409  1.977346 11.279472 0.0028063
Bidirectional-Victim Only 3.870833 -2.110070  9.851736 0.2774757

> 
  > # Step 3: Eta-Squared
  > cat("\n--- STEP 3: ETA-SQUARED ---\n")

--- STEP 3: ETA-SQUARED ---
  > SS_between <- summary(anova_unfair)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_unfair)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.1007 
> 
  > # Step 4: Cohen's d
  > cat("\n--- STEP 4: COHEN'S D ---\n")

--- STEP 4: COHEN'S D ---
> subset1 <- droplevels(data[data$ipv_group3 %in% c("No IPV", "Victim Only"), ])
> subset2 <- droplevels(data[data$ipv_group3 %in% c("No IPV", "Bidirectional"), ])
> subset3 <- droplevels(data[data$ipv_group3 %in% c("Victim Only", "Bidirectional"), ])
> 
> cat("No IPV vs Victim Only:\n")
No IPV vs Victim Only:
> print(cohens_d(unfair_treatment ~ ipv_group3, data = subset1))
Cohen's d |        95% CI
-------------------------
  -0.46     | [-1.17, 0.25]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> cat("\nNo IPV vs Bidirectional:\n")

No IPV vs Bidirectional:
  > print(cohens_d(unfair_treatment ~ ipv_group3, data = subset2))
Cohen's d |         95% CI
--------------------------
-0.80     | [-1.28, -0.31]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cat("\nVictim Only vs Bidirectional:\n")

Victim Only vs Bidirectional:
> print(cohens_d(unfair_treatment ~ ipv_group3, data = subset3))
Cohen's d |        95% CI
-------------------------
  -0.45     | [-1.06, 0.16]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > # Step 5: Multiple Regression
  > cat("\n--- STEP 5: MULTIPLE REGRESSION ---\n")

--- STEP 5: MULTIPLE REGRESSION ---
  > model_unfair <- lm(unfair_treatment ~ ipv_group3 + age + gender, data = data)
> cat("Summary:\n")
Summary:
  > print(summary(model_unfair))

Call:
  lm(formula = unfair_treatment ~ ipv_group3 + age + gender, data = data)

Residuals:
  Min      1Q  Median      3Q     Max 
-11.711  -5.360  -1.525   5.031  28.031 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)   
(Intercept)              10.6525     5.5855   1.907  0.05913 . 
ipv_group3Victim Only     3.0587     2.9322   1.043  0.29920   
ipv_group3Bidirectional   6.5500     1.9660   3.332  0.00118 **
  age                       0.3383     0.2593   1.305  0.19465   
genderFemale             -0.6112     1.5752  -0.388  0.69875   
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 8.141 on 109 degrees of freedom
(92 observations deleted due to missingness)
Multiple R-squared:  0.1152,	Adjusted R-squared:  0.0827 
F-statistic: 3.547 on 4 and 109 DF,  p-value: 0.009244

> cat("\nStandardized Coefficients:\n")

Standardized Coefficients:
  > print(lm.beta(model_unfair))

Call:
  lm(formula = unfair_treatment ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
  (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
NA              0.11092391              0.35409785              0.11877084 
genderFemale 
-0.03516248 

> # ============================================
> # AIM 5, VARIABLE 3: SOCIAL STRESS (BASC)
  > # 13 items, 4-point Likert, range 13-52
  > # ============================================
> 
  > cat("==========================================\n")
==========================================
  > cat("VARIABLE 3: SOCIAL STRESS (BASC)\n")
VARIABLE 3: SOCIAL STRESS (BASC)
> cat("==========================================\n\n")
==========================================
  
  > 
  > # Step 1: One-Way ANOVA
  > cat("--- STEP 1: ONE-WAY ANOVA ---\n")
--- STEP 1: ONE-WAY ANOVA ---
  > anova_stress <- aov(social_stress ~ ipv_group3, data = data)
> print(summary(anova_stress))
Df Sum Sq Mean Sq F value  Pr(>F)    
ipv_group3    2    613  306.57   7.968 0.00057 ***
  Residuals   117   4501   38.47                    
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
86 observations deleted due to missingness
> 
  > cat("\n--- GROUP MEANS ---\n")

--- GROUP MEANS ---
  > print(aggregate(social_stress ~ ipv_group3, data = data, 
                    +                 FUN = function(x) c(Mean = mean(x), SD = sd(x), N = length(x))))
ipv_group3 social_stress.Mean social_stress.SD social_stress.N
1        No IPV          17.285714         4.691938       21.000000
2   Victim Only          23.400000         5.961783       15.000000
3 Bidirectional          23.202381         6.552439       84.000000
> 
  > # Step 2: Tukey Post Hoc
  > cat("\n--- STEP 2: TUKEY POST HOC ---\n")

--- STEP 2: TUKEY POST HOC ---
  > print(TukeyHSD(anova_stress))
Tukey multiple comparisons of means
95% family-wise confidence level

Fit: aov(formula = social_stress ~ ipv_group3, data = data)

$ipv_group3
diff       lwr       upr     p adj
Victim Only-No IPV         6.114286  1.136416 11.092155 0.0117566
Bidirectional-No IPV       5.916667  2.324199  9.509135 0.0004536
Bidirectional-Victim Only -0.197619 -4.325051  3.929813 0.9929033

> 
  > # Step 3: Eta-Squared
  > cat("\n--- STEP 3: ETA-SQUARED ---\n")

--- STEP 3: ETA-SQUARED ---
  > SS_between <- summary(anova_stress)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_stress)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.1199 
> 
  > # Step 4: Cohen's d
  > cat("\n--- STEP 4: COHEN'S D ---\n")

--- STEP 4: COHEN'S D ---
> subset1 <- droplevels(data[data$ipv_group3 %in% c("No IPV", "Victim Only"), ])
> subset2 <- droplevels(data[data$ipv_group3 %in% c("No IPV", "Bidirectional"), ])
> subset3 <- droplevels(data[data$ipv_group3 %in% c("Victim Only", "Bidirectional"), ])
> 
> cat("No IPV vs Victim Only:\n")
No IPV vs Victim Only:
> print(cohens_d(social_stress ~ ipv_group3, data = subset1))
Cohen's d |         95% CI
--------------------------
  -1.16     | [-1.87, -0.44]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> cat("\nNo IPV vs Bidirectional:\n")

No IPV vs Bidirectional:
  > print(cohens_d(social_stress ~ ipv_group3, data = subset2))
Cohen's d |         95% CI
--------------------------
-0.95     | [-1.44, -0.45]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cat("\nVictim Only vs Bidirectional:\n")

Victim Only vs Bidirectional:
> print(cohens_d(social_stress ~ ipv_group3, data = subset3))
Cohen's d |        95% CI
-------------------------
  0.03      | [-0.52, 0.58]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > # Step 5: Multiple Regression
  > cat("\n--- STEP 5: MULTIPLE REGRESSION ---\n")

--- STEP 5: MULTIPLE REGRESSION ---
  > model_stress <- lm(social_stress ~ ipv_group3 + age + gender, data = data)
> cat("Summary:\n")
Summary:
  > print(summary(model_stress))

Call:
  lm(formula = social_stress ~ ipv_group3 + age + gender, data = data)

Residuals:
  Min       1Q   Median       3Q      Max 
-10.6728  -4.5097  -0.5219   3.4594  24.4561 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept)             18.15459    4.11653   4.410 2.35e-05 ***
  ipv_group3Victim Only    6.18882    2.12776   2.909 0.004365 ** 
  ipv_group3Bidirectional  6.03418    1.54812   3.898 0.000164 ***
  age                     -0.03225    0.19109  -0.169 0.866297    
genderFemale            -0.63505    1.17077  -0.542 0.588588    
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6.273 on 114 degrees of freedom
(87 observations deleted due to missingness)
Multiple R-squared:  0.1228,	Adjusted R-squared:  0.092 
F-statistic: 3.989 on 4 and 114 DF,  p-value: 0.004574

> cat("\nStandardized Coefficients:\n")

Standardized Coefficients:
  > print(lm.beta(model_stress))

Call:
  lm(formula = social_stress ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
  (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
NA              0.31332358              0.42279636             -0.01506880 
genderFemale 
-0.04793687 

> # ============================================
> # AIM 5, VARIABLE 4: ALCOHOL USE (AUDIT)
  > # 10 items, range 0-40
  > # ============================================
> 
  > cat("==========================================\n")
==========================================
  > cat("VARIABLE 4: ALCOHOL USE (AUDIT)\n")
VARIABLE 4: ALCOHOL USE (AUDIT)
> cat("==========================================\n\n")
==========================================
  
  > 
  > # Step 1: One-Way ANOVA
  > cat("--- STEP 1: ONE-WAY ANOVA ---\n")
--- STEP 1: ONE-WAY ANOVA ---
  > anova_alcohol <- aov(alcohol_use ~ ipv_group3, data = data)
> print(summary(anova_alcohol))
Df Sum Sq Mean Sq F value Pr(>F)
ipv_group3   2     88   43.78   0.938  0.396
Residuals   77   3592   46.65               
126 observations deleted due to missingness
> 
  > cat("\n--- GROUP MEANS ---\n")

--- GROUP MEANS ---
  > print(aggregate(alcohol_use ~ ipv_group3, data = data, 
                    +                 FUN = function(x) c(Mean = mean(x), SD = sd(x), N = length(x))))
ipv_group3 alcohol_use.Mean alcohol_use.SD alcohol_use.N
1        No IPV         4.272727       5.236237     11.000000
2   Victim Only         8.571429       6.160550      7.000000
3 Bidirectional         6.725806       7.117675     62.000000
> 
  > # Step 2: Tukey Post Hoc
  > cat("\n--- STEP 2: TUKEY POST HOC ---\n")

--- STEP 2: TUKEY POST HOC ---
  > print(TukeyHSD(anova_alcohol))
Tukey multiple comparisons of means
95% family-wise confidence level

Fit: aov(formula = alcohol_use ~ ipv_group3, data = data)

$ipv_group3
diff       lwr       upr     p adj
Victim Only-No IPV         4.298701 -3.593547 12.190950 0.3985893
Bidirectional-No IPV       2.453079 -2.887386  7.793544 0.5183688
Bidirectional-Victim Only -1.845622 -8.354251  4.663007 0.7771490

> 
  > # Step 3: Eta-Squared
  > cat("\n--- STEP 3: ETA-SQUARED ---\n")

--- STEP 3: ETA-SQUARED ---
  > SS_between <- summary(anova_alcohol)[[1]]["ipv_group3", "Sum Sq"]
> SS_residual <- summary(anova_alcohol)[[1]]["Residuals", "Sum Sq"]
> eta2 <- SS_between / (SS_between + SS_residual)
> cat("Eta-squared:", round(eta2, 4), "\n")
Eta-squared: 0.0238 
> 
  > # Step 4: Cohen's d
  > cat("\n--- STEP 4: COHEN'S D ---\n")

--- STEP 4: COHEN'S D ---
> subset1 <- droplevels(data[data$ipv_group3 %in% c("No IPV", "Victim Only"), ])
> subset2 <- droplevels(data[data$ipv_group3 %in% c("No IPV", "Bidirectional"), ])
> subset3 <- droplevels(data[data$ipv_group3 %in% c("Victim Only", "Bidirectional"), ])
> 
> cat("No IPV vs Victim Only:\n")
No IPV vs Victim Only:
> print(cohens_d(alcohol_use ~ ipv_group3, data = subset1))
Cohen's d |        95% CI
-------------------------
  -0.77     | [-1.74, 0.23]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> cat("\nNo IPV vs Bidirectional:\n")

No IPV vs Bidirectional:
  > print(cohens_d(alcohol_use ~ ipv_group3, data = subset2))
Cohen's d |        95% CI
-------------------------
-0.36     | [-1.00, 0.29]

- Estimated using pooled SD.
Warning message:
Missing values detected. NAs dropped. 
> cat("\nVictim Only vs Bidirectional:\n")

Victim Only vs Bidirectional:
> print(cohens_d(alcohol_use ~ ipv_group3, data = subset3))
Cohen's d |        95% CI
-------------------------
  0.26      | [-0.52, 1.04]

- Estimated using pooled SD.
Warning message:
  Missing values detected. NAs dropped. 
> 
  > # Step 5: Multiple Regression
  > cat("\n--- STEP 5: MULTIPLE REGRESSION ---\n")

--- STEP 5: MULTIPLE REGRESSION ---
  > model_alcohol <- lm(alcohol_use ~ ipv_group3 + age + gender, data = data)
> cat("Summary:\n")
Summary:
  > print(summary(model_alcohol))

Call:
  lm(formula = alcohol_use ~ ipv_group3 + age + gender, data = data)

Residuals:
  Min     1Q Median     3Q    Max 
-9.411 -4.996 -2.020  4.395 22.366 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)  
(Intercept)              -3.8385     5.4934  -0.699   0.4869  
ipv_group3Victim Only     2.5779     3.3032   0.780   0.4376  
ipv_group3Bidirectional   1.6651     2.2025   0.756   0.4520  
age                       0.3404     0.2493   1.365   0.1762  
genderFemale              3.0749     1.5331   2.006   0.0485 *
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6.648 on 75 degrees of freedom
(126 observations deleted due to missingness)
Multiple R-squared:  0.09922,	Adjusted R-squared:  0.05117 
F-statistic: 2.065 on 4 and 75 DF,  p-value: 0.09382

> cat("\nStandardized Coefficients:\n")

Standardized Coefficients:
  > print(lm.beta(model_alcohol))

Call:
  lm(formula = alcohol_use ~ ipv_group3 + age + gender, data = data)

Standardized Coefficients::
  (Intercept)   ipv_group3Victim Only ipv_group3Bidirectional                     age 
NA               0.1074035               0.1025244               0.1515800 
genderFemale 
0.2266888 

> # ============================================
> # AIM 5, VARIABLES 5-12: SUBSTANCE USE (ASSIST)
  > # All binary Y/N factors - Chi-square tests
  > # ============================================
> 
  > library(effectsize)
> 
  > substances <- c("tobacco", "cannabis", "cocaine", "amphetamines", 
                    +                 "inhalants", "sedatives", "hallucinogens", "opioids")
> 
  > for (s in substances) {
    +     cat("==========================================\n")
    +     cat(paste0("VARIABLE: ", toupper(s), "\n"))
    +     cat("==========================================\n\n")
    +     
      +     # Cross-tabulation
      +     cat("--- CROSS-TABULATION ---\n")
    +     ct <- table(data[[s]], data$ipv_group3)
    +     print(ct)
    +     
      +     # Column proportions
      +     cat("\n--- COLUMN PROPORTIONS ---\n")
    +     print(round(prop.table(ct, margin = 2), 3))
    +     
      +     # Chi-square test
      +     cat("\n--- CHI-SQUARE TEST ---\n")
    +     chi_test <- chisq.test(ct)
    +     print(chi_test)
    +     
      +     # Check expected frequencies
      +     cat("Expected frequencies:\n")
    +     print(round(chi_test$expected, 2))
    +     
      +     # Fisher's exact test (in case expected < 5)
      +     cat("\n--- FISHER'S EXACT TEST ---\n")
    +     fisher_test <- fisher.test(ct)
    +     print(fisher_test)
    +     
      +     # Cramér's V
      +     cat("\n--- CRAMER'S V ---\n")
    +     print(cramers_v(ct))
    +     
      +     cat("\n\n")
    + }
==========================================
  VARIABLE: TOBACCO
==========================================
  
  --- CROSS-TABULATION ---
  
  No IPV Victim Only Bidirectional
N     21          13            82
Y      2           2            11

--- COLUMN PROPORTIONS ---
  
  No IPV Victim Only Bidirectional
N  0.913       0.867         0.882
Y  0.087       0.133         0.118

--- CHI-SQUARE TEST ---
  
  Pearson's Chi-squared test

data:  ct
X-squared = 0.23767, df = 2, p-value = 0.888

Expected frequencies:
   
    No IPV Victim Only Bidirectional
  N  20.37       13.28         82.35
  Y   2.63        1.72         10.65

--- FISHER'S EXACT TEST ---
  
  Fisher's Exact Test for Count Data

data:  ct
p-value = 1
alternative hypothesis: two.sided


--- CRAMER'S V ---
  Cramer's V (adj.) |       95% CI
--------------------------------
0                 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].

==========================================
VARIABLE: CANNABIS
==========================================

--- CROSS-TABULATION ---
   
    No IPV Victim Only Bidirectional
  N     22          13            84
  Y      1           2             9

--- COLUMN PROPORTIONS ---
   
    No IPV Victim Only Bidirectional
  N  0.957       0.867         0.903
  Y  0.043       0.133         0.097

--- CHI-SQUARE TEST ---

	Pearson's Chi-squared test

data:  ct
X-squared = 0.98395, df = 2, p-value = 0.6114

Expected frequencies:
  
  No IPV Victim Only Bidirectional
N  20.89       13.63         84.48
Y   2.11        1.37          8.52

--- FISHER'S EXACT TEST ---

	Fisher's Exact Test for Count Data

data:  ct
p-value = 0.6265
alternative hypothesis: two.sided


--- CRAMER'S V ---
Cramer's V (adj.) |       95% CI
--------------------------------
  0                 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].

==========================================
  VARIABLE: COCAINE
==========================================
  
  --- CROSS-TABULATION ---
  
  No IPV Victim Only Bidirectional
N     21          13            90
Y      2           2             4

--- COLUMN PROPORTIONS ---
  
  No IPV Victim Only Bidirectional
N  0.913       0.867         0.957
Y  0.087       0.133         0.043

--- CHI-SQUARE TEST ---
  
  Pearson's Chi-squared test

data:  ct
X-squared = 2.2121, df = 2, p-value = 0.3309

Expected frequencies:
   
    No IPV Victim Only Bidirectional
  N  21.61       14.09          88.3
  Y   1.39        0.91           5.7

--- FISHER'S EXACT TEST ---
  
  Fisher's Exact Test for Count Data

data:  ct
p-value = 0.1796
alternative hypothesis: two.sided


--- CRAMER'S V ---
  Cramer's V (adj.) |       95% CI
--------------------------------
0.04              | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].

==========================================
VARIABLE: AMPHETAMINES
==========================================

--- CROSS-TABULATION ---
   
    No IPV Victim Only Bidirectional
  N     22          13            82
  Y      1           2            11

--- COLUMN PROPORTIONS ---
   
    No IPV Victim Only Bidirectional
  N  0.957       0.867         0.882
  Y  0.043       0.133         0.118

--- CHI-SQUARE TEST ---

	Pearson's Chi-squared test

data:  ct
X-squared = 1.2052, df = 2, p-value = 0.5474

Expected frequencies:
  
  No IPV Victim Only Bidirectional
N  20.54        13.4         83.06
Y   2.46         1.6          9.94

--- FISHER'S EXACT TEST ---

	Fisher's Exact Test for Count Data

data:  ct
p-value = 0.657
alternative hypothesis: two.sided


--- CRAMER'S V ---
Cramer's V (adj.) |       95% CI
--------------------------------
  0                 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].

==========================================
  VARIABLE: INHALANTS
==========================================
  
  --- CROSS-TABULATION ---
  
  No IPV Victim Only Bidirectional
N     21          13            88
Y      1           1             5

--- COLUMN PROPORTIONS ---
  
  No IPV Victim Only Bidirectional
N  0.955       0.929         0.946
Y  0.045       0.071         0.054

--- CHI-SQUARE TEST ---
  
  Pearson's Chi-squared test

data:  ct
X-squared = 0.1141, df = 2, p-value = 0.9445

Expected frequencies:
   
    No IPV Victim Only Bidirectional
  N  20.81       13.24         87.95
  Y   1.19        0.76          5.05

--- FISHER'S EXACT TEST ---
  
  Fisher's Exact Test for Count Data

data:  ct
p-value = 0.8322
alternative hypothesis: two.sided


--- CRAMER'S V ---
  Cramer's V (adj.) |       95% CI
--------------------------------
0                 | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].

==========================================
VARIABLE: SEDATIVES
==========================================

--- CROSS-TABULATION ---
   
    No IPV Victim Only Bidirectional
  N     22          11            76
  Y      0           4            17

--- COLUMN PROPORTIONS ---
   
    No IPV Victim Only Bidirectional
  N  1.000       0.733         0.817
  Y  0.000       0.267         0.183

--- CHI-SQUARE TEST ---

	Pearson's Chi-squared test

data:  ct
X-squared = 5.7728, df = 2, p-value = 0.05578

Expected frequencies:
  
  No IPV Victim Only Bidirectional
N  18.45       12.58         77.98
Y   3.55        2.42         15.02

--- FISHER'S EXACT TEST ---

	Fisher's Exact Test for Count Data

data:  ct
p-value = 0.03264
alternative hypothesis: two.sided


--- CRAMER'S V ---
Cramer's V (adj.) |       95% CI
--------------------------------
  0.17              | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].

==========================================
  VARIABLE: HALLUCINOGENS
==========================================
  
  --- CROSS-TABULATION ---
  
  No IPV Victim Only Bidirectional
N     23          14            79
Y      0           1            13

--- COLUMN PROPORTIONS ---
  
  No IPV Victim Only Bidirectional
N  1.000       0.933         0.859
Y  0.000       0.067         0.141

--- CHI-SQUARE TEST ---
  
  Pearson's Chi-squared test

data:  ct
X-squared = 4.1202, df = 2, p-value = 0.1274

Expected frequencies:
   
    No IPV Victim Only Bidirectional
  N  20.52       13.38         82.09
  Y   2.48        1.62          9.91

--- FISHER'S EXACT TEST ---
  
  Fisher's Exact Test for Count Data

data:  ct
p-value = 0.1407
alternative hypothesis: two.sided


--- CRAMER'S V ---
  Cramer's V (adj.) |       95% CI
--------------------------------
0.13              | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].

==========================================
VARIABLE: OPIOIDS
==========================================

--- CROSS-TABULATION ---
   
    No IPV Victim Only Bidirectional
  N     23          12            87
  Y      0           2             5

--- COLUMN PROPORTIONS ---
   
    No IPV Victim Only Bidirectional
  N  1.000       0.857         0.946
  Y  0.000       0.143         0.054

--- CHI-SQUARE TEST ---

	Pearson's Chi-squared test

data:  ct
X-squared = 3.4609, df = 2, p-value = 0.1772

Expected frequencies:
  
  No IPV Victim Only Bidirectional
N  21.75       13.24         87.01
Y   1.25        0.76          4.99

--- FISHER'S EXACT TEST ---

	Fisher's Exact Test for Count Data

data:  ct
p-value = 0.1584
alternative hypothesis: two.sided


--- CRAMER'S V ---
Cramer's V (adj.) |       95% CI
--------------------------------
  0.11              | [0.00, 1.00]

- One-sided CIs: upper bound fixed at [1.00].

Warning messages:
  1: In chisq.test(ct) : Chi-squared approximation may be incorrect
2: In chisq.test(ct) : Chi-squared approximation may be incorrect
3: In chisq.test(ct) : Chi-squared approximation may be incorrect
4: In chisq.test(ct) : Chi-squared approximation may be incorrect
5: In chisq.test(ct) : Chi-squared approximation may be incorrect
6: In chisq.test(ct) : Chi-squared approximation may be incorrect
7: In chisq.test(ct) : Chi-squared approximation may be incorrect
8: In chisq.test(ct) : Chi-squared approximation may be incorrect

> # ============================================
> # AIM 5: CORRELATIONS (continuous variables)
  > # ============================================
> 
  > library(Hmisc)
> 
  > cor_vars <- data[, c("ace_score", "unfair_treatment", "social_stress", 
                         +                      "alcohol_use", "peer_dv_exposure")]
> 
  > cat("=== CORRELATION MATRIX ===\n")
=== CORRELATION MATRIX ===
  > cor_result <- rcorr(as.matrix(cor_vars), type = "pearson")
> cat("\nCorrelation coefficients:\n")

Correlation coefficients:
  > print(round(cor_result$r, 3))
ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
ace_score            1.000            0.431         0.444       0.434            0.536
unfair_treatment     0.431            1.000         0.557       0.536            0.352
social_stress        0.444            0.557         1.000       0.325            0.288
alcohol_use          0.434            0.536         0.325       1.000            0.310
peer_dv_exposure     0.536            0.352         0.288       0.310            1.000
> cat("\nP-values:\n")

P-values:
  > print(round(cor_result$P, 4))
ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
ace_score               NA                0        0.0000      0.0001           0.0000
unfair_treatment     0e+00               NA        0.0000      0.0000           0.0000
social_stress        0e+00                0            NA      0.0012           0.0005
alcohol_use          1e-04                0        0.0012          NA           0.0035
peer_dv_exposure     0e+00                0        0.0005      0.0035               NA
> cat("\nN (pairwise):\n")

N (pairwise):
  > print(cor_result$n)
ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
ace_score              129              112           120          78              114
unfair_treatment       112              159           146          85              136
social_stress          120              146           165          96              142
alcohol_use             78               85            96          99               87
peer_dv_exposure       114              136           142          87              157
> 
  > # ============================================
> # AIM 5: MULTINOMIAL LOGISTIC REGRESSION
  > # ============================================
> 
  > library(nnet)
> library(pscl)
> 
  > cat("\n\n==========================================\n")


==========================================
  > cat("MULTINOMIAL LOGISTIC REGRESSION\n")
MULTINOMIAL LOGISTIC REGRESSION
> cat("==========================================\n\n")
==========================================
  
  > 
  > # Include continuous vars + binary substance vars + controls
  > # Convert substance factors to numeric 0/1 for the model
  > data$tobacco_num <- as.numeric(data$tobacco == "Y")
> data$cannabis_num <- as.numeric(data$cannabis == "Y")
> data$cocaine_num <- as.numeric(data$cocaine == "Y")
> data$amphetamines_num <- as.numeric(data$amphetamines == "Y")
> data$inhalants_num <- as.numeric(data$inhalants == "Y")
> data$sedatives_num <- as.numeric(data$sedatives == "Y")
> data$hallucinogens_num <- as.numeric(data$hallucinogens == "Y")
> data$opioids_num <- as.numeric(data$opioids == "Y")
> 
  > multi_model <- multinom(ipv_group3 ~ ace_score + unfair_treatment + social_stress + 
                              +                             alcohol_use + peer_dv_exposure + 
                              +                             tobacco_num + cannabis_num + cocaine_num + amphetamines_num + 
                              +                             inhalants_num + sedatives_num + hallucinogens_num + opioids_num +
                              +                             age + gender, 
                            +                         data = data, maxit = 500)
# weights:  51 (32 variable)
initial  value 51.634778 
iter  10 value 16.696524
iter  20 value 11.251191
iter  30 value 10.822371
iter  40 value 10.684773
iter  50 value 10.661179
iter  60 value 10.660614
final  value 10.660599 
converged
> 
  > cat("--- MODEL SUMMARY ---\n")
--- MODEL SUMMARY ---
  > print(summary(multi_model))
Call:
  multinom(formula = ipv_group3 ~ ace_score + unfair_treatment + 
             social_stress + alcohol_use + peer_dv_exposure + tobacco_num + 
             cannabis_num + cocaine_num + amphetamines_num + inhalants_num + 
             sedatives_num + hallucinogens_num + opioids_num + age + gender, 
           data = data, maxit = 500)

Coefficients:
  (Intercept)  ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only    -15.638186 -1.5302639       -0.6498902      1.844817 -0.08683277         1.639633
Bidirectional   -8.437649 -0.7269715       -0.1693653      1.430907 -0.25492228         2.194073
tobacco_num cannabis_num cocaine_num amphetamines_num inhalants_num sedatives_num
Victim Only     -4.321917    -5.526774   -3.926633       -0.9030854      1.470952      1.386608
Bidirectional    1.439121     4.207344    2.793065       -4.5312451      9.705332     14.245575
hallucinogens_num opioids_num        age genderFemale
Victim Only            4.864415    1.594700 -0.4931287     8.281043
Bidirectional          8.896048   -3.408982 -0.7839788     7.281856

Std. Errors:
  (Intercept) ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only     18.645932 1.1463556        0.5688974      1.213879   0.4516285         2.154438
Bidirectional    8.834723 0.6752067        0.2202432      1.089016   0.2175363         1.508439
tobacco_num cannabis_num cocaine_num amphetamines_num inhalants_num sedatives_num
Victim Only      61.52666     51.61352    0.020437         14.75796  1.968973e-08    0.08310599
Bidirectional    61.53690     51.61352    9.949709         67.88439  5.425593e-01   29.33123439
hallucinogens_num  opioids_num       age genderFemale
Victim Only            69.89000 0.0004416140 0.9225941     6.641100
Bidirectional          87.04357 0.0004418178 0.5935524     5.652583

Residual Deviance: 21.3212 
AIC: 85.3212 
> 
  > # Z-scores and p-values
  > cat("\n--- Z-SCORES ---\n")

--- Z-SCORES ---
  > z <- summary(multi_model)$coefficients / summary(multi_model)$standard.errors
> print(round(z, 3))
(Intercept) ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only        -0.839    -1.335           -1.142         1.520      -0.192            0.761
Bidirectional      -0.955    -1.077           -0.769         1.314      -1.172            1.455
tobacco_num cannabis_num cocaine_num amphetamines_num inhalants_num sedatives_num
Victim Only        -0.070       -0.107    -192.133           -0.061  74706530.457        16.685
Bidirectional       0.023        0.082       0.281           -0.067        17.888         0.486
hallucinogens_num opioids_num    age genderFemale
Victim Only               0.070    3611.072 -0.535        1.247
Bidirectional             0.102   -7715.808 -1.321        1.288
> 
  > cat("\n--- P-VALUES ---\n")

--- P-VALUES ---
  > p <- (1 - pnorm(abs(z), 0, 1)) * 2
> print(round(p, 4))
(Intercept) ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only        0.4016    0.1819           0.2533        0.1286      0.8475           0.4466
Bidirectional      0.3395    0.2816           0.4419        0.1889      0.2413           0.1458
tobacco_num cannabis_num cocaine_num amphetamines_num inhalants_num sedatives_num
Victim Only        0.9440       0.9147      0.0000           0.9512             0        0.0000
Bidirectional      0.9813       0.9350      0.7789           0.9468             0        0.6272
hallucinogens_num opioids_num    age genderFemale
Victim Only              0.9445           0 0.5930       0.2124
Bidirectional            0.9186           0 0.1866       0.1977
> 
  > # Odds ratios
  > cat("\n--- ODDS RATIOS ---\n")

--- ODDS RATIOS ---
  > print(round(exp(coef(multi_model)), 3))
(Intercept) ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only             0     0.216            0.522         6.327       0.917            5.153
Bidirectional           0     0.483            0.844         4.182       0.775            8.972
tobacco_num cannabis_num cocaine_num amphetamines_num inhalants_num sedatives_num
Victim Only         0.013        0.004       0.020            0.405         4.353         4.001
Bidirectional       4.217       67.178      16.331            0.011     16404.847   1537356.104
hallucinogens_num opioids_num   age genderFemale
Victim Only             129.595       4.927 0.611     3948.309
Bidirectional          7303.058       0.033 0.457     1453.683
> 
  > # Confidence intervals
  > cat("\n--- CONFIDENCE INTERVALS (OR) ---\n")

--- CONFIDENCE INTERVALS (OR) ---
  > print(round(exp(confint(multi_model)), 3))
, , Victim Only

2.5 %       97.5 %
  (Intercept)       0.000 1.201899e+09
ace_score         0.023 2.047000e+00
unfair_treatment  0.171 1.592000e+00
social_stress     0.586 6.830500e+01
alcohol_use       0.378 2.222000e+00
peer_dv_exposure  0.076 3.515160e+02
tobacco_num       0.000 3.123242e+50
cannabis_num      0.000 3.413994e+41
cocaine_num       0.019 2.100000e-02
amphetamines_num  0.000 1.478395e+12
inhalants_num     4.353 4.353000e+00
sedatives_num     3.400 4.709000e+00
hallucinogens_num 0.000 4.009294e+61
opioids_num       4.923 4.931000e+00
age               0.100 3.725000e+00
genderFemale      0.009 1.775522e+09

, , Bidirectional

2.5 %       97.5 %
  (Intercept)          0.000 7.173069e+03
ace_score            0.129 1.816000e+00
unfair_treatment     0.548 1.300000e+00
social_stress        0.495 3.535100e+01
alcohol_use          0.506 1.187000e+00
peer_dv_exposure     0.467 1.725280e+02
tobacco_num          0.000 1.012300e+53
cannabis_num         0.000 5.764165e+45
cocaine_num          0.000 4.810834e+09
amphetamines_num     0.000 6.537364e+55
inhalants_num     5664.282 4.751158e+04
sedatives_num        0.000 1.424185e+31
hallucinogens_num    0.000 9.018286e+77
opioids_num          0.033 3.300000e-02
age                  0.143 1.461000e+00
genderFemale         0.022 9.417961e+07

> 
  > # Model fit
  > cat("\n--- MODEL FIT ---\n")

--- MODEL FIT ---
  > print(pR2(multi_model))
fitting null model for pseudo-r2
# weights:  6 (2 variable)
initial  value 51.634778 
iter  10 value 25.941183
final  value 25.941182 
converged
llh     llhNull          G2    McFadden        r2ML        r2CU 
-10.6605991 -25.9411819  30.5611656   0.5890473   0.4780782   0.7152384 
> # ============================================
> # AIM 5: REDUCED MULTINOMIAL (continuous vars only)
  > # ============================================
> 
  > cat("==========================================\n")
==========================================
  > cat("REDUCED MULTINOMIAL (continuous vars only)\n")
REDUCED MULTINOMIAL (continuous vars only)
> cat("==========================================\n\n")
==========================================
  
  > 
  > multi_reduced <- multinom(ipv_group3 ~ ace_score + unfair_treatment + social_stress + 
                                +                               alcohol_use + peer_dv_exposure + age + gender, 
                              +                           data = data, maxit = 500)
# weights:  27 (16 variable)
initial  value 53.832002 
iter  10 value 20.517484
iter  20 value 15.757416
iter  30 value 15.637707
iter  40 value 15.627866
iter  50 value 15.625786
iter  60 value 15.625184
final  value 15.625175 
converged
> 
  > cat("--- MODEL SUMMARY ---\n")
--- MODEL SUMMARY ---
  > print(summary(multi_reduced))
Call:
  multinom(formula = ipv_group3 ~ ace_score + unfair_treatment + 
             social_stress + alcohol_use + peer_dv_exposure + age + gender, 
           data = data, maxit = 500)

Coefficients:
  (Intercept)   ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only     -3.173836 -0.89290089       -0.2401701     0.6019394  -0.2290861        0.3885674
Bidirectional   -5.540256 -0.07173323        0.1514763     0.4185237  -0.2266116        0.7557762
age genderFemale
Victim Only   -0.2196089     3.351490
Bidirectional -0.2272363     2.883591

Std. Errors:
  (Intercept) ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only      8.367557 1.0422119        0.3908111     0.2901300   0.2627821        0.7848481
Bidirectional    4.677547 0.3003669        0.1287612     0.2123866   0.1709632        0.3812588
age genderFemale
Victim Only   0.4993866     2.728221
Bidirectional 0.2404960     1.712784

Residual Deviance: 31.25035 
AIC: 63.25035 
> 
  > z2 <- summary(multi_reduced)$coefficients / summary(multi_reduced)$standard.errors
> cat("\n--- Z-SCORES ---\n")

--- Z-SCORES ---
  > print(round(z2, 3))
(Intercept) ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only        -0.379    -0.857           -0.615         2.075      -0.872            0.495
Bidirectional      -1.184    -0.239            1.176         1.971      -1.325            1.982
age genderFemale
Victim Only   -0.440        1.228
Bidirectional -0.945        1.684
> 
  > p2 <- (1 - pnorm(abs(z2), 0, 1)) * 2
> cat("\n--- P-VALUES ---\n")

--- P-VALUES ---
  > print(round(p2, 4))
(Intercept) ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only        0.7045    0.3916           0.5389        0.0380      0.3833           0.6205
Bidirectional      0.2362    0.8112           0.2394        0.0488      0.1850           0.0474
age genderFemale
Victim Only   0.6601       0.2193
Bidirectional 0.3447       0.0923
> 
  > cat("\n--- ODDS RATIOS ---\n")

--- ODDS RATIOS ---
  > print(round(exp(coef(multi_reduced)), 3))
(Intercept) ace_score unfair_treatment social_stress alcohol_use peer_dv_exposure
Victim Only         0.042     0.409            0.786         1.826       0.795            1.475
Bidirectional       0.004     0.931            1.164         1.520       0.797            2.129
age genderFemale
Victim Only   0.803       28.545
Bidirectional 0.797       17.878
> 
  > cat("\n--- CONFIDENCE INTERVALS (OR) ---\n")

--- CONFIDENCE INTERVALS (OR) ---
  > print(round(exp(confint(multi_reduced)), 3))
, , Victim Only

2.5 %     97.5 %
  (Intercept)      0.000 554750.491
ace_score        0.053      3.158
unfair_treatment 0.366      1.692
social_stress    1.034      3.224
alcohol_use      0.475      1.331
peer_dv_exposure 0.317      6.868
age              0.302      2.137
genderFemale     0.136   5995.151

, , Bidirectional

2.5 %  97.5 %
  (Intercept)      0.000  37.621
ace_score        0.517   1.677
unfair_treatment 0.904   1.498
social_stress    1.002   2.304
alcohol_use      0.570   1.115
peer_dv_exposure 1.009   4.495
age              0.497   1.277
genderFemale     0.623 513.159

> 
  > cat("\n--- MODEL FIT ---\n")

--- MODEL FIT ---
  > print(pR2(multi_reduced))
fitting null model for pseudo-r2
# weights:  6 (2 variable)
initial  value 53.832002 
iter  10 value 28.136355
final  value 28.136351 
converged
llh     llhNull          G2    McFadden        r2ML        r2CU 
-15.6251752 -28.1363510  25.0223517   0.4446623   0.3999008   0.5856234
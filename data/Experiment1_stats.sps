* Encoding: UTF-8.

*repeated measures ANOVA

GLM nPLW_articulating nPLW_static sPLW_articulating sPLW_static iPLW_articulating iPLW_static
  /WSFACTOR=walker_type 3 Polynomial articulation 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE ETASQ HOMOGENEITY 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=walker_type articulation walker_type*articulation.

*post hoc tests for walker type

T-TEST PAIRS=Mean_nPLW Mean_nPLW Mean_sPLW WITH Mean_sPLW Mean_iPLW Mean_iPLW (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

*False discovery rate adjustment

DATA LIST free / p (F5.3).
BEGIN DATA
.701 .016 .078
END DATA.
SORT CASES by p (a).
COMPUTE i=$casenum.
SORT CASES by i (d).
COMPUTE q=.05.
COMPUTE m=max(i,lag(m)).
COMPUTE crit=q*i/m.
COMPUTE test=(p le crit).
COMPUTE test=max(test,lag(test)).
FORMATS i m test(f8.0) q (f8.2) crit(f8.6).
VALUE LABELS test 1 'Significant' 0 'Not Significant'.
LIST.

*significant results have test = 1

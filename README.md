BigioCode
=========

R programs
----------
### NAICS.r
Imports labels and sectors corresponding to NAICS codes for aggregation

### CompustatR.r
Calculates value added by sectors of US economy (at different "depths" of aggregation) to compute GDP by industry.

### DealScan.r
Links DealScan loans data to Compustat company data using Roberts and Chodorow linking documents.

### RChartFuncs.r
Functions needed to download data from FRED into R

### SakiDataFred.r
Downloads and formats data from FRED using RChartFuncs.r

### SakiPlots.r
Calls SakiDataFred.r to download data from FRED and creates plots.

### sdevs.r
Calculates standard deviations and means of moments from FRED data.

### FoF.r
Downloads data from Flow of Funds (now done in SakiDataFRED.r)

Matlab Programs
---------------
## Utilities
### BDP_autoplot.m
Plots series
### BDP_benchautoplot.m
Plots benched series (series as precentage change from value at bench date)
### BDP_benchautoplot2.m
Plots benched series (series as precentage of value at bench date)
### BDP_logdiff.m
### BDP_nom2real.m
Computes real series from nominal, using GDP deflator
### BDP_plotspecs.m
Sets specs for plots-colors, line widths, etc.
### BDP_transformations.m
Computes HP filtered and BP filtered versions of series.
### BDP_trends.m
Almost same as _BDP_transformations.m_
### Example_RecessionPlot.m
Plots recession bars.
### Example_RecessionPlot2.m
Plots recession bars and labels key events.
### FRED_RecessionIndicators.m
Computes recession indicators for plotting
### FRED_downloads.m
Downloads and formats data from FRED
### FRED_fix_dates.m
Creates date vectors given specified range of plot (decade, great recession, or all)
### hpfilter_ext.m
Outputs HP filtered series

### FRC_FRED_data_upload_v6.m
This is the most complete data download program and downloads data for FRED to build plots for crisis slides. Mainly plots of path of GDP series, money aggregates, banking indicators, survey of loans officials data, bond spreads. 

### DealScanPlotsMoments_ii.m
Plots data of syndicated loans based on dealscan data.

### FRED_TFP_accounting_iii.m
Downloads data from FRED and imports data from Fernald TFP csv from [here](http://www.frbsf.org/economic-research/total-factor-productivity-tfp/)

Please remember to change directory of programs to GitHub directory.
# Praat-Fricatives-Spectral-Analyses

To cite, use: [![DOI](https://zenodo.org/badge/540411137.svg)](https://zenodo.org/badge/latestdoi/540411137)

These two Praat script "scriptSpectralAnalysesFricatives_V3.praat" and "scriptSpectralAnalysesStops_V3.praat" allow the user to obtain various spectral measures from fricatives and stops, respectively. The scripts iterates across all sound files and associated TextGrids. It is restricted to analysing [s] but this can be modified by the user within the script (line 152 , script 1; add the following: or label$ = "sh", etc..). It also analyses the burst if this is marked with a B (line 101, script 2).

For fricatives, the script provides measurements at the start, mid and end portions (window size of 0.0256). In addition, the script provides readings for the whole portion that is defined as 80% within the fricative to restrict the analysis to the actual fricative and ignoring any transitions. 
For stops, the window size is 0.0256 centred at the burst's midpoint. A DFT with 256 bins is created (after resampling and high-pass filtering; user specific values can be entered), without any zero-padding. The DFT is then smoothed by a cepstral smoothing with a bandwidth of 1000Hz. 
In both scripts, an option for pre-emphasis is added (default, no) and the user can specify a different segment duration.

**A very important point: Users are required to change the setthings within the scripts to suit their needs and the restrictions of their recording settings. As can be seen from the updated scripts, these have now been adjusted to suit my own research. You are required to modify these based on the literature!**

Various acoustic measures are obtained, including the four spectral moments; For stops: the mid and high band energies between 3000-7000Hz and 7000-12000 Hz, respectively (in Pa^2.s and dB); for fricatives, spectral slope computed as low and hight energy bands between 0-Cog valuez and Cog value-15000 Hz, respectively (in Pa^2.s and dB) in addition to the difference between the mid and high frequencies; the peak amplitude and frequency of the highest peak (user defined values); the low and high amplitudes allowing to estimate the dynamic amplitude (user defined values) and finally spectral tilt for stops (quantified via Ahi-A23; amplitude difference between the highest amplitude within the high range 3000-8000Hz and the highest amplitude within the range 1250-3000Hz).

The repository contains the script, two sound files and TextGrids, the results file and a folder automatically saved that contains the generated spectra in all cases.

Many of the metrics reported here were used in the following publication:

Al-Tamimi, J., & Khattab, G. (2015). Acoustic cue weighting in the singleton vs geminate contrast in Lebanese Arabic: The case of fricative consonants. The Journal of the Acoustical Society of America, 138(1), 344–360. doi: https://doi.org/10.1121/1.4922514

The only difference is that in that paper, time-averaging for spectra was used; here we do not use time-averaging as cepstral smoothing allows for spectra not to contain many sporadic peaks (and subsequent research has shown that a normal DFT with smoothing contains the same linguistic information as those obtained via time-averaging, ensemble-averaging or multitaper spectra; cf. Reidy, P. F. (2015). A comparison of spectral estimation methods for the analysis of sibilant fricatives. The Journal of the Acoustical Society of America, 137(4), EL248–EL254. doi: https://doi.org/10.1121/1.4915064).

If there are any issues, please get in touch!

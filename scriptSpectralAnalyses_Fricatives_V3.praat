#### Version 1 (2020): contains analsyes for both fricatives and stops
#### Version 2 (2022): Split by fricative or stop.

#### Version 3 (02-2026): Updates to the script to do various things:
####	1) Squared root for level measures and renaming outputs (thanks to John McGahay for pointing this issue out)
####	2) Adjusting maximum frequency for level mesures
####	3) Adding options for pre-emphasis (default, no)
#### 	4) Updates to form with specific to microphone response!
####	5) Adding option to specify the length of the window (default: 0.0256)

#### Make sure to read the "readme" file and cruicially, to adjust the 
#### Values to suit your needs and to follow guidelines from the literature
#### Cite this github repo and the papers associated
#### Any comments, or questions? send me a message through github 
beginPause: "Script spectral analyses - fricatives"
comment: "Leave empty to select with the browser your path"
sentence: "parent_directory", ""
comment: "What is the name of your results file?"
  	sentence: "results", "spectralResultsFricatives"
  	comment: "Tier number"
  		positive: "tier", "1"
	comment: "Parameters (choose to filter and/or pre-emphasis (or not)"
		optionMenu: "Filter (max should not exceed your microphone max frequency response)", 1
			option: "yes"
			option: "no"
		real: "Min frequency (Hz)", "0"
		real: "Max frequency (Hz)", "15000"
		optionMenu: "Pre_emphasis (default, not applied)", 2
			option: "yes"
			option: "no"
		positive: "From frequency (Hz)", "50"
	comment: "Duration of segment"
		real: "durSeg", "0.0256"
	comment: "Peak frequency range (max should not exceed your microphone max frequency response)"
		real: "Min frequency peak (Hz)", "500"
		real: "Max frequency peak (Hz)", "15000"
	comment: "Dynamic amplitude - low"
		real: "Min frequency amplitude low (Hz)", "0"
		real: "Max frequency amplitude low (Hz)", "2000"
	comment: "Dynamic amplitude - high (max should not exceed your microphone max frequency response)"
		real: "Min frequency amplitude high (Hz)", "500"
		real: "Max frequency amplitude high (Hz)", "15000"
clicked = endPause: "OK", 1

clearinfo

if parent_directory$ = ""
	parent_directory$ = chooseDirectory$("Select your directory of sound files and TextGrids")
endif

createDirectory: "spectra"

Create Strings as file list: "list", "'parent_directory$'/*.wav"
nbFiles = Get number of strings

appendFileLine: "'results$'.xls", "fileName", tab$, "phoneme", tab$, "start", tab$, "startAfter", tab$, "midBefore", tab$, 
... "midAfter", tab$, "endBefore", tab$, "end", tab$, "duration", tab$, "durationMS", tab$, "cogStart", tab$, "sdevStart", tab$, 
... "skewStart", tab$, "kurtStart", tab$, "levelMStartPa^2.s", tab$, "levelMStartdB", tab$, "levelHStartPa^2.s", tab$, "levelHStartdB", tab$, "levelDStartdB", tab$,
... "peakAmpdBStart", tab$, "peakFreqHzStart", tab$, "ampLStart", tab$, "ampMStart", tab$, "dynamicAmpStart", tab$, "cogMid", tab$, 
... "sdevMid", tab$, "skewMid", tab$, "kurtMid", tab$, "levelMMidPa^2.s", tab$, "levelMMiddB", tab$, "levelHMidPa^2.s", tab$, 
... "levelHMiddB", tab$, "levelDMiddB", tab$, "peakAmpdBMid", tab$, "peakFreqHzMid", tab$, "ampLMid", tab$, "ampMMid", tab$, "dynamicAmpMid", tab$,
... "cogEnd", tab$, "sdevEnd", tab$, "skewEnd", tab$, "kurtEnd", tab$, "levelMEndPa^2.s", tab$, "levelMEnddB", tab$, 
... "levelHEndPa^2.s", tab$, "levelHEnddB", tab$, "levelDEnddB", tab$, "peakAmpdBEnd", tab$, "peakFreqHzEnd", tab$, "ampLEnd", tab$, 
... "ampMEnd", tab$, "dynamicAmpEnd", tab$,
... "cogWhole", tab$, "sdevWhole", tab$, "skewWhole", tab$, "kurtWhole", tab$, "levelMWholePa^2.s", tab$, "levelMWholedB", tab$, 
... "levelHWholePa^2.s", tab$, "levelHWholedB", tab$, "levelDWholedB", tab$, "peakAmpdBWhole", tab$, "peakFreqHzWhole", tab$, "ampLWhole", tab$, 
... "ampMWhole", tab$, "dynamicAmpWhole"

for i from 1 to nbFiles
select Strings list
	fileName$ = Get string: i
	Read from file: "'parent_directory$'/'fileName$'"
	soundID$ = selected$("Sound")
	Read from file: "'parent_directory$'/'soundID$'.TextGrid"
	nbInterval = Get number of intervals: tier
	for j to nbInterval
		selectObject: "TextGrid 'soundID$'"
		label$ = Get label of interval: tier, j
		if label$ <> ""
			start = Get starting point: tier, j
			startAfter = start + durSeg
			end = Get end point: tier, j
			endBefore = end - durSeg
			duration = end - start
			durationMS = duration * 1000
			mid = start + (duration/2)
			midBefore = mid - (durSeg/2)
			midAfter = mid + (durSeg/2)
			burstBefore = mid - (durSeg/2)
			burstAfter = mid + (durSeg/2)
			wholeBefore = start + (duration * 0.1)
			wholeAfter = end - (duration * 0.1)

			cogStart = undefined
			cogMid = undefined
			cogEnd = undefined
			cogWhole = undefined
			sdevStart = undefined
			sdevMid = undefined
			sdevEnd = undefined
			sdevWhole = undefined
			skewStart = undefined
			skewMid = undefined
			skewEnd = undefined
			skewWhole = undefined
			kurtStart = undefined
			kurtMid = undefined
			kurtEnd = undefined
			kurtWhole = undefined
			levelMStartPa = undefined
			levelHStartPa = undefined
			levelMStartdB = undefined
			levelHStartdB = undefined
			levelMMidPa = undefined
			levelHMidPa = undefined
			levelMMiddB = undefined
			levelHMiddB = undefined
			levelMEndPa = undefined
			levelHEndPa = undefined
			levelMEnddB = undefined
			levelHEnddB = undefined
			levelMWholePa = undefined
			levelHWholePa = undefined
			levelMWholedB = undefined
			levelHWholedB = undefined
			peakAmpdBStart = undefined
			peakFreqHzStart = undefined
			ampLStart = undefined
			ampMStart = undefined
			dynamicAmpStart = undefined
			peakAmpdBMid = undefined
			peakFreqHzMid = undefined
			ampLMid = undefined
			ampMMid = undefined
			dynamicAmpMid = undefined
			peakAmpdBEnd = undefined
			peakFreqHzEnd = undefined
			ampLEnd = undefined
			ampMEnd = undefined
			dynamicAmpEnd = undefined
			peakAmpdBWhole = undefined
			peakFreqHzWhole = undefined
			ampLWhole = undefined
			ampMWhole = undefined
			dynamicAmpWhole = undefined
			levelDStartdB = undefined
			levelDMiddB = undefined
			levelDEnddB = undefined
			levelDWholedB = undefined
			tiltBurst = undefined
			
			if label$ = "s"
				# Start
				selectObject: "Sound 'soundID$'"
				Extract part: start, startAfter, "Kaiser1", 1, "no"
				if filter = 1
					resampleFrequency = max_frequency * 2
					Resample: resampleFrequency, 50
					Filter (pass Hann band): min_frequency, max_frequency, 100
				endif
				if pre_emphasis = 1
					Filter (pre-emphasis): from_frequency
				endif
				To Spectrum: "yes"
				Cepstral smoothing: 1000
				cogStart = Get centre of gravity: 2
				sdevStart = Get standard deviation: 2
				skewStart = Get skewness: 2
				kurtStart = Get kurtosis: 2
				levelMStartPa = Get band energy: 0, cogStart
				levelMStartPaLevel = levelMStartPa/durSeg
				levelMStartdB = 10*log10((sqrt(levelMStartPaLevel)/0.00002)^2)
				levelHStartPa = Get band energy: cogStart, max_frequency
				levelHStartPaLevel = levelHStartPa/durSeg
				levelHStartdB = 10*log10((sqrt(levelHStartPaLevel)/0.00002)^2)
				levelDStartdB = levelHStartdB - levelMStartdB

				Write to binary file: parent_directory$ + "/spectra" + "/" + "'soundID$'_'j'_'label$'_start" + ".Spectrum"

				To Ltas (1-to-1)
				peakAmpdBStart = Get maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				peakFreqHzStart = Get frequency of maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				ampLStart = Get minimum: min_frequency_amplitude_low, max_frequency_amplitude_low, "Parabolic"
				ampMStart = Get mean: min_frequency_amplitude_high, max_frequency_amplitude_high, "dB"
				dynamicAmpStart = ampMStart - ampLStart

				# Mid
				selectObject: "Sound 'soundID$'"
				Extract part: midBefore, midAfter, "Kaiser1", 1, "no"
				if filter = 1
					resampleFrequency = max_frequency * 2
					Resample: resampleFrequency, 50
					Filter (pass Hann band): min_frequency, max_frequency, 100
				endif
				if pre_emphasis = 1
					Filter (pre-emphasis): from_frequency
				endif
				To Spectrum: "yes"
				Cepstral smoothing: 1000
				cogMid = Get centre of gravity: 2
				sdevMid = Get standard deviation: 2
				skewMid = Get skewness: 2
				kurtMid = Get kurtosis: 2
				levelMMidPa = Get band energy: 0, cogMid
				levelMMidPaLevel = levelMMidPa/durSeg
				levelMMiddB = 10*log10((sqrt(levelMMidPaLevel)/0.00002)^2)
				levelHMidPa = Get band energy: cogMid, max_frequency
				levelHMidPaLevel = levelHMidPa/durSeg
				levelHMiddB = 10*log10((sqrt(levelHMidPaLevel)/0.00002)^2)
				levelDMiddB = levelHMiddB - levelMMiddB

				Write to binary file: parent_directory$ + "/spectra" + "/" + "'soundID$'_'j'_'label$'_mid" + ".Spectrum"

				To Ltas (1-to-1)
				peakAmpdBMid = Get maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				peakFreqHzMid = Get frequency of maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				ampLMid = Get minimum: min_frequency_amplitude_low, max_frequency_amplitude_low, "Parabolic"
				ampMMid = Get mean: min_frequency_amplitude_high, max_frequency_amplitude_high, "dB"
				
				dynamicAmpMid = ampMMid - ampLMid


				# End
				selectObject: "Sound 'soundID$'"
				Extract part: endBefore, end, "Kaiser1", 1, "no"
				if filter = 1
					resampleFrequency = max_frequency * 2
					Resample: resampleFrequency, 50
					Filter (pass Hann band): min_frequency, max_frequency, 100
				endif
				if pre_emphasis = 1
					Filter (pre-emphasis): from_frequency
				endif
				To Spectrum: "yes"
				Cepstral smoothing: 1000
				cogEnd = Get centre of gravity: 2
				sdevEnd = Get standard deviation: 2
				skewEnd = Get skewness: 2
				kurtEnd = Get kurtosis: 2
				levelMEndPa = Get band energy: 0, cogEnd
				levelMEndPaLevel = levelMEndPa/durSeg
				levelMEnddB = 10*log10((sqrt(levelMEndPaLevel)/0.00002)^2)
				levelHEndPa = Get band energy: cogEnd, max_frequency
				levelHEndPaLevel = levelHEndPa/durSeg
				levelHEnddB = 10*log10((sqrt(levelHEndPaLevel)/0.00002)^2)
				levelDEnddB = levelHEnddB - levelMEnddB

				Write to binary file: parent_directory$ + "/spectra" + "/" + "'soundID$'_'j'_'label$'_end" + ".Spectrum"

				To Ltas (1-to-1)
				peakAmpdBEnd = Get maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				peakFreqHzEnd = Get frequency of maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				ampLEnd = Get minimum: min_frequency_amplitude_low, max_frequency_amplitude_low, "Parabolic"
				ampMEnd = Get mean: min_frequency_amplitude_high, max_frequency_amplitude_high, "dB"
				dynamicAmpEnd = ampMEnd - ampLEnd


				# Whole
				selectObject: "Sound 'soundID$'"
				Extract part: wholeBefore, wholeAfter, "Kaiser1", 1, "no"
				if filter = 1
					resampleFrequency = max_frequency * 2
					Resample: resampleFrequency, 50
					Filter (pass Hann band): min_frequency, max_frequency, 100
				endif
				if pre_emphasis = 1
					Filter (pre-emphasis): from_frequency
				endif
				To Spectrum: "yes"
				Cepstral smoothing: 1000
				cogWhole = Get centre of gravity: 2
				sdevWhole = Get standard deviation: 2
				skewWhole = Get skewness: 2
				kurtWhole = Get kurtosis: 2
				levelMWholePa = Get band energy: 0, cogWhole
				levelMWholePaLevel = levelMWholePa/durSeg
				levelMWholedB = 10*log10((sqrt(levelMWholePaLevel)/0.00002)^2)
				levelHWholePa = Get band energy: cogWhole, max_frequency
				levelHWholePaLevel = levelHWholePa/durSeg
				levelHWholedB = 10*log10((sqrt(levelHWholePaLevel)/0.00002)^2)
				levelDWholedB = levelHWholedB - levelMWholedB

				Write to binary file: parent_directory$ + "/spectra" + "/" + "'soundID$'_'j'_'label$'_whole" + ".Spectrum"

				To Ltas (1-to-1)
				peakAmpdBWhole = Get maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				peakFreqHzWhole = Get frequency of maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				ampLWhole = Get minimum: min_frequency_amplitude_low, max_frequency_amplitude_low, "Parabolic"
				ampMWhole = Get mean: min_frequency_amplitude_high, max_frequency_amplitude_high, "dB"
				dynamicAmpWhole = ampMWhole - ampLWhole
			
			
			endif
			appendFileLine: "'results$'.xls", fileName$, tab$, label$, tab$, start, tab$, startAfter, tab$, midBefore, tab$, 
		... midAfter, tab$, endBefore, tab$, end, tab$, duration, tab$, durationMS, tab$, cogStart, tab$, sdevStart, tab$, 
		... skewStart, tab$, kurtStart, tab$, levelMStartPa, tab$, levelMStartdB, tab$, levelHStartPa, tab$, levelHStartdB, tab$, levelDStartdB, tab$,
		... peakAmpdBStart, tab$, peakFreqHzStart, tab$, ampLStart, tab$, ampMStart, tab$, dynamicAmpStart, tab$, 
		...	cogMid, tab$, 
		... sdevMid, tab$, skewMid, tab$, kurtMid, tab$, levelMMidPa, tab$, levelMMiddB, tab$, levelHMidPa, tab$, 
		... levelHMiddB, tab$, levelDMiddB, tab$, peakAmpdBMid, tab$, peakFreqHzMid, tab$, ampLMid, tab$, ampMMid, tab$, dynamicAmpMid, tab$,
		... cogEnd, tab$, sdevEnd, tab$, skewEnd, tab$, kurtEnd, tab$, levelMEndPa, tab$, levelMEnddB, tab$, 
		... levelHEndPa, tab$, levelHEnddB, tab$, levelDEnddB, tab$, peakAmpdBEnd, tab$, peakFreqHzEnd, tab$, ampLEnd, tab$, 
		... ampMEnd, tab$, dynamicAmpEnd, tab$,
		... cogWhole, tab$, sdevWhole, tab$, skewWhole, tab$, kurtWhole, tab$, levelMWholePa, tab$, levelMWholedB, tab$, 
		... levelHWholePa, tab$, levelHWholedB, tab$, levelDWholedB, tab$, peakAmpdBWhole, tab$, peakFreqHzWhole, tab$, ampLWhole, tab$, 
		... ampMWhole, tab$, dynamicAmpWhole
		endif
	endfor
select all
minus Strings list
Remove
endfor
echo finished :)

#### Version 1: contains analsyes for both fricatives and stops
#### Version 2: Split by fricative or stop.
#### Make sure to read the "readme" file and cruicially, to adjust the 
#### Values to suit your needs and to follow guidelines from the literature
#### Cite this github repo and the papers associated
#### Any comments, or questions? send me a message through github 
beginPause: "Script spectral analyses - stops"
comment: "Leave empty to select with the browser your path"
sentence: "parent_directory", ""
comment: "What is the name of your results file?"
  	sentence: "results", "spectralResultsStops"
  	comment: "Tier number"
  		positive: "tier", "1"
	comment: "Parameters"
		optionMenu: "Filter", 1
			option: "yes"
			option: "no"
		real: "Min frequency (Hz)", "500"
		real: "Max frequency (Hz)", "12000"
	comment: "Peak frequency range"
		real: "Min frequency peak (Hz)", "750"
		real: "Max frequency peak (Hz)", "8000"
	comment: "Dynamic amplitude - low"
		real: "Min frequency amplitude low (Hz)", "550"
		real: "Max frequency amplitude low (Hz)", "3000"
	comment: "Dynamic amplitude - high"
		real: "Min frequency amplitude high (Hz)", "3000"
		real: "Max frequency amplitude high (Hz)", "7000"
clicked = endPause: "OK", 1

clearinfo

if parent_directory$ = ""
	parent_directory$ = chooseDirectory$("Select your directory of sound files and TextGrids")
endif

createDirectory: "spectra"

Create Strings as file list: "list", "'parent_directory$'/*.wav"
nbFiles = Get number of strings

appendFileLine: "'results$'.xls", "fileName", tab$, "phoneme", tab$, "Start", tab$, "StartAfter", tab$, "midBefore", tab$, 
... "midAfter", tab$, "endBefore", tab$, "end", tab$, "duration", tab$, "durationMS", tab$, "cogBurst", tab$, "sdevBurst", tab$, 
... "skewBurst", tab$, "kurtBurst", tab$, "levelMBurstPa", tab$, "levelMBurstdB", tab$, "levelHBurstPa", tab$, "levelHBurstdB", tab$, "levelDBurstdB", tab$,
... "peakAmpdBBurst", tab$, "peakFreqHzBurst", tab$, "ampLBurst", tab$, "ampMBurst", tab$, "dynamicAmpBurst", tab$, "tiltBurst"


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
			startAfter = start + 0.0256
			end = Get end point: tier, j
			endBefore = end - 0.0256
			duration = end - start
			durationMS = duration * 1000
			mid = start + (duration/2)
			midBefore = mid - 0.0128
			midAfter = mid + 0.0128
			burstBefore = mid - 0.0128
			burstAfter = mid + 0.0128
			wholeBefore = start + (duration * 0.1)
			wholeAfter = end - (duration * 0.1)

			cogBurst = undefined
			sdevBurst = undefined
			skewBurst = undefined
			kurtBurst = undefined
			levelMBurstPa = undefined
			levelHBurstPa = undefined
			levelMBurstdB = undefined
			levelHBurstdB = undefined
			levelDBurstdB = undefined
			peakAmpdBBurst = undefined
			peakFreqHzBurst = undefined
			ampLBurst = undefined
			ampMBurst = undefined
			dynamicAmpBurst = undefined
			tiltBurst = undefined
			
			if label$ = "B"
				# Burst
				selectObject: "Sound 'soundID$'"
				Extract part: burstBefore, burstAfter, "Kaiser1", 1, "no"
				if filter = 1
					resampleFrequency = max_frequency * 2
					Resample: resampleFrequency, 50
					Filter (pass Hann band): min_frequency, max_frequency, 100
				endif
				To Spectrum: "yes"
				Cepstral smoothing: 1000
				cogBurst = Get centre of gravity: 2
				sdevBurst = Get standard deviation: 2
				skewBurst = Get skewness: 2
				kurtBurst = Get kurtosis: 2
				levelMBurstPa = Get band energy: 3000, 7000
				levelMBurstPaLevel = levelMBurstPa/0.0256
				levelMBurstdB = 10*log10((levelMBurstPaLevel/0.00002)^2)
				levelHBurstPa = Get band energy: 7000, 11025
				levelHBurstPaLevel = levelHBurstPa/0.0256
				levelHBurstdB = 10*log10((levelHBurstPaLevel/0.00002)^2)
				levelDBurstdB = levelMBurstdB - levelHBurstdB
				# for Ahi-A23
				tiltBurst = Get band energy difference: 1250, 3000, 3000, 8000
				Write to binary file: parent_directory$ + "/spectra" + "/" + "'soundID$'_'j'_'label$'_Burst" + ".Spectrum"

				To Ltas (1-to-1)
				peakAmpdBBurst = Get maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				peakFreqHzBurst = Get frequency of maximum: min_frequency_peak, max_frequency_peak, "Parabolic"
				ampLBurst = Get minimum: min_frequency_amplitude_low, max_frequency_amplitude_low, "Parabolic"
				ampMBurst = Get mean: min_frequency_amplitude_high, max_frequency_amplitude_high, "dB"
				dynamicAmpBurst = ampMBurst - ampLBurst

			endif
			appendFileLine: "'results$'.xls", fileName$, tab$, label$, tab$, start, tab$, startAfter, tab$, midBefore, tab$, 
		... midAfter, tab$, endBefore, tab$, end, tab$, duration, tab$, durationMS, tab$, cogBurst, tab$, sdevBurst, tab$, 
		... skewBurst, tab$, kurtBurst, tab$, levelMBurstPa, tab$, levelMBurstdB, tab$, levelHBurstPa, tab$, levelHBurstdB, tab$, levelDBurstdB, tab$,
		... peakAmpdBBurst, tab$, peakFreqHzBurst, tab$, ampLBurst, tab$, ampMBurst, tab$, dynamicAmpBurst, tab$, 
		...	tiltBurst
		endif
	endfor
select all
minus Strings list
Remove
endfor
echo finished :)


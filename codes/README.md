### LC-MS raw analysis
Data stored at Terra `/scratch/user/jialiyu/projects/PFAS/LCMS`.

1. Convert raw file to mzML to extract all peaks
```bash
mkdir mzML
module load Mono
mono $SCRATCH/software/ThermoRawParser/ThermoRawFileParser.exe -i 050623LC-B2.raw -o mzML/

cd mzML
module load OpenMS
FileConverter -in 050623LC-B2.mzML -out 050623LC-B2.consensusXM
# extract peaks and save into plain text
grep 'element map' 050623LC-B2.consensusXML > 050623LC-B2.peaks.txt
wc -l 050623LC-B2.peaks.txt
# see the total line number match the peak numbers
```
Do this to every raw file wanted.

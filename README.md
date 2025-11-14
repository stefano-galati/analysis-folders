Run collectData.sh to:
* Read a metric from statsList.txt
* Go through every stats.txt of every simulation inside the specified folder
* Look for the specific metric and add it to the output file in csv format (with ; as separator though)

In the end, the results/ folder will be filled with many files, each one named after the metric it represents.
Example of a file:
results/simTicks.txt
sim0;DUE;12345678
sim1;SDC;10000000
...

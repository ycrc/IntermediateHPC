Bootstrap (boot.R, mcboot.R, parallelboot.R, mpiboot.R)

The bootstrap estimates how much a statistic would vary if we could collect
new data. It resamples the rows of the data with replacement to make many
fake datasets the same size as the original, recomputes the statistic on
each one, and uses the spread of those results as the statistic's standard
error. Its bias estimate is how far the average of the resampled values is
from the value on the original data.

These examples use R's built-in trees data (girth, height and volume of 31
cherry trees). Each resample fits five linear models that predict volume and
returns their R^2 values, and boot() repeats this 300,000 times.

Why it parallelizes well: every resample is independent, so different
workers can handle different resamples and the results are simply pooled.

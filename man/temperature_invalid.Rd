% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/temperature_invalid.R
\name{temperature_invalid}
\alias{temperature_invalid}
\title{Getting Invalid Examples and Summaries for Initial_Temp and Initial_Temp_Units}
\usage{
temperature_invalid(data)
}
\arguments{
\item{data}{The raw data from BioSense on which you will do the invalid temperature checks.}
}
\value{
A list of two data frames: examples and summary for invalid Initial_Temp and Initial_Temp_Units.
}
\description{
This function will generate two data frames: first, a frame to be used later to extract invalid examples from;
second, a frame that contains facility-level summaries for counts and percentages of patient temperature invalids.
}
\details{
This is a more forgiving function. It counts all of the following as valid units: FAHRENHEIT, DEGREE FAHRENHEIT, CELSIUS, DEGREE CELSIUS,
FARENHEIT, DEGREE FARENHEIT, CELCIUS, DEGREE CELCIUS.

If temperature is in C, then it has to be between 23 and 44 inclusive, or else it is invalid  ("OOR" for "out of range")
If it is in F, then it has to be between 73 and 110 inclusive, or else it is invalid ("OOR" for "out of range"). Temp is
considered invalid of Units are not reported with it; similarly, Units are considered invalid of Temp is not reported with them.
}

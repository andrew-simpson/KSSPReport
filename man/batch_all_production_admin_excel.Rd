% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/batch_report_admin_excel.R
\name{batch_all_production_admin_excel}
\alias{batch_all_production_admin_excel}
\title{Batch Job To Create NSSP BioSense Platform Data Quality Summary Reports for All Kansas Facilities in Production for the Hospital Admins, Use excel as input}
\usage{
batch_all_production_admin_excel(
  facility_spreadsheet,
  input,
  table = NA,
  mft = NA,
  username = NA,
  password = NA,
  start = NA,
  end = NA,
  directory = NA,
  email = NA,
  sender = NA,
  email_password = NA,
  personname = NA,
  title = NA,
  phone = NA,
  message = NA
)
}
\arguments{
\item{facility_spreadsheet}{location of the facility spreadsheet xlsx}

\item{input}{location of input.xlsx file.}

\item{table}{The table that you want to retrieve the data from, as a string.}

\item{mft}{The MFT (master facilities table) from where the facility name will be retrieved, as a string.}

\item{username}{Your BioSense username, as a string. This is the same username you may use to log into RStudio or Adminer.}

\item{password}{Your BioSense password, as a string. This is the same password you may use to log into RStudio or Adminer.}

\item{start}{The start date time that you wish to begin pulling data from, as a string.}

\item{end}{The end data time that you wish to stop pulling data from, as a string.}

\item{directory}{The directory where you would like to write the reports to (i.e., "~/Documents/MyReports"), as a string.}

\item{email}{Default False. If True, then the function will atempt to send out a form}

\item{sender}{Email address of sender. Make sure it's kdhe.KS.gov}

\item{email_password}{Your Email Password}

\item{personname}{Your Name to be used in your email text}

\item{title}{Your job title to be used in your email text}

\item{phone}{Your phone number to be used in your email text}

\item{message}{The email message to be sent. Allows for composition of costume messages.}
}
\value{
First the program will ask if the facility spread sheet is up to date. If answer is yes, generate report table stored at directory location. If email=TRUE, then a email will be sent. A table with facility, receiver and conformation of email being sent. In addition, there will be a AdminReport.csv file listing whether the email got sent.
}
\description{
This function uses excel generated information but can be override by additional inputs
This function iteratively performs `write_facilty_report`  function for all Kansas Facilities in production targeted toward admin. It will generate summary report for all specified facility.
The summary workbook shows percents and counts of nulls and invalids, Additionally it generates a timeliness
report and creates a table.
}
\examples{
library(biosensequality)
batch_all_production_admin_excel(facility_spreadsheet="Facilities Spreadsheet_New.xlsx",input="Input.xlsx")
##you can override fields from the input.xlsx
batch_all_production_admin_excel(facility_spreadsheet="Facilities Spreadsheet_New.xlsx",input="Input.xlsx",email=F)
}

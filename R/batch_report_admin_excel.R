#' Batch Job To Create NSSP BioSense Platform Data Quality Summary Reports for All Kansas Facilities in Production for the Hospital Admins, Use excel as input
#'
#' @description
#' This function uses excel generated information but can be override by additional inputs
#' This function iteratively performs `write_facilty_report`  function for all Kansas Facilities in production targeted toward admin. It will generate summary report for all specified facility.
#' The summary workbook shows percents and counts of nulls and invalids, Additionally it generates a timeliness
#' report and creates a table. 
#' @param input location of input.xlsx file.
#' @param facility_spreadsheet location of the facility spreadsheet xlsx
#' @param username Your BioSense username, as a string. This is the same username you may use to log into RStudio or Adminer.
#' @param password Your BioSense password, as a string. This is the same password you may use to log into RStudio or Adminer.
#' @param table The table that you want to retrieve the data from, as a string.
#' @param mft The MFT (master facilities table) from where the facility name will be retrieved, as a string.
#' @param start The start date time that you wish to begin pulling data from, as a string.
#' @param end The end data time that you wish to stop pulling data from, as a string.
#' @param directory The directory where you would like to write the reports to (i.e., "~/Documents/MyReports"), as a string.
#' @param email Default False. If True, then the function will atempt to send out a form
#' @param sender Email address of sender. Make sure it's kdhe.KS.gov
#' @param email_password Your Email Password
#' @param personname Your Name to be used in your email text
#' @param title Your job title to be used in your email text
#' @param phone Your phone number to be used in your email text
#'@param message The email message to be sent. Allows for composition of costume messages.
#' @return First the program will ask if the facility spread sheet is up to date. If answer is yes, generate report table stored at directory location. If email=TRUE, then a email will be sent. A table with facility, receiver and conformation of email being sent. In addition, there will be a AdminReport.csv file listing whether the email got sent.
#' 
#' @examples 
#'library(biosensequality)
#' batch_all_production_admin_excel(facility_spreadsheet="Facilities Spreadsheet_New.xlsx",input="Input.xlsx")
#' ##you can override fields from the input.xlsx
#' batch_all_production_admin_excel(facility_spreadsheet="Facilities Spreadsheet_New.xlsx",input="Input.xlsx",email=F)
#' @import dplyr
#' @import tidyr
#' @import readxl
#' @export
#' 
batch_all_production_admin_excel <- function(facility_spreadsheet, input,table=NA, mft=NA, username=NA,password=NA,start=NA, end=NA,directory=NA,email=NA, sender=NA,email_password=NA,personname=NA,title=NA, phone=NA,message=NA){
  Input <- read_excel(input, col_names = FALSE)
  if (is.na(username)){
    username <- as.character(Input[1,2])
  }
  if (is.na(password)){
    password <- as.character(Input[2,2])
  }
  if (is.na(table)){
    table <- as.character(Input[3,2])
  }
  if(is.na(mft)){
    mft <- as.character(Input[4,2])
  }
  if(is.na(start)){
    start <- as.POSIXct(as.numeric(Input[5,2] ) *(60*60*24),origin= '1899-12-30')  
  }
  if(is.na(end)){
    end <- as.POSIXct(as.numeric(Input[6,2] ) *(60*60*24),origin= '1899-12-30')  
  }
  if(is.na(directory)){
    directory <- as.character(Input[8,2])
  }
   if(is.na(email)) {
    email <-as.logical (Input[11,2])
  }
  if(is.na(sender)) {
    sender<-as.character(Input[12,2])
  }
  if(is.na(email_password)) {
    email_password <-as.character(Input[13,2])
  }
  if(is.na(personname)) {
    personname<-as.character(Input[15,2])
  }
  if(is.na(title)) {
    title<- as.character(Input[16,2])
  }
  if(is.na(phone)){
    phone<- as.character(Input[17,2])
  }
  if(is.na(message)){
    message<- ifelse(is.na(Input[18,2]),NA, as.character(Input[18,2]))
  }
  batch_all_production_admin(facility_spreadsheet=facility_spreadsheet, username=username, password=password, 
                          table=table, mft=mft,
                          start=start, 
                          end=end,
                          directory=directory,
                          email =email, sender=sender,
                          email_password=email_password,personname=personname,title=title, phone=phone,message=message)
}
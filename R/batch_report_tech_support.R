#' Batch Job To Create NSSP BioSense Platform Data Quality Summary Reports for All Kansas Facilities in Production for the Tech Support
#'
#' @description
#' This function iteratively performs `write_facilty_report`  function for all Kansas Facilities in production targeted toward Tech Support. It will generate summary report for all specified facility.
#' The summary workbook shows percents and counts of nulls and invalids, Additionally it generates a timeliness
#' report and creates a table. 
#' @param facility_spreadsheet location of the facility spreadsheet xlsx
#' @param username Your BioSense username, as a string. This is the same username you may use to log into RStudio or Adminer.
#' @param password Your BioSense password, as a string. This is the same password you may use to log into RStudio or Adminer.
#' @param table The table that you want to retrieve the data from, as a string.
#' @param mft The MFT (master facilities table) from where the facility name will be retrieved, as a string.
#' @param start The start date time that you wish to begin pulling data from, as a string.
#' @param end The end data time that you wish to stop pulling data from, as a string.
#' @param field Default NA. Can add a string with delimiter of ':'. Only fields that countain those words will be included in the final report.
#' @param exclude Default NA. Can add a string with delimiter of ':'. Exclude fields with certain keywords in the final report.
#' @param optional Default True. If False then remove all optional fields
#' @param directory The directory where you would like to write the reports to (i.e., "~/Documents/MyReports"), as a string.
#' @param email Default False. If True, then the function will atempt to send out a form
#' @param sender Email address of sender. Make sure it's kdhe.KS.gov
#' @param email_password Your Email Password
#' @param personname Your Name to be used in your email text
#' @param title Your job title to be used in your email text
#' @param phone Your phone number to be used in your email text
#'  @param message The email message to be sent. Allows for composition of costume messages.
#' @return First the program will ask if the facility spread sheet is up to date. If answer is yes, generate report table stored at directory location. If email=TRUE, then a email will be sent. A table with facility, receiver and conformation of email being sent.In addition, there will be a TechReport.csv file listing whether the email got sent. 
#'
#' @examples 
#' library(biosensequality)
#' library(keyring)
#' 
#' ## store passwords for essence
#' key_set(service = "essence")
#' ## store passwords for email
#' key_set(service = "email")
#' batch_all_production_tech_support(facility_spreadsheeet="Facilities Spreadsheet_New.xlsx", username="bzhang02", password=key_get("essence"),
#'  table="KS_PR_Processed", mft="KS_MFT",  start="2020-05-01 00:00:00", 
#'  end="2020-05-30 23:59:59", directory="~",
#'  email =TRUE,sender="bo.zhang@@kdhe.ks.gov",
#' email_password=key_get("email"),personname='Bo Zhang',title='intern',phone='630-457-8915')
#' @import yesno
#' @import dplyr
#' @import tidyr
#' @import readxl
#' @export
batch_all_production_tech_support<-function(facility_spreadsheet,table, mft, username,password,start, end,field=NA, exclude=NA, optional=T,directory,email=F, sender,email_password,personname=NA,title=NA, phone=NA,message=NA){
  ready=yesno2("Make sure your facility spread sheet is up to date. Is your facility spread sheet up to date?")
  if (ready==T){
    contact=read_excel(facility_spreadsheet, sheet = "ED_POC_New")
    contact <- contact[rowSums(is.na(contact))<ncol(contact),]
    niter= nrow(contact)
    success=NA
    
    for (i in 1:niter){
      if (is.na(contact$Status[i])==F & contact$Status[i]=="Production"){
        if (is.na(contact$`Facility IT Contacts Emails`[i])==F){
          success[i]=write_facility_report(username=username, password=password, 
                                           table=table, mft=mft,
                                           start=start, 
                                           end=end,
                                           facility=contact$C_Biosense_Facility_ID[i],
                                           directory=directory,
                                           email =email, sender=sender,field=field,exclude=exclude,optional=optional,receiver=as.character(contact$`Facility IT Contacts Emails`[i]),
                                           email_password=email_password,personname=personname,title=title, phone=phone,message=message)
          
        }else {
          success[i]='No admin email provided'
        }
      }else {
        success[i]='The facility is not in production'
      }
    }
    report=cbind(contact,success)
    report=report %>%
      select(c(`Facility Name`,C_Biosense_Facility_ID,`Facility IT Contacts`,`Facility IT Contacts Emails`,success))
    
    write.csv(report,paste0(directory, "/TechReport",format(Sys.Date(),'%b_%d_%Y'),".csv"), row.names = TRUE)
    return(report)
  }
  else{
    stop("Please Update The Facility Spreadsheet Before Running The Batch Job")
  }
}

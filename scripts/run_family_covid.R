### script for knitting Rmd file and sending email

# load packages
library(knitr)
library(rJava)
library(mailR)
library(rmarkdown)

#Align pandoc
Sys.setenv(RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/MacOS/pandoc")

# set-date
today <- format(Sys.Date(), "%B %d, %Y")
yesterday <- format(Sys.Date() - 1, "%B %d, %Y")

# knit the file
rmarkdown::render(input = "~/covid19/notebooks/covid_plots_fam.Rmd",
                  output_format = "html_document",
                  output_file = "~/covid19/docs/index.html")

# send reminder email
subject.text <- paste0("COVID auto update is running for ", today)
#subject.text <- paste0("Automated COVID report for ", today, " with some cool updates")


body.text <- paste0("This is an automated email. The COVID family html content should have updated with data through ",
                    yesterday, " and should push to Github automatically. To check, go to lelandburns.github.io/covid19.")

recipient.emails <- c("leland.b.burns@gmail.com")

send.mail(from = "leland.b.burns@gmail.com",
          to = recipient.emails,
          subject = subject.text,
          body = body.text,
          smtp = list(host.name = "smtp.gmail.com",
                      port = 465,
                      user.name = Sys.getenv("personal_gmail_user"),
                      passwd = Sys.getenv("personal_gmail_pass"),
                      ssl = TRUE),
          authenticate = TRUE,
          send = TRUE)

# # send email with attachments
# subject.text <- paste0("Automated COVID report for ", today)
# #subject.text <- paste0("Automated COVID report for ", today, " with some cool updates")
# 
# 
# body.text <- paste0("This is an automated email from Leland. Attached is an html file with updated COVID data for our locations, with data included through ",
#                     yesterday, ". To view it, download and then click to open. It should open in your browser. If not, right-click it once downloaded and choose to open with ",
#                     "your browser of choice. Make sure to actually download the file to get full functionality, instead of just previewing it in your email. If you have feedback or something else that you'd like included, let me know!")
# 
# # body.text <- paste0("Attached is an html file with updated COVID data for our locations, with data included through ",
# #                     yesterday, ". I made some cool changes again -- check them out! To view it, download and then click to open. It should open in your browser. If not, right-click it once downloaded and choose to open with ",
# #                     "your browser of choice. Make sure to actually download the file to get full functionality, instead of just previewing it in your email. If you have feedback or something else that you'd like included, let me know!")
# 
# recipient.emails <- c("leland@ensemblex.com",
#                       "alyssa.c.burns@gmail.com",
#                       "bburns4223@sc.rr.com",
#                       "bburns8@dxc.com",
#                       "anthony.j.osbourne@gmail.com",
#                       "caroline.b.chisholm@gmail.com",
#                       "emery.ma.chisholm@gmail.com",
#                       "elizabeth.pinckney.burns@gmail.com")
# 
# send.mail(from = "leland.b.burns@gmail.com",
#           to = recipient.emails,
#           subject = subject.text,
#           body = body.text,
#           smtp = list(host.name = "smtp.gmail.com",
#                       port = 465,
#                       user.name = Sys.getenv("personal_gmail_user"),
#                       passwd = Sys.getenv("personal_gmail_pass"),
#                       ssl = TRUE),
#           authenticate = TRUE,
#           send = TRUE,
#           attach.files = "~/covid19/outputs/covid_plots_fam.html")

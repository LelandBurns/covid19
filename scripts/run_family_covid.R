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
                  output_dir = "~/covid19/outputs/")

# send email with attachments
subject.text <- paste0("Automated COVID report for ", today)

body.text <- paste0("This is an automated email from Leland. Attached is an html file with updated COVID data for our locations, with data included through ",
                    yesterday, ". To view it, download and then click to open. It should open in your browser. If not, right-click it once downloaded and choose to open with ",
                    "your browser of choice. If you have feedback or something else that you'd like included, let me know!")

# body.text <- paste0("Attached is an html file with updated COVID data for our locations, with data included through ",
#                     yesterday, ". Sorry, it's late today because I made some changes -- check them out! To view it, download and then click to open. It should open in your browser. If not, right-click it once downloaded and choose to open with ",
#                     "your browser of choice. Schedule should return to normal tomorrow, with the report going out midday. If you have feedback or something else that you'd like included, let me know!")

recipient.emails <- c("leland@ensemblex.com",
                      "alyssa.c.burns@gmail.com",
                      "bburns4223@sc.rr.com",
                      "bburns8@dxc.com",
                      "anthony.j.osbourne@gmail.com",
                      "caroline.b.chisholm@gmail.com",
                      "emery.ma.chisholm@gmail.com",
                      "elizabeth.pinckney.burns@gmail.com")

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
          send = TRUE,
          attach.files = "~/covid19/outputs/covid_plots_fam.html")

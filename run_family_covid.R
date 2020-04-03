### script for knitting Rmd file and sending email

# load packages
library(knitr)
library(rJava)
library(mailR)

# knit the file
rmarkdown::render("~/covid19/covid_plots_fam.Rmd", "all")

# try to send email with embedded html
send.mail(from = "leland.b.burns@gmail.com",
          to = c("leland@ensemblex.com", "burnie310@yahoo.com"),
          subject = "Test of COVID HTML report",
          body = "~/covid19/covid_plots_fam.html",
          html = TRUE,
          inline = TRUE,
          smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "leland.b.burns@gmail.com", passwd = "8!8pr459D!cR", ssl = TRUE),
          authenticate = TRUE,
          send = TRUE)

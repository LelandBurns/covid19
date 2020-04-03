### script for knitting Rmd file and sending email

# load packages
library(knitr)
library(rJava)
library(mailR)

# knit the file
rmarkdown::render("~/covid19/covid_plots_fam.Rmd", "all")

# try to send email with embedded html
send.mail(from = "leland.b.burns@gmail.com",
          to = c("leland@ensemblex.com", "burnie310@yahoo.com", "alyssa.c.burns@gmail.com"),
          subject = "I got the function to work!",
          body = "I can send emails directly from where I work on data now. Attached is a version of the COVID data I've been working on, focused on our family. Download and open -- it should open in your browser.",
          smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "leland.b.burns@gmail.com", passwd = "vuheumodsumkxgfb", ssl = TRUE),
          authenticate = TRUE,
          send = TRUE,
          attach.files = "~/covid19/covid_plots_fam.html")

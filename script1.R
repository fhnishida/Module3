library(fivethirtyeight)
library(tidyverse)

data("steak_survey", package="fivethirtyeight")
# View(steak_survey)

sdat <- na.omit(steak_survey) %>%
    filter(region=="Mountain")

ggplot(sdat, 
       aes(x = steak_prep, fill = female)) + 
    geom_bar(position="dodge") +
    ggtitle(paste0("Steak Preparation Preference by Gender for ","Mountain"," Region"))

lm(steak ~ age, data = steak_survey)


## RENDER REPORTS

# R code for the render function
rmarkdown::render("steakParams.Rmd",
                  params = list(region = "Mountain"))


# R code to create the custom function
render_report <-function(regionvar){
    template <-"steakArticleParams.Rmd"
    outfile <-sprintf("steakArticle_%s.html",regionvar)
    parameters <-list(region = regionvar)
    rmarkdown::render(template,
                      output_file=outfile,
                      params=parameters)
    invisible(TRUE)
}

render_report("Pacific")


# R code to use the custom function with purrr
library(purrr)
params_list <- list(list("East North Central",
                         "East South Central", "Middle Atlantic",
                         "Mountain", "New England", "Pacific",
                         "South Atlantic", "West North Central",
                         "West South Central"))
purrr::pmap(params_list,render_report)


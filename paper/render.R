library(rmarkdown)
library(rticles)

my_modified_joss <- function(journal = "JOSS", keep_md = TRUE,
                             latex_engine = "xelatex", ...) {
  rmarkdown::pandoc_available("2.2", TRUE)
  logo_path <- rticles:::find_resource("joss", paste0(journal, "-logo.png"))
  journalname <- ifelse(journal == "JOSS", "Journal of Open Source Software",
                        "Journal of Open Source Education")
  template <- rticles:::find_resource("joss", "template.tex")
  p_args <- c("-V", paste0("logo_path=", logo_path), "-V",
              paste0("journal_name=", journalname), "-V", "graphics=true")
  fmt <- bookdown::pdf_book(latex_engine = latex_engine, keep_md = keep_md,
                            pandoc_args = p_args, template = template, ...)
  fmt$inherits <- "pdf_book"
  fmt
}
# delete cache folders first
# on a unix machine
# system("rm -rf paper/paper_cache")
# system("rm -rf ignore/output")
dir.create("ignore/output", recursive = TRUE, showWarnings = FALSE)
rmarkdown::render(input = "paper/paper.Rmd", output_dir = "ignore/output/",
                  intermediates_dir = "ignore/output/", clean = FALSE)
# on a unix machine
# system("mv ignore/output/paper.md paper/paper.md")

SAS_FILES = $(wildcard sas/*.sas7bdat)
RDA_FILES = $(patsubst sas/%.sas7bdat, data/%.rda, $(SAS_FILES))

test:
	@echo $(RDA_FILES)

data: $(RDA_FILES)

data/%.rda: sas/%.sas7bdat
	Rscript -e "library(sas7bdat); library(tools); fname = file_path_sans_ext(basename('$<')); assign(fname, read.sas7bdat('$<')); save($(basename $(notdir $<)), file = '$@')"
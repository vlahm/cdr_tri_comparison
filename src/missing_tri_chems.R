library(tidyverse)

cas_missing = read_csv('data/cas_missing.csv', col_names = FALSE) %>% pull()
cdr = read_csv('data/2020 CDR Manufacturing-Import Information.csv')

cdr_cas_all = cdr %>%
    filter(`CHEMICAL ID TYPE` == 'CASRN') %>%
    distinct(`CHEMICAL ID`) %>%
    pull()

manufactured_or_imported = cas_missing[cas_missing %in% cdr_cas_all]

cdr_filtered = cdr %>%
    filter(`CHEMICAL ID TYPE` == 'CASRN',
           `CHEMICAL ID` %in% manufactured_or_imported)

write_csv(cdr_filtered, 'out/cdr_records_for_missing_tri_chems.csv')

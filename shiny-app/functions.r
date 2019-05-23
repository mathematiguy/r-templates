
ordinal_suffix <- function(x, html=T) {
    y <- as.character(x)
    z <- substr(y, nchar(y), nchar(y))
    s <- ifelse(z == '1' & x %% 100 != '11', 'st',
         ifelse(z == '2' & x %% 100 != '12', 'nd',
         ifelse(z == '3' & x %% 100 != '13', 'rd',
                'th')))
    if (html) {
        return(sprintf('%s<sup>%s</sup>', y, s))
    } else return(paste0(x, s))
}

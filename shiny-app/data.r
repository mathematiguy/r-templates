library(data.table)

dat_table <- data.table(x = 1:5, y = 6:10, z = 11:15)    
dat_plot <- data.table(z = sample(letters[1:5], 100, rep=T), x = rnorm(100), y = rnorm(100))


save(dat_table, dat_plot,
     file = 'data/data.rdata', compress=F)

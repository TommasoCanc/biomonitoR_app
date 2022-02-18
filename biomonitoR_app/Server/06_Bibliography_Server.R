
output$tbl_bibliography <- renderTable({ # table with assign traits results
read.csv("./Bibliography.csv", sep = ";")
})
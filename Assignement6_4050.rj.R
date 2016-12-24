library(rpart)

M1 <- read.csv("MOOC1.csv")
  
M2 <- read.csv("MOOC2.csv")

#Using the rpart package generate a classification tree predicting certified from the other variables in the M1 data frame.

?rpart

c.tree1 <- rpart(certified ~ grade + forum.posts + assignment, method="class", data=M1, control=rpart.control(minsplit=1,minbucket=1, cp=0.001))

#Check the results from the classifcation tree using the printcp() command
printcp(c.tree1)


#Plot your tree
plot(c.tree1)
text(c.tree1)
### If we are worried about overfitting we can remove nodes form our tree using the prune() command, 
### setting cp to the CP value from the table that corresponds to the number of nodes we want the tree to terminate at. 
### Let's set it to two nodes.

c.tree2 <- prune(c.tree1, cp = 0.0029412)
#Visualize this tree and compare it to the one you generated earlier
post(c.tree2, file = "tree2.ps", title = "MOOC") 
#This creates a pdf image of the tree

M2$predict1 <- predict(c.tree1, M2, type = "class")

M2$predict2 <- predict(c.tree2, M2, type = "class")

table(M2$certified, M2$predict1)

table(M2$certified, M2$predict2)

c.tree3 <- prune(c.tree1, cp = 0.0029412)
c.tree4 <- prune(c.tree1, cp = 1.00000)

M2$predict2 <- predict(c.tree4, M2, type = "class")
table(M2$certified, M2$predict2)


plot(c.tree4)

I have a 21% error when using xerror 1 which was the lowest. 

#Week 2

x <- 5
y <- x*2

#objects within objects
x <- 20
y <- x*2

#don't use the equal sign, use the nice arrow

#how R talks back
log_of_word <- log("word")
log_of_word
#errors stop the whole process and don't give outputs
#even if you had stuff after that, it would stop running the code

log_of_negative <- log(-2)
log_of_negative

#messages aren't anything to worry about
#keep track of the Warning Messages though
message("you're doing great")


#If I put "", and then tab, it will bring in
#Absolute file path  = starts from the asbolute top of the storage file path on your computer
#Relative file path = file path starts relative to the working directory (folder you're working in)
#You'd want to use the absolute file path, but if you were to send that to someone else, they're not going to have the full absolute file path
getwd()
#this will give 

#Using ".." will give you access to other folders above my working directory, you can use the tab button to get to other levels and the box will rise up and you can choose what you need, also using the .. in the quotation marks
# this is what it gives you "/Users/sidneywoodruff/Desktop/R_DAVIS_2020/R_DAVIS_in_class_project"


getwd()
"../../../../../../"
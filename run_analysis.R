#make sure these files are in the working directory
#x_train.txt
#X_test.txt
#y_train.txt
#y_test.txt
#features.txt
#subject_train.txt
#subject_test.txt


# READ IN THE TRAINING FILE
train.df=read.delim("X_train.txt",sep="",header=FALSE, quote="\"'",
                    dec=".",row.names=NULL, skip=0,na.string="")
# READ IN THE TEST FILE
test.df=read.delim("X_test.txt",sep="",header=FALSE, quote="\"'",
                   dec=".",row.names=NULL, skip=0)
combine.df<-rbind(train.df,test.df)

# SET THE SOURCE FOR FUTURE REFERENCE
sources<-c(rep("train",times=nrow(train.df)),rep("test",times=nrow(test.df)))
combine.df$sources<-sources

# READ IN THE SUBJECT FILE FOR TRAINING
subject.train=read.delim("subject_train.txt",sep="",header=FALSE, quote="\"'",
                         dec=".",row.names=NULL, skip=0)

# READ IN THE SUBJECT FILE FOR TEST
subject.test=read.delim("subject_test.txt",sep="",header=FALSE, quote="\"'",
                        dec=".",row.names=NULL, skip=0)

subjects<-c(subject.train,subject.test)
#convert list to vector
subjects<-c(subjects[[1]],subjects[[2]])

combine.df$subjects<-subjects

# READ IN THE ACTIVITY FILE FOR TRAINING
activity.train=read.delim("y_train.txt",sep="",header=FALSE, quote="\"'",
                          dec=".",row.names=NULL, skip=0)
walking<-activity.train==1
walking.up<-activity.train==2
walking.dn<-activity.train==3
sitting<-activity.train==4
standing<-activity.train==5
laying<-activity.train==6
activity.train[walking,2]<-"Walking"
activity.train[walking.up,2]<-"WalkingUpstairs"
activity.train[walking.dn,2]<-"WalkingDownstairs"
activity.train[sitting,2]<-"Sitting"
activity.train[standing,2]<-"Standing"
activity.train[laying,2]<-"Laying"


# READ IN THE ACTIVITY FILE FOR TEST
activity.test=read.delim("y_test.txt",sep="",header=FALSE, quote="\"'",
                         dec=".",row.names=NULL, skip=0)
walking<-activity.test==1
walking.up<-activity.test==2
walking.dn<-activity.test==3
sitting<-activity.test==4
standing<-activity.test==5
laying<-activity.test==6
activity.test[walking,2]<-"Walking"
activity.test[walking.up,2]<-"WalkingUpstairs"
activity.test[walking.dn,2]<-"WalkingDownstairs"
activity.test[sitting,2]<-"Sitting"
activity.test[standing,2]<-"Standing"
activity.test[laying,2]<-"Laying"

activities<-rbind(activity.train,activity.test)

combine.df$activities<-activities[,2]


#The combine.df has no column names.  
#the combine.df has too many columns
# READ IN THE COLUMN NAMES
columnnames<-read.delim("features.txt",sep="",header=FALSE,stringsAsFactors=FALSE)

# SET THE COLUMN NAMES OF THE TRAIN FILE
colnames(combine.df)<-columnnames[,2]
# additional columns:
names(combine.df)[565]<-"activitiesID"
names(combine.df)[564]<-"activities"
names(combine.df)[563]<-"subjects"
names(combine.df)[562]<-"sources"

#find the index of the mean() and std() columns
mean.index<-grep("mean()",names(combine.df))
std.index<-grep("std()",names(combine.df))
all.index<-c(mean.index,std.index,c(562,563,564,565))

#reduce the number of columns
combine.reduced<-combine.df[,all.index]


#create the output file
sum.tbl<-tapply(combine.reduced,index=list(combine.reduced$subjects,combine.reduced$activities),mean)
write.table(sum.tbl,file="sum.tbl.txt",row.names=FALSE)



#!/bin/bash

#F1="$(ls -l | grep -v ^d | wc -l)" 
#ls, then use grep to match the output of ls of line that starts with d -v reverse it so lines that dont match d

#F1=( $(ls -l | grep ^d | awk {'print $9'}) )
#the double brackets make this an array where with out it i think would have been string, 
#the $9 denotes the 9th column of the ls -l, without -l you wold just get the all file and folder names

#echo "${F1[2]}" #with quote print on each line, with out, just one line

#var1="$($F1 | cut -f1 -d-)"

#cwd="$(pwd)" #sets cwd to get the current working directory
#echo $cwd
#FOLDER_COUNT="$(ls -l | grep ^d | wc -l)" #ls then only returns where prefix starts with d, then do a wordcount and 
                                          #returns now many where start started in the prefix 
hello() {
  F_C="$(ls -l | grep ^d | wc -l)" #Gets the folder count. 
                                   #ls then only returns where prefix starts with d, then do a word count and 
                                   #returns how many lines started in the prefix d
  if [ $F_C -gt 1 ]                #If F_C is greater than 1 
  then
    echo "There is" "$F_C" "Espisodes in " 
    F1=( $(ls -l | grep ^d | awk {'print $9'}) ) #Same as above folder count, except where we print the 9th 
                                                 #colomn of the index of the ls, the file name, for us here its all the seasons
    #for i in "${F1[@]}"; do                     #loops through F1 and list all the seasons folder
    #  echo "$i"
    #done
    for i in ${!F1[@]}
    do
      #echo "hello-" "$(pwd)"                    #echos current dir
      cd ${F1[$i]}                               #cd to the first folder in the F1 array the nth season
      RAR="$(ls -l | grep *.rar | wc -l)"        #does a check for rar files
      RAR_NAME="$(ls | grep *.rar)"              #gets the name of the rar file
      if [ $RAR -ge 1 ]                          #if RAR is greather or equal to 1
      then                                       
        7z x $RAR_NAME                           #unrar the file
      elif [ $RAR -e 0 ]                         #if there are no rar files
      then
        echo "Nothing here to unRar"             #echo there is not rar file
        continue
      else
        continue 
      fi
      #echo "hello-" "$(pwd)"
      cd ..
    done
  else
    echo "hello-There is no folders here"
    echo "hello-" "$(pwd)"
    cd ..
  fi 
}


hello2() {
  F_C2="$(ls -l | grep ^d | wc -l)" #ls then only returns where prefix starts with d, then do a wordcount and 
                                   #returns now many lines started in the prefix d
  
  ABP="$(pwd)" #sets cwd to get the current working directory
  echo "hello2-" "$(pwd)"
  if [ $F_C2 -gt 1 ] 
  then
    echo "hello2-There is more than one folder"
    echo "hello2" $F_C2 " folders"
    F12=( $(ls -l | grep ^d | awk {'print $9'}) ) #sam as above folder count, except where we print the 9th colomn of the index
    for i in "${F12[@]}";do
      echo "hello-" "$i"
    done
    for i in ${!F12[@]};do
      cd ${ABP}"/"${F12[$i]}
      hello
    done
  else
    echo "There is no folders here"
    echo "hello2"
  fi 
}

hello2


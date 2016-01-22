#!/bin/bash

LOG=out.txt
List=$(hammer |awk '/^Subcommands:/,/^$/'|awk '{print $1}'|sed 1d)
#List=$(echo activation-key architecture)

> $LOG

for b in $List
do
  #echo "IN###"							|	tee -a $LOG
  echo "hammer $b"						|       tee -a $LOG	
  hammer $b --help						|       tee -a $LOG
  echo								|       tee -a $LOG

  ListUnder1=$(hammer $b --help | awk '/^Subcommands:/,/^$/'|awk '{print $1}'|sed 1d)
  
  for x in $ListUnder1
  do
    echo "hammer $b $x"						|       tee -a $LOG	
    hammer $b $x --help						| 	tee -a $LOG
    echo							|       tee -a $LOG
  done
  
  #echo "OUT###"							|       tee -a $LOG
done

#!/bin/bash

cd equilibrium
for T in 600
do
	cd $T
	id=$(grep -o -E 'JOB ID: [0-9]+' jobid | awk '{print $NF}')
	lbg job download $id
	cd $id
	mv * ../
	cd ../../
done

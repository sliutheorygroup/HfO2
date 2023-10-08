#!/bin/bash

mkdir equilibrium
cd equilibrium
for T in 600
do
	mkdir $T
	cd $T
	cp ../../../script/job.json ../../../script/Hafnia_v1.pb ../../../script/conf.lmp ../../../script/input-eq.lammps ./
        mv input-eq.lammps input.lammps
	sed -i "s/variable        TEMP            equal 0.000000/variable        TEMP            equal $T/g" input.lammps
        lbg job submit -i job.json -p ./ >jobid
        if [ -e "jobid" ]; then
		echo "The task has been submitted."
	fi
        cd ..
done

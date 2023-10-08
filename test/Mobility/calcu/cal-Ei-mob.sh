

mkdir Electric
cd Electric
for T in 600
do
	mkdir $T
        cd $T
	for E in -0.08
	do 
		mkdir n$E
		cd n$E
		cp ../../../equilibrium/$T/eq.restart ../../../../script/input-E.lammps ../../../../script/job.json ../../../../script/Hafnia_v1.pb ./
		mv input-E.lammps input.lammps
		sed -i "s/variable VALUEZ  equal 0/variable VALUEZ  equal $E/g" input.lammps
		sed -i "s/variable        TEMP            equal 0.000000/variable        TEMP            equal $T/g" input.lammps
	        lbg job submit -i job.json -p ./ >jobid
	        if [ -e "jobid" ]; then
		echo "The task has been submitted."
         	fi
	        cd ../
	done
	cd ..
done
cd ..

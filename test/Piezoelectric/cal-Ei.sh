for D in $(seq -0.01 0.001 -0.001)
do
	mkdir n$D
	cp ./0/eq.restart ./script/lmp.in ./script/job.json ./script/Hafnia_v1.pb n$D
	cd n$D
	mv lmp.in input.lammps
	sed -i "s/variable VALUEZ  equal 0/variable VALUEZ  equal $D/g" input.lammps
	lbg job submit -i job.json -p ./ >jobid
	if [ -e "jobid" ]; then
		echo "The task has been submitted."
	fi
	cd ..
done

for D in $(seq 0.001 0.001 0.01)
do
        mkdir p$D
        cp ./0/eq.restart ./script/lmp.in ./script/job.json ./script/Hafnia_v1.pb p$D
        cd p$D
        mv lmp.in input.lammps
        sed -i "s/variable VALUEZ  equal 0/variable VALUEZ  equal $D/g" input.lammps
        lbg job submit -i job.json -p ./ >jobid
        if [ -e "jobid" ]; then
                echo "The task has been submitted."
        fi
        cd ..
done

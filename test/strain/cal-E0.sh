for D in 0
do
	mkdir $D
	cp ./script/conf.lmp ./script/lmp-0.in ./script/job.json ./script/graph.pb $D
	cd $D
	mv lmp-0.in input.lammps
	lbg job submit -i job.json -p ./ >jobid
	if [ -e "jobid" ]; then
		echo "The task has been submitted."
	fi
	cd ..
done


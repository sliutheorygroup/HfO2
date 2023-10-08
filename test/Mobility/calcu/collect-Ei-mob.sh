
cd Electric
for T in 600
do
	CURRENT=`pwd`
        cd $T
        for E in -0.08
        do
                cd n$E
		id=$(grep -o -E 'JOB ID: [0-9]+' jobid | awk '{print $NF}')
		lbg job download $id
		cd $id
		mv * ../
		cd ../
		if [ ! -e "HfO2-npt.MSD" ]; then
			echo "HfO2-npt.MSD not found, exiting..."
			exit 1
		else
			echo "HfO2-npt.MSD has been prepared!"
		fi
		if [ ! -e "input.lammps" ]; then
                        echo "input.lammps not found, exiting..."
                        exit 1
                else
                        echo "input.lammps has been prepared!"
                fi
		python ../../../../script/mobility.py 
		mu=$(tail -1 mu.dat)
		echo $E $mu >> $CURRENT/mu-$T.data
		echo $E $mu >> $CURRENT/mu-$T.data
                cd ..
        done
        cd ..
	cp mu-$T.data ../Mobility.dat
done

for D in 0
do
	cd $D
	id=$(grep -o -E 'JOB ID: [0-9]+' jobid | awk '{print $NF}')
	lbg job download $id
	cd $id
	mv * ../ 
	cd ../../
done

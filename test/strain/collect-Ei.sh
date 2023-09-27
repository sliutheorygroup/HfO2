for D in  $(seq -0.01 0.001 -0.001)
do
	cd n$D
	id=$(grep -o -E 'JOB ID: [0-9]+' jobid | awk '{print $NF}')
	lbg job download $id
	cd $id
	mv * ../ 
	cd ../../
done

for D in  $(seq 0.001 0.001 0.01)
do
        cd p$D
        id=$(grep -o -E 'JOB ID: [0-9]+' jobid | awk '{print $NF}')
        lbg job download $id
        cd $id
        mv * ../
        cd ../../
done

CURRENT=`pwd`
for D in $(seq -0.01 0.001 -0.001)
do
	cd n$D
        nline=$((777 * 100))
        tail -$nline  traj.lammpstrj >> traj-last.lammpstrj
	python ../script/avg-dump.py traj-last.lammpstrj
	latt=$(tail -1 lat.dat)
	echo $D $latt >> $CURRENT/Evslat.dat
	cd $CURRENT
done

for D in 0
do
        cd $D
        nline=$((777 * 100))
        tail -$nline  traj.lammpstrj >> traj-last.lammpstrj
        python ../script/avg-dump.py traj-last.lammpstrj
        latt=$(tail -1 lat.dat)
        echo $D $latt >> $CURRENT/Evslat.dat
        cd $CURRENT
done

for D in $(seq 0.001 0.001 0.01)
do
        cd p$D
        nline=$((777 * 100))
        tail -$nline  traj.lammpstrj >> traj-last.lammpstrj
        python ../script/avg-dump.py traj-last.lammpstrj
        latt=$(tail -1 lat.dat)
        echo $D $latt >> $CURRENT/Evslat.dat
        cd $CURRENT
done

sed -i "s/p//g" Evslat.dat
sed -i "s/n//g" Evslat.dat

input_file="Evslat.dat"
output_file="Evstrain.dat"

a0=$(awk '$1 == 0 {print $2}' "$input_file")
b0=$(awk '$1 == 0 {print $4}' "$input_file")
c0=$(awk '$1 == 0 {print $6}' "$input_file")

awk -v a0="$a0" -v b0="$b0" -v c0="$c0" '{print -$1*100, 100*($2-a0)/a0,  ($4-b0)*100/b0, 100*($6-c0)/c0}' "$input_file" > "$output_file"



CURRENT=`pwd`
for D in p0.01 p0.02 p0.03 0 n-0.08 n-0.09 n-0.10
do
	cd $D
        nline=$((777 * 250))
        tail -$nline  traj.lammpstrj >> traj-last.lammpstrj	
	python ../script/avg-dump.py traj-last.lammpstrj
	latt=$(tail -1 lat.dat)
	echo $D $latt >> $CURRENT/Evslat.dat
	cd $CURRENT
done
sed -i "s/p//g" Evslat.dat 
sed -i "s/n//g" Evslat.dat
python ./script/sort.py

input_file="Evslat-sort.dat" 
output_file="Evstrain.dat"

a0=$(awk '$1 == 0 {print $2}' "$input_file")
b0=$(awk '$1 == 0 {print $4}' "$input_file")
c0=$(awk '$1 == 0 {print $6}' "$input_file")

awk -v a0="$a0" -v b0="$b0" -v c0="$c0" '{print -$1*100, 100*($2-a0)/a0,  100*($4-b0)/b0,  100*($6-c0)/c0}' "$input_file" > "$output_file"

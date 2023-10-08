for D in SI-1 SI-2 SA
do
	cd $D
	dp test -m ../Hafnia_v1.pb -n 50 -s ./deepmd -d $D-dptest
	sed -i '1d' *.out
	cp $D-dptest.e.out ../
	cd ..
	mv $D-dptest.e.out $D.out
done



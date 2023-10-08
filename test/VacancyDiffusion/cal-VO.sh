for D in PO-3-3 PO-4-4  PO-3-4
do
	cd $D
	dp test -m ../Hafnia_v1.pb -n 50 -s ./deepmd -d $D-dptest
	sed -i '1d' *.out
	cp $D-dptest.e.out ../
	cd ..
	mv $D-dptest.e.out $D.out
done


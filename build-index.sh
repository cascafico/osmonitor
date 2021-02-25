echo "<HTML><BODY>Monitor process run on $T1 <BR>" > index1.html

for file in 36*changeset.html
do
  echo "======" >> index1.html
	cat ${file} >> index1.html
done

echo "</BODY></HTML>" >> index1.html

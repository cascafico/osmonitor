echo "Index built on `date`<BR>" > index1.html
for file in *_changeset.html
do
  echo "======" >> index1.html
  echo "<B>"$file"</B>" >> index1.html    
  cat ${file} >> index1.html
done
echo "</BODY></HTML>" >> index1.html

echo "Index built on `date`<BR>" > index.html
for file in *_changeset.html
do
   echo "<A HREF="$file">"${file:0:2}"</A><BR>" >> index.html
done
echo "</BODY></HTML>" >> index.html

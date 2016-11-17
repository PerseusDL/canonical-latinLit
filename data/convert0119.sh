header="<?xml-model href=\"http:\/\/www\.stoa\.org\/epidoc\/schema\/8\.19\/tei-epidoc\.rng\"\tschematypens=\"http:\/\/relaxng\.org\/ns\/structure\/1\.0\"?>\n<?xml-model href=\"http:\/\/www\.stoa\.org\/epidoc\/schema\/8\.19\/tei-epidoc\.rng\"\tschematypens=\"http:\/\/purl\.oclc\.org\/dsdl\/schematron\"?>\n<TEI xmlns=\"http:\/\/www\.tei-c\.org\/ns\/1\.0\">"
for i in $(find ./phi0119 -regex ".*1\.xml")
do
#for i in ./phi0119/phi0[0-9[0-9]/*{eng1,lat1}.xml; do
	echo "${i}"
	echo "XSL 1"
	java -jar /home/thibault/app/Oxygen\ XML\ Editor\ 17/lib/saxon9ee.jar -s:$i -xsl:../../tei-conversion-tools/xslt/generic_div.xsl -o:$i -expand:off
	echo "Namespace"
	sed -i "2s/.*/$header/" $i
	echo "Greek"
	python3 ../../../tei-numberer/__greek__.py $i $i
	echo "Lang"
	sed -i "s/lang\=\"la\"/lang\=\"lat\"/" $i
	sed -i "s/lang\=\"en\"/lang\=\"eng\"/" $i
	sed -i "s/lang\=\"fr\"/lang\=\"fre\"/" $i
	sed -i "s/lang\=\"it\"/lang\=\"ita\"/" $i
	sed -i "s/lang\=\"de\"/lang\=\"ger\"/" $i
	sed -i "s/ lang\=/ xml\:lang\=/" $i
	sed -i "s/\"TLN line\"/\"line\"/" $i
	echo "Changes"
	python3 change.py $i $i
done

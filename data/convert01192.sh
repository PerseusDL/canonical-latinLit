header="<?xml-model href=\"http:\/\/www\.stoa\.org\/epidoc\/schema\/8\.19\/tei-epidoc\.rng\"\tschematypens=\"http:\/\/relaxng\.org\/ns\/structure\/1\.0\"?>\n<?xml-model href=\"http:\/\/www\.stoa\.org\/epidoc\/schema\/8\.19\/tei-epidoc\.rng\"\tschematypens=\"http:\/\/purl\.oclc\.org\/dsdl\/schematron\"?>\n<TEI xmlns=\"http:\/\/www\.tei-c\.org\/ns\/1\.0\">\'"
for i in $(find ./phi0119 -regex ".*1\.xml")
do
#for i in ./phi0119/phi0[0-9[0-9]/*{eng1,lat1}.xml; do
	java -jar /home/thibault/app/Oxygen\ XML\ Editor\ 17/lib/saxon9ee.jar -s:$i -xsl:../../tei-conversion-tools/xslt/phi0119cleanup.xsl -o:$i -expand:off
	sed -i "s/xmlns\=\"\"//" $i
	python3 ../../../tei-numberer/__greek__.py $i $i
	sed -i "s/ lang\=\"la\"/ xml\:lang\=\"lat\"/" $i
	sed -i "s/ lang\=\"en\"/ xml\:lang\=\"eng\"/" $i
	sed -i "s/ lang\=\"fr\"/ xml\:lang\=\"fre\"/" $i
	sed -i "s/ lang\=\"it\"/ xml\:lang\=\"ita\"/" $i
	sed -i "s/ lang\=\"de\"/ xml\:lang\=\"ger\"/" $i
	sed -i "s/ lang\=\"/ xml\:lang\=\"/" $i
	echo "${i}"
done

#!/usr/bin/env python3
# Python 3 Script for automatic GreekBetaCode
#
# Thibault Clerice, @Ponteineptique

import sys
import re

inputFile = sys.argv[1]

if len(sys.argv) == 3:
    outputFile = sys.argv[2]
else:
    outputFile = inputFile.split(".")
    outputFile = ".".join(outputFile[0:len(outputFile)-1] + ["transformed"] + [outputFile[-1]])

with open(inputFile) as f:
    Repl = re.compile("Revision\s+\d+.\d+\s+(\d+)[-/](\d+)[-/](\d+)\s+\d+:\d+:\d+\s+(\w+)\s*\n(.*)\n{0,1}")
    Repl2 = re.compile("<revisionDesc>(\s*\n).*(\s*)<change")
    Repl3 = re.compile("</change>(.*)\n")
    print(inputFile, outputFile)
    content = Repl.sub(r'<change who="\4" when="\1-\2-\3">\5</change>', f.read())
    content = Repl2.sub(r'<revisionDesc>\1\2<change', content)
    content = Repl3.sub(r'\1</change>\n', content)

with open(outputFile, "w") as ff:
    ff.write(content)






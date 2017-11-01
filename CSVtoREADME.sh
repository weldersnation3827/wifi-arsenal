#!/bin/sh

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Usage: Start script and let wifi-arsenal.csv be transformed.
# The generated file is saved as README.md and can be commited afterwards.
# The gh-md-toc script included in the repo is needed for this script to work!

# create copy of .csv
cp wifi-arsenal.csv wifi-arsenal.csv_tmp

# add '* [' at the beginning of each line for markdown list
sed -i -e 's/^/* [/g' wifi-arsenal.csv_tmp

# Title/Link-transformation to markdown syntax
sed -i -e 's/;/](/' wifi-arsenal.csv_tmp
sed -i -e 's/;/) - /' wifi-arsenal.csv_tmp

# add every category to README_tmp.md
echo '## General WiFi Information' >> README_tmp.md
grep ';Info;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Noteworthy Tools of Different Categories' >> README_tmp.md
grep ';Note' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Attack/PenTesting' >> README_tmp.md

echo '### Denial of Service' >> README_tmp.md
grep ';DoS;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '### Encryption Attack' >> README_tmp.md
echo '#### WEP' >> README_tmp.md
grep ';WEP' wifi-arsenal.csv_tmp | sort >> README_tmp.md
echo '#### WPA/WPA2' >> README_tmp.md
grep ';WPA/WPA2' wifi-arsenal.csv_tmp | sort >> README_tmp.md
echo '#### WPS' >> README_tmp.md
grep ';WPS' wifi-arsenal.csv_tmp | sort >> README_tmp.md
echo '#### Others' >> README_tmp.md
grep ';Encryption;;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '### Injection' >> README_tmp.md
grep ';Injection;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '### Rogue AP/Fake AP/ MITM' >> README_tmp.md
grep ';RogueAP;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '### Sniffing' >> README_tmp.md
grep ';Sniff;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '### Wardriving' >> README_tmp.md
grep ';Wardriving;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '### Miscellaneous Attacking Tools' >> README_tmp.md
grep ';Attack;;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Information Gathering' >> README_tmp.md
grep ';InfoGath;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Defence/Detection' >> README_tmp.md
grep ';Defend;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Libraries/General Purpose Tools' >> README_tmp.md
grep ';Lib;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Visualization' >> README_tmp.md
grep ';Visual;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Localisation' >> README_tmp.md
grep ';Location;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Configuration/setup' >> README_tmp.md
grep ';Config;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Monitoring' >> README_tmp.md
grep ';Monitoring;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

echo '## Miscellaneous/not sorted :)' >> README_tmp.md
grep ';Misc;' wifi-arsenal.csv_tmp | sort >> README_tmp.md

# delete any column after the description
sed -i -e 's/;.*//g' README_tmp.md

# begin README.md text
echo '# Curated WiFi Arsenal' > README.md
echo 'This project is based on the great work of [0x90/wifi-arsenal](https://github.com/0x90/wifi-arsenal). I needed to go through the whole list of over 500 wifi-related projects listed there. I found the following limitations:' >> README.md
echo >> README.md
echo '* by using submodules the project links are often not up-to-date, they are commit links' >> README.md
echo '* the list lacks a categorization of projects' >> README.md
echo '* there is no description of projects so that you have to click every bad-named project to evaluate usefullness' >> README.md
echo >> README.md
echo 'As I had to go through all the projects anyway I tried to fix this limitations and created a csv file which can be transformed into a README.md easily (shell-script inlcuded). And here it is. I hope it will help somebody. The categorization is not always easy/accurate (going through 500 projects was exhausting, concentration was gone eventually!). Please feel free to fix or add things and submit a pull request!' >> README.md
echo >> README.md
echo 'Keep track of [changes made in the original 0x90/wifi-arsenal repo](https://github.com/0x90/wifi-arsenal/compare/master...techge:collection-base) and not added here.' >> README.md

echo '## Table of Contents' >> README.md

# set executable rights to toc-generator
chmod u+x gh-md-toc

# generate toc and add to README.md
./gh-md-toc README_tmp.md | cut -c 5- | tail -n +4 | head -n -1 >> README.md

echo "TOC created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)" >> README.md

# insert generated content in README.md
cat README_tmp.md >> README.md

# clean up
rm wifi-arsenal.csv_tmp README_tmp.md

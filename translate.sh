#!/bin/sh
#
#   This file finds spellings in the English.xml file to translate,
#   and then translates them and makes a Murica.xml file.
#
#########

echo ""
echo "********************************************************************************"
echo "**                                                                            **"
echo "**                                                                            **"
echo "**                               ==========================================   **"
echo "**     *   *   *   *   *   *     ==========================================   **"
echo "**       *   *   *   *   *                                                    **"
echo "**     *   *   *   *   *   *     ==========================================   **"
echo "**       *   *   *   *   *       ==========================================   **"
echo "**     *   *   *   *   *   *                                                  **"
echo "**       *   *   *   *   *       ==========================================   **"
echo "**     *   *   *   *   *   *     ==========================================   **"
echo "**       *   *   *   *   *                                                    **"
echo "**     *   *   *   *   *   *     ==========================================   **"
echo "**                               ==========================================   **"
echo "**                                                                            **"
echo "**   ======================================================================   **"
echo "**   ======================================================================   **"
echo "**                                                                            **"
echo "**   ======================================================================   **"
echo "**   ======================================================================   **"
echo "**                                                                            **"
echo "**   ======================================================================   **"
echo "**   ======================================================================   **"
echo "**                                                                            **"
echo "**                                                                            **"
echo "**  ’MURICA!                                                                  **"
echo "**                                                                            **"
echo "**  Replaces British English spellings for Baldur’s Gate 3 with US English.   **"
echo "**                                                                            **"
echo "**  by ancestral                                                              **"
echo "**  Last updated Aug 13 2023                                                  **"
echo "**                                                                            **"
echo "**  Is something not working? Are there missing words? Please leave feedback  **"
echo "**  at https://github.com/ancestral/Murica or find me on the Larian Discord.  **"
echo "**                                                                            **"
echo "**                                                                            **"
echo "********************************************************************************"
echo ""
echo "Preparing files..."

rm -f matches.xml
rm -f Murica.xml
cp English.xml English_0.xml

# Preprocessing
echo '<?xml version="1.0" encoding="utf-8"?>' >> matches.xml
echo '<contentList>' >> matches.xml

# Force each element onto one line by folding newlines
# (Larian uses CRLF)
perl -pi -e 's/([^>])\r\n$/$1\\n /g while m/[^>]\r\n$/' English_0.xml
perl -pi -e 's/([^>])\r\n$/$1\\n /g'  English_0.xml

echo "Finding lines to replace..."

# Read each line from the spellings.txt to substitute
# Take these lines and put them into a matches file
while IFS= read -r line; do
  FIND=${line% => *}
	
	# If the line has a `(hash|hash)` on it, that means only replace for those
	# contentid’s.
	if [[ $line =~ "("*")" ]]; then
		ONLY=\(${line##*(}
    ONLY=$(echo $ONLY | tr -d "()")
		perl -ne 'print if /'"$ONLY"'.+\b'"$FIND"'\b/i' English_0.xml >> matches.xml
	else	
		perl -ne 'print if /\b'"$FIND"'\b/i' English_0.xml >> matches.xml
	fi
done < spellings.txt

rm English_0.xml

echo '</contentList>' >> matches.xml

# Delete duplicate lines (it could happen if one line contains multiple
# different word substitutions.)
perl -ne 'print unless $seen{$_}++;' matches.xml >> Murica.xml
rm -f matches.xml

# Make substitutions
echo "Making substitutions..."

while IFS= read -r line; do
  FIND=${line% => *}
	SUBSTITUTION=${line% (*}
	REPLACE=${SUBSTITUTION##* => }

	perl -pi -e 's/\b'"$FIND"'\b/'"$REPLACE"'/g' Murica.xml
  perl -pi -e 's/\b\u'"$FIND"'\b/\u'"$REPLACE"'/g' Murica.xml
  perl -pi -e 's/\b\U'"$FIND"'\E\b/\U'"$REPLACE"'\E/g' Murica.xml
done < spellings.txt

echo "Cleaning up..."

# Fix newlines
perl -pi -e 'tr/\r//d' Murica.xml
perl -pi -e 's/\\n /\n/g' Murica.xml
perl -pi -e 's/\n/\r\n/g' Murica.xml

echo "Done"
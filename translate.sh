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
echo "**  Replaces British English spellings for Baldur’s Gate 3                    **"
echo "**  with the far better US English. F**k yeah!                                **"
echo "**                                                                            **"
echo "**  by ancestral                                                              **"
echo "**  Last updated Aug 12 2023                                                  **"
echo "**                                                                            **"
echo "**  Is something not working? Are there missing words? Please leave feedback  **"
echo "**  at https://github.com/ancestral/Murica or find me on the Larian Discord.  **"
echo "**                                                                            **"
echo "**                                                                            **"
echo "********************************************************************************"
echo ""
echo "Preparing files..."

exit

rm -f matches.xml
rm -f Murica.xml

echo '<?xml version="1.0" encoding="utf-8"?>' >> matches.xml
echo '<contentList>' >> matches.xml

# Preprocessing
echo "Finding lines to replace..."

while IFS= read -r line; do
  FIND=${line% => *}
	if [[ $line =~ "("*")" ]]; then
		ONLY=\(${line##*(}
    ONLY=$(echo $ONLY | tr -d "()")
		perl -ne 'print if /'"$ONLY"'.+\b'"$FIND"'\b/i' English.xml >> matches.xml
	else	
		perl -ne 'print if /\b'"$FIND"'\b/i' English.xml >> matches.xml
	fi
done < spellings.txt

echo '</contentList>' >> matches.xml
perl -ne 'print unless $seen{$_}++;' matches.xml >> Murica.xml
rm -f matches.xml

# Substitutions
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

perl -pi -e 'tr/\r//d' Murica.xml

echo "Done"
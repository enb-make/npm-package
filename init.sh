#!/bin/sh

echo "NPM Package Generator."

CONFIRM="N"

while true; do

    case "$CONFIRM" in

        N)
            echo
            printf "Enter Package Name: "
            read PackageName

            printf "Enter Version Number: "
            read Version

            printf "Enter your Name: "
            read AuthorName

            printf "Enter your Email Address: "
            read Email
            ;;

        X)
            exit
            ;;

        Y)
            break
            ;;
    esac

    echo
    echo "Package Name: $PackageName"
    echo "Package Version: $Version"
    echo "Name: $AuthorName"
    echo "Email: $Email"
    echo
    printf "Generate npm package? [Y|N|X] "
    read CONFIRM

done

function replace_consts {
    while IFS= read -r data; do
        echo "$data" |
            sed 's/{{PackageNameUpperUnderscored}}/'"$PackageNameUpperUnderscored"/ |
            sed 's/{{PackageName}}/'"$PackageName"/ |
            sed 's/{{AuthorName}}/'"$AuthorName"/ |
            sed 's/{{Version}}/'"$Version"/ |
            sed 's/{{Email}}/'"$Email"/ |
            sed 's/{{Year}}/'"$Year"/
    done
}

OUTPUT_FOLDER="`pwd`/$PackageName"

if [ -r "$OUTPUT_FOLDER" ]; then
    echo "Directory already exists: $OUTPUT_FOLDER"
    exit 1
fi

PackageNameUpperUnderscored=`echo "$PackageName" | tr "[:lower:]-" "[:upper:]_"`
Year=`date +%Y`

TMP_INPUT_FOLDER="/tmp/`date +%s`-npm-package"
git clone "https://github.com/enb-make/npm-package.git" "$TMP_INPUT_FOLDER"
rm -Rf "$TMP_INPUT_FOLDER"/*.sh
mv "$TMP_INPUT_FOLDER"/README.md.in "$TMP_INPUT_FOLDER"/README.md

echo
echo "Generating npm package..."
cd "$TMP_INPUT_FOLDER"
find . | grep -v './.git/' | while read FILENAME; do
    if [ -f "$FILENAME" ]; then
        FILENAME=`echo "$FILENAME" | sed 's/.\///'`
        RESULT_FILENAME=`echo "$FILENAME" | replace_consts`
        OUTPUT_FILENAME="$OUTPUT_FOLDER/$RESULT_FILENAME"
        mkdir -p `dirname $OUTPUT_FILENAME`
        cat "$FILENAME" | replace_consts > "$OUTPUT_FILENAME"
        echo "Generated $FILENAME -> $RESULT_FILENAME"
    fi
done

cd "$OUTPUT_FOLDER"
git init
echo
echo "Git repository initialized"

npm install
echo
echo "NPM packages installed"

echo
echo "NPM package stub created: $OUTPUT_FOLDER"

rm -Rf "$TMP_INPUT_FOLDER"

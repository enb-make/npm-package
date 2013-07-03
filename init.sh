#!/bin/sh

function npm_generator() {

    echo "NPM Package Generator."

    CONFIRM="N"

    while true; do

        case "$CONFIRM" in

            N)
                echo
                printf "Enter Package Name: "
                read PackageName

                printf "Enter your First Name: "
                read FirstName

                printf "Enter your Last Name: "
                read LastName

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
        echo "First Name: $FirstName"
        echo "Last Name: $LastName"
        echo "Email: $Email"
        echo
        printf "Generate npm package? [Y|N|X] "
        read CONFIRM

    done

    function replace_consts {
        while read data; do
            echo "$data" |
                sed 's/{{PackageNameUpperUnderscored}}/'"$PackageNameUpperUnderscored"/ |
                sed 's/{{PackageName}}/'"$PackageName"/ |
                sed 's/{{FirstName}}/'"$FirstName"/ |
                sed 's/{{LastName}}/'"$LastName"/ |
                sed 's/{{Email}}/'"$Email"/
        done
    }

    OUTPUT_FOLDER="`pwd`/$PackageName"

    if [ -r "$OUTPUT_FOLDER" ]; then
        echo "Directory already exists: $OUTPUT_FOLDER"
        exit 1
    fi

    PackageNameUpperUnderscored=`echo "$PackageName" | tr "[:lower:]-" "[:upper:]_"`

    TMP_INPUT_FOLDER="/tmp/`date +%s`-npm-package"
    git clone "https://github.com/enb-make/npm-package.git" "$TMP_INPUT_FOLDER"

    echo
    echo "Generating npm package..."
    cd "$TMP_INPUT_FOLDER"
    find . | grep -v './.git' | while read FILENAME; do
        if [ -f "$FILENAME" ]; then
            FILENAME=`echo "$FILENAME" | sed 's/.\///'`
            RESULT_FILENAME=`echo "$FILENAME" | replace_consts`
            OUTPUT_FILENAME="$OUTPUT_FOLDER/$RESULT_FILENAME"
            mkdir -p `dirname $OUTPUT_FILENAME`
            cat "$FILENAME" | replace_consts > "$OUTPUT_FILENAME"
            echo "Generated $FILENAME -> $RESULT_FILENAME"
        fi
    done

    rm -Rf "$TMP_INPUT_FOLDER"
}

`npm_generator`

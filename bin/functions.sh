#!/bin/bash

# PATH TO GRADING DIRS
TARGET=$1

function get_qa(){
# get-qa.sh
    local TARGET=${1:- TARGET}

    # Get each question 
    
    printf "\n-------------\n"
    #echo  "TESTING QA LIST";
    printf "\n${qa_list}\n-------------\n\n"
    while IFS= read -r line;
    do 
        echo $line;
        question=$(echo $line| egrep -o  "\d+\..*\?"); 
        answer=$(echo $line| egrep -o "(\d+\..*\?)(\w.+)" ); 
        
        printf "\n{\n\t\"line\":\"${line}\"\n\t\"question\":\"${question}\"\n\t\"answer\": \"${answer}\"\n},"
        printf "\n-------\n\n";
    done < $TARGET
}
function alt_qa(){
# get-qa.sh
    local TARGET=${1:- TARGET}

    # Get each question 
    
    printf "\n----------b---\n"
    #echo  "TESTING LIST";
    regex="(\d+\..*\?)(\w.+)"
    for f in $files    # unquoted in order to allow the glob to expand
    do
        if [[ $f =~ $regex ]]
        then
            name="${BASH_REMATCH[1]}"
            echo "${name}.jpg"    # concatenate strings
            name="${name}.jpg"    # same thing stored in a variable
        else
            echo "$f doesn't match" >&2 # this could get noisy if there are a lot of non-matching files
        fi
    done
}

function fix_stupid_filenames(){
    for stupid_name in $(ls *.txt);do 
        echo "NAME $stupid_name";
        new_name=$(echo $stupid_name | cut -d. -f 2)
        printf "\nNEW_NAME: $new_name\n"
        mv $stupid_name $new_name && printf "\n\n---CHANGED----\nOLD: $stupid_name\nNEW: $new_name"
    done 
}

function prep_docx(){
       
        local FILENAME=${1%.*}
        local FILENAME=$(echo $FILENAME | sed -e 's/"//' )
        echo "FILENAME: $FILENAME"
        echo

        local DOCX_FILENAME=$(echo $1| xargs echo ) 
        printf "\nDOCX_FILENAME: $DOCX_FILENAME\n"
       
        # Set Temporary file name
        eval TEMPFILE_NAME="${FILENAME}.tmp.txt"
        
        # Convert Docx To Txt
        docx2txt.pl "${DOCX_FILENAME}";

        # Strip extra lines
        cat "${FILENAME}".txt | tr -s '\n' >> "${TEMPFILE_NAME}"
        cat "${FILENAME}".txt | tr -s '\t' >> "${TEMPFILE_NAME}"

        # GET QA
        get_qa "${TEMPFILE_NAME}"
        
        printf "\n TEMPFILE: $TEMPFILE_NAME \n\n----END prep_docx-------\n\n"

}

function prep_all_docx(){
    # Prep all docs
    TEMPFILE=/tmp/prep_docx.tmp
    find "${TARGET}" -type f -iname "*.docx" |  sed  's/\.\/\///' >> $TEMPFILE
    while read -r line;
    do 
        filepath="\"${line}\""
        printf "\n ${filepath}\n---------\n"
       prep_docx "${filepath}"
    done < $TEMPFILE
    rm $TEMPFILE
}

#prep_all_docx

function update_graded_names(){
     eval local TARGET=$1
     find $TARGET -type f -iname "*.docx" -exec cp {} {}-GRADED \;
     find $TARGET  -type f -iname "*.docx*" -exec rm {} {}.docx \;
}
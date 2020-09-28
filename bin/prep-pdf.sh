#!/bin/bash
TARGET=$1

# For Each Student DOCX Submission, Convert to TXT
find $TARGET -iname "*.pdf"  -exec  pdftotext {}  {}.txt \;

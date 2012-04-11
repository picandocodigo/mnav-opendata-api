#!/bin/bash
# Usage: ./convert_to_utf-8.sh input-file output-file
iconv --from-code=ISO-8859-1 --to-code=UTF-8 $1 > $2
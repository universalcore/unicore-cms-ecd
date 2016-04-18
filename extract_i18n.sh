#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsecd/locale

pot-create -o unicorecmsecd/locale/unicorecmsecd.pot unicorecmsecd/

declare -a arr=("eng_GB")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsecd/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsecd/locale/""$lang""/LC_MESSAGES/unicorecmsecd.po" ]; then
        msginit -l $lang -i unicorecmsecd/locale/unicorecmsecd.pot -o unicorecmsecd/locale/$lang/LC_MESSAGES/unicorecmsecd.po
    fi

    msgmerge --update unicorecmsecd/locale/$lang/LC_MESSAGES/unicorecmsecd.po unicorecmsecd/locale/unicorecmsecd.pot
    msgfmt unicorecmsecd/locale/$lang/LC_MESSAGES/*.po -o unicorecmsecd/locale/$lang/LC_MESSAGES/unicorecmsecd.mo
done

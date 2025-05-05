#!/bin/bash

# genPackagejson.sh
# Generates a package.json file for the snippets directory

cd ~/.config/nvim/snippets

# get the list of all snippets exclude package.json
snippets=$(find . -type f -name '*.json' -not -name 'package.json' -not -name 'global.json')

# gen base
# "name": "example-snippets",
# "contributes": {
	


# traverse all snippets
contributes=""

for snippet in $snippets; do
    if [[ -n $contributes ]]; then
        contributes="$contributes,\n"
    fi

    lang=${snippet##*/}
    lang=${lang%.json}

    contributes="$contributes\
        {
            \"language\": [\"$lang\"],
            \"path\": \"$snippet\"
        }"
done

if [[ -n $contributes ]]; then
    contributes="$contributes,\n"
fi

contributes="$contributes\
{
    \"language\": [\"all\"],
    \"path\": \"./global.json\"
}"


content="{
    \"name\": \"example-snippets\",
    \"contributes\": {
        \"snippets\": [
            $(echo -e $contributes)
        ]
    }
}"
echo -e $content | jq '.' > ./package.json

# cat > ./package.json <<EOL
# {
#     "name": "example-snippets",
#     "contributes": {
#         "snippets": [
#             $(echo -e $contributes)
#         ]
#     }
# }
# EOL

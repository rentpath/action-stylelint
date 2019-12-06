#!/bin/sh

set -e

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

npm install -g stylelint@$(jq -r '.dependencies.stylelint // .devDependencies.stylelint | gsub("[\\^\\~]"; "")' package.json)

stylelint --version

stylelint "${INPUT_STYLELINT_INPUT:-'**/*.css'}" | reviewdog -f="stylelint" -reporter="github-pr-check" -level="${INPUT_LEVEL}"

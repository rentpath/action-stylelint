#!/bin/sh

set -e

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

npm install -g stylelint@$(jq -r '.dependencies.stylelint // .devDependencies.stylelint | gsub("[\\^\\~]"; "")' package.json)

stylelint --version

stylelint --allow-empty-input --ignore-pattern "${INPUT_STYLELINT_IGNORE}" --config "${INPUT_STYLELINT_CONFIG}" "${INPUT_STYLELINT_INPUT:-'**/*.css'}" | reviewdog -f="stylelint" -reporter="github-pr-check" -level="${INPUT_LEVEL}"

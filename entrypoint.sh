#!/bin/sh
set -ex

if [ -n "${GITHUB_WORKSPACE}" ] ; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
fi

# Install protolint
if ! [ -f "protolint" ]; then
  echo "🔄 Installing protolint v${INPUT_PROTOLINT_VERSION}..."
  wget https://github.com/yoheimuta/protolint/releases/download/v"${INPUT_PROTOLINT_VERSION}"/protolint_"${INPUT_PROTOLINT_VERSION}"_Linux_x86_64.tar.gz
  tar zxf protolint_"${INPUT_PROTOLINT_VERSION}"_Linux_x86_64.tar.gz
fi

# Check if .protolint.yaml exists and -config_path is not already set
if [ -f ".protolint.yaml" ] && [[ ! "${INPUT_PROTOLINT_FLAGS}" =~ "-config_path" ]]; then
    DEFAULT_CONFIG="-config_path=.protolint.yaml"
else
    DEFAULT_CONFIG=""
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

./protolint ${DEFAULT_CONFIG} ${INPUT_PROTOLINT_FLAGS} 2>&1 \
  | reviewdog -efm="[%f:%l:%c] %m" \
      -name="linter-name (protolint)" \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      -level="${INPUT_LEVEL}" \
      ${INPUT_REVIEWDOG_FLAGS}

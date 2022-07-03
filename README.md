# reviewdog-action-protolint

[![Test](https://github.com/yoheimuta/action-protolint/workflows/Test/badge.svg)](https://github.com/yoheimuta/action-protolint/actions?query=workflow%3ATest)
[![reviewdog](https://github.com/yoheimuta/action-protolint/workflows/reviewdog/badge.svg)](https://github.com/yoheimuta/action-protolint/actions?query=workflow%3Areviewdog)
[![depup](https://github.com/yoheimuta/action-protolint/workflows/depup/badge.svg)](https://github.com/yoheimuta/action-protolint/actions?query=workflow%3Adepup)
[![release](https://github.com/yoheimuta/action-protolint/workflows/release/badge.svg)](https://github.com/yoheimuta/action-protolint/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/yoheimuta/action-protolint?logo=github&sort=semver)](https://github.com/yoheimuta/action-protolint/releases)
[![action-bumpr supported](https://img.shields.io/badge/bumpr-supported-ff69b4?logo=github&link=https://github.com/haya14busa/action-bumpr)](https://github.com/haya14busa/action-bumpr)

This GitHub Action runs [protolint](https://github.com/yoheimuta/protolint) with reviewdog.

## Usage
```yaml
name: reviewdog
on: [pull_request]
jobs:
  linter_name:
    name: runner / protolint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: yoheimuta/action-protolint@v1
        with:
          github_token: ${{ secrets.github_token }}
          # Change reviewdog reporter if you need [github-pr-check,github-check,github-pr-review].
          reporter: github-pr-review
          # Change reporter level if you need.
          # GitHub Status Check won't become failure with warning.
          level: warning
```

## Input

```yaml
inputs:
  ### Flags for reviewdog ###
  level:
    description: 'Report level for reviewdog [info,warning,error]'
    default: 'error'
  reporter:
    description: 'Reporter of reviewdog command [github-pr-check,github-check,github-pr-review].'
    default: 'github-pr-check'
  filter_mode:
    description: |
      Filtering mode for the reviewdog command [added,diff_context,file,nofilter].
      Default is added.
    default: 'added'
  fail_on_error:
    description: |
      Exit code for reviewdog when errors are found [true,false]
      Default is `false`.
    default: 'false'
  reviewdog_flags:
    description: 'Additional reviewdog flags'
    default: ''
  ### Flags for protolint ###
  protolint_version:
    description: 'Protolint version to be installed'
    default: '0.38.2'
  protolint_flags:
    description: |
      Flags and args to pass to protolint.
      The path provided here is relative to the workdir path, provided in the workdir input.
      Default is `.`, which makes protolint run on the path provided in the workdir input.
    default: '.'
```

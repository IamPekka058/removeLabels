# removeLabels - GitHub Action

![GitHub issues](https://img.shields.io/github/issues/IamPekka058/removeLabels)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IamPekka058/removeLabels)
![License: MIT](https://img.shields.io/github/license/IamPekka058/removeLabels)

A fast GitHub Action to remove specific labels, separated by a custom delimiter, from a pull request or issue using the GitHub API.

## Usage

```yaml
- name: Remove labels from PR or Issue
  uses: IamPekka058/removeLabels@v1
  with:
    labels: 'bug|help wanted'
    github_token: ${{ secrets.GITHUB_TOKEN }}
    delimiter: '|'
```

## Inputs

| Name         | Description                                                | Required |
|--------------|------------------------------------------------------------|----------|
| labels       | A list of labels to remove, separated by the chosen delimiter.| Yes      |
| github_token | GitHub token to authenticate.                              | Yes      |
| delimiter    | Delimiter used to separate labels (default: <code>&#124;</code>).| No       |

## How it works

This action detects whether the workflow was triggered by a pull request or an issue and removes the specified labels using the GitHub REST API. You can customize the delimiter for your label list.

## License

MIT
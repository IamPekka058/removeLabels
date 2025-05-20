# removeLabels - GitHub Action

![GitHub issues](https://img.shields.io/github/issues/IamPekka058/removeLabels)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IamPekka058/removeLabels)
![License: MIT](https://img.shields.io/github/license/IamPekka058/removeLabels)

A fast GitHub Action to remove specific labels from a pull request or issue using the GitHub API.

## Usage

> **Note:**
> To remove labels from issues or pull requests, your workflow must have the `issues: write` and/or `pull-requests: write` permissions. See [Workflow permissions](https://docs.github.com/en/actions/using-jobs/assigning-permissions-to-jobs) for more information.

```yaml
- name: Remove multiple labels from PR or Issue
  uses: IamPekka058/removeLabels@v1
  with:
    labels: ['bug''help wanted']
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

```yaml
- name: Remove multiple labels from PR or Issue
  uses: IamPekka058/removeLabels@v1
  with:
    labels: |
      - bug
      - help wanted
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

```yaml
- name: Remove single label from PR or Issue
  uses: IamPekka058/removeLabels@v1
  with:
    labels: 'bug'
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name         | Description                                                | Required |
|--------------|------------------------------------------------------------|----------|
| labels       | A list of labels to remove.                                | Yes      |
| github_token | GitHub token to authenticate.                              | Yes      |

## How it works

This action detects whether the workflow was triggered by a pull request or an issue and remove  <sub>Made with ❤️ in Bavaria</sub>ing the GitHub REST API.

## License

MIT
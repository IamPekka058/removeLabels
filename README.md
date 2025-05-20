# removeLabels - GitHub Action

![GitHub issues](https://img.shields.io/github/issues/IamPekka058/removeLabels)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IamPekka058/removeLabels)
![License: MIT](https://img.shields.io/github/license/IamPekka058/removeLabels)

A fast GitHub Action to remove specific labels from a pull request or issue using the GitHub API.

## Usage

```yaml
- name: Remove labels from PR or Issue
  uses: IamPekka058/removeLabels@v2
  with:
    labels: |
      - 'bug'
      - 'enhancement
      - 'feature'
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name         | Description                                                | Required |
|--------------|------------------------------------------------------------|----------|
| labels       | A list of labels to remove.                                | Yes      |
| github_token | GitHub token to authenticate.                              | Yes      |

## How it works

This action detects whether the workflow was triggered by a pull request or an issue and removes the specified labels using the GitHub REST API.

## License

[MIT](LICENSE)



<div align="center">  
  Made with ❤️ in Bavaria  
</div>
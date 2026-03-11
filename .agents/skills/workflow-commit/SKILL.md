---
name: workflow-commit
description: Review the current Git changes, draft a Chinese commit message for user confirmation, then commit the intended local changes without pushing. Use when the user asks to commit work in the current repository.
---

# Commit Agent

Commit the current changes to the Git repository.

## Execution Steps

1. Get the staged/unstaged changes from the Git repository
2. Generate a commit message based on the changes and let the user review and confirm
3. Commit the all changes to the Git repository
4. Output the commit message in the conversation
5. Don't push the change to the remote repository yet, if the user not request to push.

## Commit Message Format
- The commit message should be in the following format:
  - [type]: [subject]
  - [body]
- The commit type should be one of the following:
  - feat: A new feature
  - bugfix: A bug fix or hotfix
  - chore: A chore
  - refactor: A code refactor
  - docs: Documentation changes
  - style: Code style changes
  - perf: Performance improvements
  - revert: Revert a previous commit
  - merge: Merge a branch
- The commit subject should be a short, descriptive summary of the changes and always using English.
- The commit body should be a detailed description of the changes and always using English.
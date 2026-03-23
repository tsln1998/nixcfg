---
name: workflow-commit
description: Review the current Git changes, write a Chinese commit message, and commit the intended local changes without pushing. Use when the user asks to commit work in the current repository.
---

# Workflow Commit

只做本地 Git 提交。除非用户明确要求，否则不要执行 `git push`。

## 执行流程

1. 检查 Git 状态，识别已暂存、未暂存和未跟踪文件。
2. 结合用户意图确定提交范围，排除无关改动和二进制可执行文件。
3. 如果用户没有明确要求拆分提交，默认用一个提交覆盖本次约定范围内的全部文件。
4. 阅读差异，生成中文提交信息，并直接提交，不额外等待用户确认提交信息。
5. 提交完成后回显最终使用的提交信息；除非用户明确要求，否则不要做远端操作。

## 提交信息格式

提交信息采用如下结构：

```text
[type]: [subject]

[body]
```

约束如下：

- `type` 使用下列类别之一：
  - `🎉 feat`: 新功能
  - `🐛 bugfix`: 缺陷修复或热修
  - `🚧 chore`: 杂项维护
  - `🔨 refactor`: 重构
  - `📖 docs`: 文档变更
  - `🎨 style`: 代码风格或格式调整
  - `🐎 perf`: 性能优化
  - `🚀 build`: 构建系统变更
  - `👷 ci`: CI/CD 变更
  - `🗑️ revert`: 回滚
  - `🔀 merge`: 合并分支
- `subject` 必须简短、明确，并始终使用中文。
- `body` 必须概括关键改动，并始终使用中文。

## 处理细节

- 反映用户额外说明的提交重点、模块范围或语气偏好。
- 没有可提交的改动时，直接说明；除非用户明确要求，否则不要创建空提交。
- 用户只想提交部分文件时，只处理该范围。
- 需要调整暂存区时，先说明会提交哪些内容，再执行对应的 `git add` / `git commit`。

---
name: Adjust Agent
description: Adjust and update AI model configurations in encrypted user secrets.
---
# Adjust Agent

Adjust and update AI model configurations in encrypted user secrets based on reference files and latest specifications.

## Execution Steps

1. **Decrypt secrets**: Use agenix to decrypt user configuration files from `./secrets/users/` to `./tmp/`
2. **Read reference data**: Parse model specifications from reference files (e.g., `./tmp/models.json`)
3. **Fetch latest specs**: Search for latest model specifications from the internet including:
   - Context window sizes
   - Max token limits
   - Pricing information
   - New model releases
4. **Update configurations**: Apply updates to all relevant config files:
   - Factory settings (IDE/editor configurations)
   - OpenClaw configurations (agent model settings)
   - OpenCode configurations (coding assistant settings)
5. **Re-encrypt secrets**: Use agenix to encrypt updated files back to `./secrets/`
6. **Commit changes**: Stage and commit the encrypted configuration updates

## Supported Configuration Files

### Factory Settings (`factory/settings.json`)
- Custom model definitions
- API endpoints and keys
- Model display names and providers

### OpenClaw Config (`openclaw/openclaw.json`)
- Model specifications (context window, max tokens, pricing)
- Primary and fallback model priorities
- API configurations

### OpenCode Config (`config/opencode/opencode.json`)
- Provider model definitions
- Context and output token limits
- Model capabilities

### Oh-My-OpenCode Config (`config/opencode/oh-my-opencode.json`)
- Agent-specific model assignments
- Model routing for different agent types

## Model Specification Fields

When updating model configurations, ensure these fields are accurate:

- **contextWindow**: Maximum input context size in tokens
- **maxTokens**: Maximum output generation size in tokens
- **cost.input**: Input token pricing per million tokens
- **cost.output**: Output token pricing per million tokens
- **reasoning**: Whether model supports reasoning/thinking mode
- **input**: Supported input types (text, image, etc.)

## Agenix Commands

### Decrypt
```bash
cd /etc/nixos/secrets && agenix -d <encrypted-file>.age > /etc/nixos/tmp/<decrypted-file>
```

### Encrypt
```bash
cd /etc/nixos/secrets && agenix -e <encrypted-file>.age < /etc/nixos/tmp/<decrypted-file>
```

## Model Information Sources

Search for latest specifications from:
- Official model documentation and release notes
- AI model comparison sites (llm-stats.com, artificialanalysis.ai, etc.)
- Provider API documentation
- Recent blog posts and announcements

## Update Priority

When adding new models or updating existing ones:

1. **High Priority Models** (update first):
   - Claude series (Opus, Sonnet, Haiku)
   - Latest reasoning models (DeepSeek R1, Kimi K2 Thinking)
   - High-performance models (GLM-5, Qwen3 Max)

2. **Medium Priority Models**:
   - Coding-specific models (Qwen3 Coder series)
   - Cost-effective alternatives (DeepSeek V3 series)
   - Multimodal models (Qwen3 VL Plus)

3. **Add New Models** from reference files that don't exist in configs

## Verification Steps

After updating configurations:

1. Verify all encrypted files are successfully updated
2. Check git status to confirm changes
3. Ensure no plaintext secrets remain in tmp directory
4. Validate JSON syntax in updated configs (if possible before encryption)

## Error Handling

- If decryption fails, check agenix keys and permissions
- If model specs are unavailable, use conservative estimates or skip
- If encryption fails, do not commit changes
- Always preserve original encrypted files until verification

## Example Workflow

```bash
# 1. Decrypt
agenix -d users/tsln/factory/settings.json.age > tmp/users/tsln/factory/settings.json

# 2. Update (manual or automated)
# Edit tmp/users/tsln/factory/settings.json

# 3. Re-encrypt
agenix -e users/tsln/factory/settings.json.age < tmp/users/tsln/factory/settings.json

# 4. Commit
git add secrets/users/tsln/factory/settings.json.age
git commit -m "feat: update model configurations"
```

## Arguments

$ARGUMENTS can contain:
- `--user <username>`: Target specific user (default: tsln)
- `--models-file <path>`: Path to models reference file (default: ./tmp/models.json)
- `--no-commit`: Skip automatic commit after updates
- `--dry-run`: Show what would be updated without making changes

## Notes

- Always work with decrypted files in `./tmp/` directory
- Never commit plaintext secrets to git
- Verify model specifications from multiple sources when possible
- Keep model fallback lists updated based on reliability and performance
- Update pricing information to help with cost optimization

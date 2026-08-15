{
  pkgs,
  config,
  tools,
  ...
}:
let
  inherit (config.home) username homeDirectory;

  workdir = "${homeDirectory}/.openclaw";
in
{
  home.packages = [ pkgs.mcporter ];

  home.file.".openclaw/workspace/config/mcporter.json".text = builtins.toJSON {
    mcpServers = {
      qmd = {
        command = "qmd";
        args = [ "mcp" ];
        lifecycle = "keep-alive";
        env = {
          XDG_CONFIG_HOME = "${workdir}/agents/main/qmd/xdg-config";
          QMD_CONFIG_DIR = "${workdir}/agents/main/qmd/xdg-config/qmd";
          XDG_CACHE_HOME = "${workdir}/agents/main/qmd/xdg-cache";
        };
      };
    };
  };

  age = {
    secrets = {
      "users/${username}/openclaw/config.env" = {
        file = tools.relative "secrets/users/${username}/openclaw/config.env.age";
        mode = "600";
      };
    };
  };

  programs = {
    openclaw = rec {
      package = pkgs.repos.agents.openclaw;
      environment = {
        QMD_EMBED_MODEL = "hf:Qwen/Qwen3-Embedding-0.6B-GGUF/Qwen3-Embedding-0.6B-Q8_0.gguf";
        QMD_RERANK_MODEL = "hf:ggml-org/Qwen3-Reranker-0.6B-Q8_0-GGUF/qwen3-reranker-0.6b-q8_0.gguf";
        QMD_GENERATE_MODEL = "hf:tobil/qmd-query-expansion-1.7B-gguf/qmd-query-expansion-1.7B-q4_k_m.gguf";
      };
      bundledPlugins = {
        summarize = {
          enable = false;
        };
        discrawl = {
          enable = false;
        };
        wacrawl = {
          enable = false;
        };
        peekaboo = {
          enable = false;
        };
        poltergeist = {
          enable = false;
        };
        sag = {
          enable = false;
        };
        camsnap = {
          enable = false;
        };
        gogcli = {
          enable = false;
        };
        goplaces = {
          enable = false;
        };
        sonoscli = {
          enable = false;
        };
        imsg = {
          enable = false;
        };
      };

      instances = {
        default = {
          enable = true;
          package = package;
          stateDir = workdir;
          workspaceDir = "${workdir}/workspace";
          gatewayPort = 2048;
          runtimePlugins = [
            "qqbot"
          ];

          config = {
            gateway = {
              mode = "local";
              port = 2048;
              bind = "lan";
              auth = {
                mode = "password";
                password = "\${OPENCLAW_GATEWAY_PASSWORD}";
              };
              tailscale = {
                mode = "off";
                resetOnExit = false;
              };
              controlUi = {
                allowedOrigins = [ "*" ];
                dangerouslyDisableDeviceAuth = true;
              };
            };

            plugins = {
              enabled = true;
              entries = {
                openai = {
                  enabled = true;
                };
                codex = {
                  enabled = false;
                };
                acpx = {
                  enabled = true;
                  config = {
                    permissionMode = "approve-all";
                  };
                };
                workboard = {
                  enabled = true;
                  config = { };
                };
                memory-core = {
                  enabled = true;
                  config = {
                    dreaming = {
                      enabled = true;
                    };
                  };
                };
                qqbot = {
                  enabled = true;
                };
              };
            };

            skills = {
              entries = {
                coding-agent = {
                  enabled = true;
                };
              };
            };

            agents = {
              list = [
                {
                  id = "main";
                  name = "Main";
                  description = "Main conversation agent.";
                  workspace = "${workdir}/workspace";
                }
                {
                  id = "codex";
                  name = "Codex";
                  description = "Dedicated ACP coding executor for Workboard worker tasks.";
                  workspace = "${workdir}/workspace";
                }
                {
                  id = "worker";
                  name = "Workboard";
                  description = "Claims ready Workboard cards, validates their acceptance criteria, starts the configured codex ACP executor, records evidence, and moves cards to review or blocked. Never marks cards done automatically.";
                  workspace = "${workdir}/workspace";
                  model = {
                    primary = "openai/gpt-5.6-luna";
                  };
                  tools = {
                    profile = "coding";
                    alsoAllow = [
                      "sessions_spawn"
                      "sessions_yield"
                    ];
                  };
                  subagents = {
                    delegationMode = "prefer";
                  };
                }
              ];
              defaults = {
                models = {
                  "openai/gpt-5.6-terra" = { };
                  "openai/gpt-5.6-sol" = { };
                  "openai/gpt-5.6-luna" = { };
                };
                model = {
                  primary = "openai/gpt-5.6-terra";
                };
                bootstrapMaxChars = 50000;
                bootstrapTotalMaxChars = 300000;
                contextInjection = "always";
                subagents = {
                  maxConcurrent = 64;
                };
                memorySearch = {
                  experimental = {
                    sessionMemory = true;
                  };
                  sources = [
                    "memory"
                    "sessions"
                  ];
                };
              };
            };

            tools = {
              exec = {
                applyPatch = {
                  workspaceOnly = false;
                };
              };

              web = {
                search = {
                  enabled = true;
                  provider = "duckduckgo";
                  maxResults = 10;
                  timeoutSeconds = 30;
                };
                fetch = {
                  ssrfPolicy = {
                    # Clash Fake-IP defaults to the RFC 2544 benchmark range.
                    allowRfc2544BenchmarkRange = true;
                  };
                };
              };
            };

            acp = {
              enabled = true;
              backend = "acpx";
              defaultAgent = "codex";
              allowedAgents = [ "codex" ];
              maxConcurrentSessions = 8;
              runtime = {
                ttlMinutes = 120;
              };
            };

            memory = {
              backend = "qmd";
              citations = "auto";
              qmd = {
                searchMode = "vsearch";
                includeDefaultMemory = true;
                sessions = {
                  enabled = true;
                };
                update = {
                  startup = "idle";
                };
                limits = {
                  timeoutMs = 30000;
                };
                mcporter = {
                  enabled = true;
                  serverName = "qmd";
                  startDaemon = true;
                };
              };
            };

            models = {
              providers = {
                openai = {
                  api = "openai-responses";
                  auth = "api-key";
                  baseUrl = "\${OPENAI_BASE_URL}";
                  apiKey = "\${OPENAI_API_KEY}";
                  timeoutSeconds = 180;
                };
              };
            };

            channels = {
              qqbot = {
                enabled = true;
                groupPolicy = "disabled";
                appId = "\${QQBOT_APP_ID}";
                clientSecret = "\${QQBOT_CLIENT_SECRET}";
                dmPolicy = "allowlist";
                allowFrom = [
                  "0F52B8C4F7EC337D3E7283B657CFCA5C"
                ];
              };
            };

            mcp = {
              servers = {
                figma = {
                  command = "npx";
                  args = [
                    "-y"
                    "figma-developer-mcp"
                    "--stdio"
                    "--no-telemetry"
                  ];
                  env = {
                    FIGMA_API_KEY = "\${FIGMA_API_KEY}";
                  };
                  cwd = "${workdir}/workspace";
                };
              };
            };

            browser = {
              enabled = true;
              evaluateEnabled = true;
              tabCleanup = {
                enabled = true;
                idleMinutes = 15;
                maxTabsPerSession = 30;
              };
              ssrfPolicy = {
                dangerouslyAllowPrivateNetwork = true;
              };
            };
          };
        };
      };
    };
  };

  systemd = {
    user = {
      services = {
        openclaw-gateway = {
          Unit = {
            After = [
              "agenix.service"
              "network-online.target"
            ];
            Wants = [
              "agenix.service"
              "network-online.target"
            ];
          };
          Service = {
            EnvironmentFile = [
              config.age.secrets."users/${username}/openclaw/config.env".path
            ];
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };
      };
    };
  };
}

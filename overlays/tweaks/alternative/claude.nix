_: _: prev: {
  claude-code = prev.symlinkJoin {
    name = "claude-code-wrapper";
    paths = [ prev.repos.unstable.claude-code ];

    buildInputs = [ prev.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/claude --add-flags "--allow-dangerously-skip-permissions"
    '';
  };
}

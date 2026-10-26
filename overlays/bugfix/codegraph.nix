_: _: prev: {
  # unstable 的 patchelf 0.19.2 重写 INTERP 时会把首个 LOAD 段挪成
  # offset 0、size 覆盖整个头部的畸形布局，ld.so 加载即段错误
  # （"fatal error" / core dumped）。用 release stdenv（patchelf 0.15.2）构建。
  codegraph = prev.codegraph.override { stdenv = prev.stdenv; };
}

_: {
  programs.uv = {
    enable = true;

    settings = {
      pip = {
        index-url = "https://mirror.sjtu.edu.cn/pypi/web/simple";
      };
    };
  };

  programs.pixi = {
    enable = true;

    settings = {
      mirrors = {
        "https://conda.anaconda.org/bioconda" = [
          "https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda"
        ];
        "https://conda.anaconda.org/conda-forge" = [
          "https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge"
        ];
        "https://pypi.org/simple" = [
          "https://mirror.sjtu.edu.cn/pypi/web/simple"
        ];
        "https://files.pythonhosted.org/packages" = [
          "https://mirror.sjtu.edu.cn/pypi-packages"
        ];
      };
    };
  };
}

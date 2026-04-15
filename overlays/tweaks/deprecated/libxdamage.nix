_: final: prev: {
  nur = prev.nur // {
    repos = prev.nur.repos // {
      xddxdd = prev.nur.repos.xddxdd // {
        qq = prev.nur.repos.xddxdd.qq.override {
          xorg = final.xorg // {
            libXdamage = final.libxdamage;
          };
        };
      };
    };
  };
}

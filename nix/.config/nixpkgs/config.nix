{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "clj-dev";
      paths = [
        clojure
        clj-new
      ];
    };
  };
}


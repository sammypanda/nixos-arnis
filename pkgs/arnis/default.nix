{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  glib,
  openssl,
  wayland,
  gdk-pixbuf,
  pango,
  gtk3,
  libsoup_3,
  webkitgtk_4_1,
  wrapGAppsHook4,
}:

rustPlatform.buildRustPackage rec {
  pname = "arnis";
  version = "2.1.3";

  src = fetchFromGitHub {
    owner = "louis-e";
    repo = "arnis";
    tag = "v${version}";
    hash = "sha256-3Gdrgo6j50ieR0E6q0DeKShHbng9sBjBC0hBAPLsnt0=";
  };

  cargoHash = "sha256-w5XFeyZ+1on7ZkCwROZhbKZCVbSxkVzqIe0/yvJzUgQ=";

  nativeBuildInputs = [ 
    pkg-config
    wrapGAppsHook4 
  ];

  buildInputs = [
    glib
    gtk3
    openssl
    wayland
    glib
    gdk-pixbuf
    pango
    gtk3
    libsoup_3
    webkitgtk_4_1
  ];

  # Disable GPU acceleration..
  # - workaround for unresolved nix/tauri bug https://github.com/tauri-apps/tauri/issues/8254
  postFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    wrapProgram "$out/bin/${pname}" \
      --set-default WEBKIT_DISABLE_DMABUF_RENDERER "1"
  '';

  #passthru.shellPath = "/bin/arnis";

  meta = {
    description = "Generate any location from the real world in Minecraft Java Edition with a high level of detail. ";
    homepage = "https://github.com/louis-e/arnis";
    license = lib.licenses.asl20;
    mainProgram = "arnis";
  };
}
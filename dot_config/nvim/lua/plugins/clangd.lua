return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--query-driver=/home/svend/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-*",
        },
      },
    },
  },
}

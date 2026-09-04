return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signcolumn = true, -- Laat de kleuren in de kantlijn zien
    numhl = true, -- Licht het regelnummer zelf ook op (super visueel!)
    linehl = false, -- Licht niet de hele regel op (dat wordt te druk)

    -- Update de status elke 100ms in plaats van de standaard paar seconden
    watch_gitdir = {
      interval = 100,
    },
  },
}

return {
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        -- Zorg dat het pad relatief is aan de root van je project (waar je .git staat)
        -- Als je het liever relatief aan de huidige map wilt, zet dit dan op "current"
        dir_path = "docs/img",

        -- Maak de map automatisch aan als deze nog niet bestaat
        mkdir = true,

        -- Vraag niet om bevestiging van de bestandsnaam, genereer deze automatisch (timestamp)
        use_absolute_path = false,
      },

      -- Specifieke instellingen per filetype
      filetypes = {
        typst = {
          -- Dit sjabloon gebruikt img-clip voor Typst code:
          template = '#image("$FILE_PATH", alt: "$LABEL")',
        },
      },
    },
    keys = {
      -- Sneltoets <leader>pi (Paste Image) om je screenshot direct te plakken
      { "<leader>pi", "<cmd>PasteImage<CR>", desc = "Paste image van klembord" },
    },
  },
}

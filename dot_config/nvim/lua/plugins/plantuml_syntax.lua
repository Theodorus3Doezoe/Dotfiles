return {
  {
    "aklt/plantuml-syntax",
    -- Zorg dat de plugin alleen laadt als je een van deze bestandstypen opent
    ft = { "plantuml", "puml", "markdown" },
    config = function()
      -- Hier kun je eventueel extra opties kwijt,
      -- maar de syntax-highlighting werkt direct out-of-the-box.
    end,
  },
}

-- Autocmds are automatically loaded on the VeryLazy event

-- ── PlantUML ────────────────────────────────────────────────────────────────

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.puml", "*.plantuml" },
  callback = function()
    local file = vim.fn.expand("%:p")
    local outdir = vim.fn.expand("%:p:h")
    vim.fn.jobstart({ "plantuml", "-tpng", "-o", outdir, file }, {
      on_exit = function(_, code)
        if code ~= 0 then
          vim.notify("PlantUML render failed", vim.log.levels.WARN)
        end
      end,
    })
  end,
})

local function plantuml_open(split)
  local png = vim.fn.expand("%:p:h") .. "/" .. vim.fn.expand("%:t:r") .. ".png"
  if vim.fn.filereadable(png) == 0 then
    vim.notify("PlantUML PNG nog niet gevonden, sla eerst op", vim.log.levels.WARN)
    return
  end
  if split then
    vim.cmd("vsplit " .. png)
  else
    vim.cmd("edit " .. png)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "plantuml" },
  callback = function()
    vim.keymap.set("n", "<leader>pu", function()
      plantuml_open(false)
    end, { desc = "PlantUML preview (buffer)", buffer = true })
    vim.keymap.set("n", "<leader>pU", function()
      plantuml_open(true)
    end, { desc = "PlantUML preview (split)", buffer = true })
    vim.keymap.set("n", "<S-CR>", function()
      plantuml_open(true)
    end, { desc = "PlantUML preview (split)", buffer = true })
  end,
})

vim.filetype.add({ extension = { puml = "plantuml" } })

-- ── Typst ────────────────────────────────────────────────────────────────────

local typst_watch_job = nil
local zathura_job = nil

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.typ",
  callback = function()
    if typst_watch_job then
      return
    end
    local file = vim.fn.expand("%:p")
    typst_watch_job = vim.fn.jobstart({ "typst", "watch", file }, {
      on_exit = function()
        typst_watch_job = nil
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  pattern = "*.typ",
  callback = function()
    if typst_watch_job then
      vim.fn.jobstop(typst_watch_job)
      typst_watch_job = nil
    end
  end,
})

local function typst_open_zathura()
  local pdf = vim.fn.expand("%:p:r") .. ".pdf"
  if vim.fn.filereadable(pdf) == 0 then
    vim.notify("Typst PDF nog niet gevonden, wacht even...", vim.log.levels.WARN)
    return
  end
  if zathura_job then
    vim.notify("Zathura al open", vim.log.levels.INFO)
    return
  end
  zathura_job = vim.fn.jobstart({ "zathura", pdf }, {
    detach = true,
    on_exit = function()
      zathura_job = nil
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.keymap.set("n", "<leader>pu", function()
      typst_open_zathura()
    end, { desc = "Typst preview (Zathura)", buffer = true })
    vim.keymap.set("n", "<leader>pU", function()
      local pdf = vim.fn.expand("%:p:r") .. ".pdf"
      vim.cmd("vsplit " .. pdf)
    end, { desc = "Typst preview (buffer split)", buffer = true })
    vim.keymap.set("n", "<S-CR>", function()
      typst_open_zathura()
    end, { desc = "Typst preview (Zathura)", buffer = true })
  end,
})

-- ── PDF ──────────────────────────────────────────────────────────────────────

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    local pdf = vim.fn.expand("%:p")
    vim.fn.jobstart({ "zathura", pdf }, { detach = true })
    vim.schedule(function()
      vim.cmd("bdelete")
    end)
  end,
})

-- Statusline highlight groups
local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })

vim.api.nvim_set_hl(0, "StlMode", {
    fg = pms.fg,
    bg = vis.bg,
})

local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    t = "TERMINAL",
    R = "REPLACE",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",
}

function _G._statusline()
    local mode = modes[vim.fn.mode()] or vim.fn.mode():upper()

    local path = vim.fn.pathshorten(vim.fn.expand("%:~:."))

    local diag = ""

    local counts = vim.diagnostic.count(0) or {}

    local severities = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT,
    }

    local modified = vim.bo.modified and " ● " or ""

    local icons = {
        " ",
        " ",
        " ",
        " ",
    }

    local highlights = {
        "DiagnosticError",
        "DiagnosticWarn",
        "DiagnosticInfo",
        "DiagnosticHint",
    }

    for i, severity in ipairs(severities) do
        local count = counts[severity]

        if count and count > 0 then
            diag = diag
                .. "%#"
                .. highlights[i]
                .. "#"
                .. icons[i]
                .. count
                .. "%* "
        end
    end

    return table.concat({
        "%#StlMode# ",
        mode,
        " %* ",
        path,
        modified,
        "%=",
        diag,
        vim.bo.filetype,
        " %l:%c",
    })
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = function()
        vim.b.rel_path = vim.fn.expand("%:~:.")
        vim.cmd.redrawstatus()
    end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        vim.cmd.redrawstatus()
    end,
})

vim.o.statusline = "%!v:lua._statusline()"

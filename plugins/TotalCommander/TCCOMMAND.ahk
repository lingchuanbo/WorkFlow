
vim.SetWin("TCQuickSearch", "TQUICKSEARCH")
vim.mode("normal", "TCQuickSearch")
        ;重定义以下Sace，让Sace不被禁用   
vim.map("<Space>", "<Space>", "TCQuickSearch")
vim.map("<SP-j>", "<Down>", "TCQuickSearch")
vim.map("<SP-k>", "<Up>", "TCQuickSearch")
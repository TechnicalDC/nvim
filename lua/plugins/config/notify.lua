local miniNotify = require('mini.notify')

miniNotify.setup()

vim.notify = miniNotify.make_notify()

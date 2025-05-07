(local scopes {:g vim.g
               :o vim.o
               :b vim.bo
               :bo vim.bo
               :w vim.wo
               :wo vim.wo
               :opt vim.opt})


(local M {})

(fn M.set_opt [key val scope]
  (tset (. scopes scope) key val))

;; @param options table{[jascha030.core.options.Scope]: table}
(fn M.set_opts [options]
  (each [scope opts (pairs options)]
    (each [o v (pairs opts)]
      (M.set_opt o v scope))))

M

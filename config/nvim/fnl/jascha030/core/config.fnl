(local M {:options {}})

(fn M.defaults []
  "Return the default configuration options."
  {:colorscheme false
   :debug false
   :keymaps {:n {} :v {} :t {} :i {}}
   :opts {:g {:mapleader " "} :opt {} :o {}}
   :path {:env [] :rtp []}
   :polyglot {:enabled false :languages {}}
   :augroups {}})

(fn M.extend [options]
  "Extend the current configuration with the provided options."
  (when (= (type options) :table)
    (set M.options (vim.tbl_deep_extend :force M.options options))))

(fn M.get [key]
  "Get a configuration value by key."
  (or (. M.options key) nil))

(fn M.setup [options]
  "Set up the configuration with the provided options or defaults."
  (let [opts (or options {})]
    (when (= (type opts) :table)
      (set M.options (vim.tbl_deep_extend :force {} (M.defaults) (or opts {}))))))

M

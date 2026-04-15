; Disable markdown injections locally.
;
; Neovim 0.12 hover docs are rendered as markdown buffers, and the pinned
; nvim-treesitter master branch can crash while evaluating markdown injection
; directives for fenced code blocks. An empty override disables injections for
; markdown buffers while keeping normal markdown highlighting.


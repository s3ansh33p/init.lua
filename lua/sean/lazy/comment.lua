return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      padding = true,
      ignore = "^$",
      pre_hook = function()
        if vim.bo.filetype == "java" then
          return "// %s"
        end
      end,
    })
  end
}

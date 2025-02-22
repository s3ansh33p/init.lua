return {
  "L3MON4D3/LuaSnip",
  version = "v2.3.0",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local f = ls.function_node
    local t = ls.text_node
    local i = ls.insert_node
    local c = ls.choice_node

    -- Keybindings for snippet expansion and navigation
    vim.keymap.set({ "i", "s" }, "<C-K>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-J>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-L>", function()
      ls.change_choice(1)
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-H>", function()
      ls.change_choice(-1)
    end, { silent = true })

    ls.add_snippets("java", {
      s("main", {
        t("public class "),
        f(function()
          return vim.fn.expand("%:t:r") -- Gets filename without .java
        end, {}),
        t({
          "",
          "{",
          "    public static void main(String[] args)",
          "    {",
          "        System.out.println(\"Hello, World!\");",
          "    }",
          "}"
        }),
      }),

      -- public / private choice class snippet
      s("test-class", {
        t(""),
        c(1, {
          t("public class "),
          t("private class "),
        }),
      }),

      -- insert current date
      s("date", {
        t(""),
        f(function()
          -- format as 23rd of February 2025
          local day = os.date("%d")
          local month = os.date("%B")
          local year = os.date("%Y")
          local suffix = "th"
          if day % 10 == 1 and day ~= 11 then
            suffix = "st"
          elseif day % 10 == 2 and day ~= 12 then
            suffix = "nd"
          elseif day % 10 == 3 and day ~= 13 then
            suffix = "rd"
          end
          return day .. suffix .. " of " .. month .. " " .. year
        end, {}),
        t(""),
      }),
    })
  end,

}

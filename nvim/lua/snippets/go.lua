local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node

return {
    -- Main function snippet
    s("main", {
        t({"package main", "", "import (", "\t\"fmt\"", ")", "", "func main() {", "\t"}),
        i(0),
        t({"", "}"})
    }),

    -- If statement
    s("if", {
        t("if "),
        i(1, "condition"),
        t({" {", "\t"}),
        i(0),
        t({"", "}"})
    }),

    -- For loop
    s("for", {
        t("for "),
        i(1, "i := 0"),
        t("; "),
        i(2, "i < 10"),
        t("; "),
        i(3, "i++"),
        t({" {", "\t"}),
        i(0),
        t({"", "}"})
    }),

    -- For range loop
    s("forr", {
        t("for "),
        i(1, "_"),
        t(", "),
        i(2, "v"),
        t(" := range "),
        i(3, "items"),
        t({" {", "\t"}),
        i(0),
        t({"", "}"})
    }),

    -- Function
    s("func", {
        t("func "),
        i(1, "name"),
        t("("),
        i(2),
        t(") "),
        i(3),
        t({" {", "\t"}),
        i(0),
        t({"", "}"})
    }),

    -- Print
    s("pr", {
        t("fmt.Println("),
        i(1),
        t(")")
    }),

    -- Printf
    s("prf", {
        t("fmt.Printf(\""),
        i(1, "%v"),
        t("\", "),
        i(2),
        t(")")
    }),

    -- Error handling
    s("iferr", {
        t("if err != nil {"),
        t({"", "\treturn "}),
        i(1, "err"),
        t({"", "}"})
    }),

    -- Struct
    s("st", {
        t("type "),
        i(1, "Name"),
        t({" struct {", "\t"}),
        i(0),
        t({"", "}"})
    }),

    -- Method
    s("meth", {
        t("func ("),
        i(1, "receiver"),
        t(" "),
        i(2, "*Type"),
        t(") "),
        i(3, "MethodName"),
        t("("),
        i(4),
        t(") "),
        i(5),
        t({" {", "\t"}),
        i(0),
        t({"", "}"})
    }),

    -- Test function
    s("test", {
        t("func Test"),
        i(1, "Name"),
        t("(t *testing.T) {"),
        t({"", "\t"}),
        i(0),
        t({"", "}"})
    }),
}



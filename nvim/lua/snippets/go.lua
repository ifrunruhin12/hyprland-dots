print("Loading Go snippets...") 

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("go", {
    s("fastio", {
        t({
            "package main",
            "",
            "import (",
            "\t\"bufio\"",
            "\t\"fmt\"",
            "\t\"os\"",
            "\t\"strconv\"",
            "\t\"strings\"",
            ")",
            "",
            "// Fast input reader",
            "var reader = bufio.NewReader(os.Stdin)",
            "var writer = bufio.NewWriter(os.Stdout)",
            "",
            "func readInt() int {",
            "\tstr, _ := reader.ReadString('\\n')",
            "\tnum, _ := strconv.Atoi(strings.TrimSpace(str))",
            "\treturn num",
            "}",
            "",
            "func readInts() []int {",
            "\tstr, _ := reader.ReadString('\\n')",
            "\tfields := strings.Fields(str)",
            "\tnums := make([]int, len(fields))",
            "\tfor i, f := range fields {",
            "\t\tnums[i], _ = strconv.Atoi(f)",
            "\t}",
            "\treturn nums",
            "}",
            "",
            "func readString() string {",
            "\tstr, _ := reader.ReadString('\\n')",
            "\treturn strings.TrimSpace(str)",
            "}",
            "",
            "func readAB() (int, int) {",
            "\tinput, _ := reader.ReadString('\\n')",
            "\tparts := strings.Fields(strings.TrimSpace(input))",
            "\ta, _ := strconv.Atoi(parts[0])",
            "\tb, _ := strconv.Atoi(parts[1])",
            "\treturn a, b",
            "}",
            "",
            "func main() {",
            "\tdefer writer.Flush() // Ensure all output is written at the end",
            "\t",
        }),
        i(1, "// Your code here"), -- This is an insert point where you can start coding
        t({
            "",
            "}",
        })
    }),

    s("forloop", {
        t("for "), i(1, "i := 0"), t("; "), i(2, "i < 10"), t("; "), i(3, "i++"), t({" {"}),
        t({"", "    "}), i(4, "fmt.Println(i)"),
        t({"", "}"})
    }),

    s("stringtolist", {
        t({
            "package main",
            "",
            "import (",
            "\t\"fmt\"",
            ")",
            "",
            "func stringToList(s string) []string {",
            "\tvar result []string",
            "\tfor _, ch := range s {",
            "\t\tresult = append(result, string(ch))",
            "\t}",
            "\treturn result",
            "}",
            "",
            "func main() {",
            "\t// Example usage",
            "\tfmt.Println(stringToList(\"Hello\"))",
            "}",
        }),
        i(1, "// Your code here")
    })
})



import fs from "fs"
import R from "ramda"

// unfortunately we need a trampoline to keep the call stack flat while going crazy with recursion.
const trampoline = fn => (...args) => {
  let result = fn(...args)
  while (typeof result === "function") result = result()
  return result
}

const handleChar = (stables, char) =>
  R.last(stables).charCodeAt() - char.charCodeAt() |> Math.abs |> R.equals(32)
    ? R.init(stables) // drop pair
    : stables + char // take pair

// moving through the string removing reacting unit types.
// basically we shove one char from toProcess over into stable.
// if the last two chars of `stable` react, they are removed.
const react_ = (stables, toProcess) =>
  toProcess === ""
    ? stables.length
    : () => react_(handleChar(stables, R.head(toProcess)), R.tail(toProcess))

// convenience fn to start processing and handle trampolining
const react = input => trampoline(react_)("", input)

fs.readFileSync("input", "utf8") |> R.trim |> react |> console.log

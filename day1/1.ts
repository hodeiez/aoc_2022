console.log("aoc with deno!!");

const text = await Deno.readTextFile("input1.txt");
const result = [];
const formatted = text
  .split("\r\n")
  .toString()
  .split(" ")
  .toString()
  .split(",,")
  .forEach((e) =>
    result.push(e.split(",").reduce((a, b) => Number(a) + Number(b)))
  );
//1
console.log(Math.max(...result.map((n) => Number(n))));
//2
console.log(
  result
    .map((n) => Number(n))
    .sort((a, b) => a - b)
    .reverse()
    .slice(0, 3)
    .reduce((a, b) => a + b)
);

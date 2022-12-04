import array
import numpy as np

print("hello Python")


def inputArr(file):
    with open(file) as f:
        data = [line.split() for line in list(f)]
        return [[el.split(",") for el in line] for line in data]


def format(el):
    l = np.array(el)
    first = l[0].flatten()[0].split("-")
    second = l[0].flatten()[1].split("-")
    firstA, firstB = int(first[0]), int(first[1])
    secondA, secondB = int(second[0]), int(second[1])
    return firstA, firstB, secondA, secondB


def getRanges(firstA, firstB, secondA, secondB):
    firstRange = list(range(firstA, firstB+1))
    secondRange = list(list(range(secondA, secondB+1)))
    return firstRange, secondRange


def evaluatePart2(firstRange, secondRange):
    return int(len(np.intersect1d(firstRange, secondRange)) != 0)


def evaluatePart1(firstA, firstB, secondA, secondB):
    return int((firstA <= secondA and firstB >= secondB) or (secondA <= firstA and secondB >= firstB))


scorePart1 = 0
scorePart2 = 0

for i in inputArr("input.txt"):
    firstA, firstB, secondA, secondB = format(i)
    scorePart1 += evaluatePart1(firstA, firstB, secondA, secondB)
    firstRange, secondRange = getRanges(firstA, firstB, secondA, secondB)
    scorePart2 += (evaluatePart2(firstRange, secondRange))


print(scorePart1)
print(scorePart2)

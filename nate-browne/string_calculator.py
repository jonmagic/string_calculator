#!/usr/bin/env python3
import re
from pytest import raises

def add(numbers: str) -> int:

    delimiter = ','
    # matches the pattern //<delimiter>\n<numbers we wanna parse>
    matches = re.match(r'//(.*)\n(.*)', numbers)

    # if we have a new delimiter, find it
    if matches:
        delimiter = matches.group(1)
        numbers = matches.group(2)
    else:
        # replace newlines with delimiters to make it easier to parse
        numbers = re.sub('\n', delimiter, numbers)

    # convert our string to a list of delimiter-separated strings
    nums = numbers.split(delimiter)

    # This list comprehension is a bit more pythonic than using `map`
    nums = [int(x) for x in nums if int(x) <= 1_000]

    # Check for negative numbers
    negs = [x for x in nums if x < 0]
    if len(negs):
        raise ValueError(f"Negative numbers passed in: {negs}")

    return sum(nums)


def main():
    # import pdb; pdb.set_trace() # debugging
    assert add("1,34") == 35
    assert add("1,2,3,4,5") == 15
    assert add("1\n2,3") == 6
    assert add("//;\n1;2;3") == 6
    assert add("//kevinbacon\n1kevinbacon2kevinbacon3") == 6

    # check for exception being raised
    with raises(ValueError):
        assert add("1,2,3,-4,5") == 7

    # numbers over 1000 ignored not including 1000
    assert add("1,2,3,1001") == 6
    assert add("1,2,3,1000") == 1006

    print("All tests pass!")


if __name__ == "__main__":
    main()

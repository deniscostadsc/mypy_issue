from typing import List, Optional


def foo(numbers: List[Optional[int]]) -> List[Optional[int]]:
    for index, number in enumerate(numbers):
        if isinstance(numbers[index], int) and numbers[index] > 2:
            pass
    return numbers

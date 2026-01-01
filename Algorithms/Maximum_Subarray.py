# Problem: Maximum Subarray (Divide-and-Conquer, CLRS Chapter 4, Problem 4.1)
# Brute Force – check all possible subarrays (O(n²)).
# Divide-and-Conquer (CLRS) – recursively find max subarray in left, right, or crossing middle (O(n log n)).
# Kadane’s Algorithm – dynamic programming (O(n)).

def max_crossing_subarray(arr, low, mid, high):
    # Left half
    left_sum = float("-inf")
    sum_ = 0
    max_left = mid
    for i in range(mid, low - 1, -1):
        sum_ += arr[i]
        if sum_ > left_sum:
            left_sum = sum_
            max_left = i

    # Right half
    right_sum = float("-inf")
    sum_ = 0
    max_right = mid + 1
    for j in range(mid + 1, high + 1):
        sum_ += arr[j]
        if sum_ > right_sum:
            right_sum = sum_
            max_right = j

    return (max_left, max_right, left_sum + right_sum)


def max_subarray(arr, low, high):
    if low == high:  # base case
        return (low, high, arr[low])

    mid = (low + high) // 2

    left_low, left_high, left_sum = max_subarray(arr, low, mid)
    right_low, right_high, right_sum = max_subarray(arr, mid + 1, high)
    cross_low, cross_high, cross_sum = max_crossing_subarray(arr, low, mid, high)

    if left_sum >= right_sum and left_sum >= cross_sum:
        return (left_low, left_high, left_sum)
    elif right_sum >= left_sum and right_sum >= cross_sum:
        return (right_low, right_high, right_sum)
    else:
        return (cross_low, cross_high, cross_sum)


# Example usage
arr = [13, -3, -25, 20, -3, -16, -23,
       18, 20, -7, 12, -5, -22, 15, -4, 7]

low, high, maximum_sum = max_subarray(arr, 0, len(arr) - 1)
print(f"Maximum subarray is arr[{low}:{high+1}] = {arr[low:high+1]}")
print(f"Maximum sum = {maximum_sum}")

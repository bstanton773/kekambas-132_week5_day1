# Given an array nums, write a function to move all 0's to the end of it 
# while maintaining the relative order of the non-zero elements.
# Example:
# Input: [0,1,0,3,12]
# Output: [1,3,12,0,0]
# Example Input: [0,0,11,2,3,4]
# Example Output: [11,2,3,4,0,0]

def solution(list_): # O(n*n)
    zeros = 0 # O(1)
    while 0 in list_: # O(n)
        list_.remove(0) # O(n)
        zeros += 1 # O(1)
    list_ = list_ + ([0] * zeros) # O(n)
    return list_ # O(1)


def solution(nums):
    output = []
    zero_count = 0
    for num in nums:
        if num == 0:
            zero_count += 1
        else:
            output.append(num)
    for _ in range(zero_count):
        output.append(0)
    return output

def solution(nums):
    nums.sort(key=lambda num: 0 if num else 1)
    return nums

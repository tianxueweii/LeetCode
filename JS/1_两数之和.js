/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
let twoSum = function(nums, target) {
    let result = [];
    for (let i = 0; i < nums.length; i++) {
        let expected = target - nums[i];
        if (result[expected] != undefined) {
            return [result[expected], i];
        }
        result[nums[i]] = i;
    }
    return null;
};
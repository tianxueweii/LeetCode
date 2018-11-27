/**
 * @param {number[]} nums
 * @return {number}
 */
var singleNumber = function(nums) {
    let ans = 0;
    //异或所有值
    nums.forEach(ele => {
        ans ^= ele;
    });
    return ans;
};
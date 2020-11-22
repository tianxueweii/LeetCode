/**
 * @param {number[]} A
 * @return {number[]}
 */
var sortArrayByParity = function(A) {
    let evenArr = [];
    let oddArr = [];
    for (let i = 0; i < A.length; i++)
    {
        if (A[i] % 2 == 0) {
            evenArr.push(A[i]);
        } else {
            oddArr.push(A[i]);
        }
    }
    return evenArr.concat(oddArr);
};
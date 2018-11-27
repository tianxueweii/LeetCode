/**
 * @param {number} numRows
 * @return {number[][]}
 */
var generate = function(numRows) {
    let ansArr = new Array();
    for (let i = 0; i < numRows; i++) {
        ansArr[i] = new Array();
        for (let j = 0; j < i + 1; j++) {
            if (j == 0 || j == i) {
                ansArr[i][j] = 1;
            } else {
                ansArr[i][j] = ansArr[i - 1][j - 1] + ansArr[i - 1][j];
            }
        }
    }
    return ansArr;
};
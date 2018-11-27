/**
 * @param {number[][]} matrix
 * @return {boolean}
 */
var isToeplitzMatrix = function(matrix) {
    let column = matrix.length;
    let row = matrix[0].length;
    for (let i = 0; i < column; i++) {
        for (let j = 0; j < row; j++) {
            if (i + 1 < column && j + 1 < row && matrix[i][j] != matrix[i+1][j+1]) {
                return false;
            }
        }
    }
    return true;
};
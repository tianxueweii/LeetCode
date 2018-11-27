/**
 * @param {number[][]} A
 * @return {number[][]}
 */
var transpose = function(A) {
    if (!A) return A;
    let vLength = A.length;
    let hLength = A[0].length;
    let ansA = new Array();
    for (let i = 0;i < hLength; i++) {
        ansA[i] = new Array();
        for (let j = 0; j < vLength; j++) {
            ansA[i][j] = A[j][i];
        }
    }
    return ansA;
};
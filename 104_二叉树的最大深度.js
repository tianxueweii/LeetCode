/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number}
 */

var maxDepth = function(root) {
    var depth = 0;
    if (root.val == undefined) return depth;
    var leftDepth = maxDepth(root.left);
    var rightDepth = maxDepth(root.right);
    return Math.max(leftDepth, rightDepth) + 1;
};
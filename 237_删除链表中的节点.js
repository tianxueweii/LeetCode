/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} node
 * @return {void} Do not return anything, modify node in-place instead.
 */
function ListNode(val) {
    this.val = val;
    this.next = null;
}

var deleteNode = function(node) {
    node.val = node.next.val;
    node.next = node.next.next;
};


// console.log(deleteNode(5));
var node = deleteNode(5);
console.log(node.val);
console.log(node.next.val);
console.log(node.next.next.val);
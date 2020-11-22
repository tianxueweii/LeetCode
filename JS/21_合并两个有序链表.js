/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var mergeTwoLists = function(l1, l2) {
    if (l1 == null) {
        return l2;
    } else if (l2 == null) {
        return l1;
    }
    
    var node = null;
    
    if (l1.val < l2.val) {
        node = l1;
        node.next = mergeTwoLists(l1.next, l2);
    } else {
        node = l2;
        node.next = mergeTwoLists(l1, l2.next);
    }
    
    return node;
};
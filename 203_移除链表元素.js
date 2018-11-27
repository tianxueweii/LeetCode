/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} val
 * @return {ListNode}
 */
var removeElements = function(head, val) {
    if (!head) return head;
    if (head.val === val) return removeElements(head.next, val);
    var node = head;
    while (node.next) {
        if (node.next.val === val) {
            //检查不通过，删除下一个节点
            node.next = node.next.next;
        } else {
            //检查通过，下一个~
            node = node.next;
        }
    }
    
    return head;
};
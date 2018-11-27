/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @return {ListNode}
 */
var deleteDuplicates = function(head) {
    let node = head;
    while (node && node.next) {
        if (node.val === node.next.val) {
            //一样，跳一个节点
            node.next = node.next.next
        } else {
            //不一样，下一个节点
            node = node.next;
        }
    }
    return head;
};
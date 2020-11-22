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
var reverseList = function(head) {
    
    if (head == null || head.next == null) {
        return head;
    }
    
    var p = head;
    var ans = null;
    
    while (p != null) {
        var tmp = p.next;
        p.next = ans;
        ans = p;
        p = tmp;
    }
    
    return ans;
};
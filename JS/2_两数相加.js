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

function ListNode(val) {
    this.val = val;
    this.next = null;
}

var addTwoNumbers = function(l1, l2) {
   var lr = new ListNode();
   var firstNode = lr;
   var carryFlag = 0;

   do {
       var ele1, ele2, mod;
       //判断是否空表，空表则ele赋值为0
       if (l1) {
           ele1 = l1.val;
       } else {
           ele1 = 0;
       }
       if (l2) {
           ele2 = l2.val;
       } else {
           ele2 = 0;
       }

       var sum = ele1 + ele2;
       mod = sum >= 10 ? sum - 10 : sum;
       lr.val = mod + carryFlag;
       carryFlag = sum >= 10 ? 1 : 0;

       l1 = l1 ? l1.next : null;
       l2 = l2 ? l2.next : null;

       if (l1 || l2 || carryFlag) {
        lr.next = new ListNode();
        lr = lr.next;
       }
       
   } while (l1 || l2 || carryFlag);
   return firstNode;
};

console.log(Math.max(1, 2));
import UIKit

var data = [10,1,3,12,122,21]

///快排
/**这里只能传入变量，不能传入常量和字面量 当我们传入的时候 **/
/**在变量名字前面用&符号修饰表示，传递给inout参数，表明这个变量在参数内部是可以被改变的**/
/**注意这里inout的位置**/

var counts = 0
func quickSortdataArray(sortArray:inout[Int],starIndex:Int, endIndex:Int) ->(){
    //加个判断
    if (starIndex >= endIndex) {
        
        return
    }
    
    var  i = starIndex
    var  j = endIndex
    
    //基准值
    let pointvalue = sortArray[i]
    while(i < j){
        
        // 从右边开始找，要是找到右边有比这一个pointvalue小的，交换他们俩的位置
        // 下面的循环，当找到(右边有比基准值小)sortArray[j]< pointvalue的时候结束
        while (i < j && sortArray[j] >= pointvalue) {
            j -= 1
        }
        
        // 能走到这里说明上面的循环结束了，也就是找到sortArray[j]< pointvalue，这里就交换两个的值
        sortArray[i] = sortArray[j]
        
        // 第二步，从左边开始找，此时是i增加，当找到sortArray[i] >  pointvalue 交换他们的位置
        while (i < j && sortArray[i] <= pointvalue) {
            
            i += 1
        }
        
        sortArray[j] = sortArray[i]
        //记录交换次数
        //counts += 1
    }
    
    //每一次排序比较完成后基准数的位置，按这个位置切分数组。
    sortArray[i] = pointvalue
    /**下面要用到递归的思想，按照这个基点为界点把数组分开操作，方法还是按照上面的方法**/
    /**基准书的位置也就从0开始变化，1、2、3、4...一直到最后、第一次分离的左边一段的是一个数值，第二次就会变两个，一直到最大 **/
    
    /** 左边的一段**/
   quickSortdataArray(sortArray: &sortArray,starIndex: starIndex,endIndex: i-1)
    
    /** 右边的一段**/
    quickSortdataArray(sortArray: &sortArray,starIndex: i+1,endIndex: endIndex)
}

quickSortdataArray(sortArray: &data, starIndex: 0, endIndex: data.count - 1 )
counts

///插入排序
func insertionSort(){
    var counts = 0
    var temp = 0
   // 循环从1开始, 因为第一个元素开始(下标为0)，该元素可以认为已经被排序；
    for i in 1 ..< data.count {
        //取出下一个元素，在已经排序的元素序列中从后向前扫描；
        temp = data[i]
       var j=i-1
        //如果该元素（已排序）大于新元素，将该元素移到下一位置；
        while j >= 0 && temp < data[j] {
            data[j + 1] = data[j]
            j -= 1
            counts += 1
        }
        //将新元素插入到该位置后；
        data[j+1] = temp
    }
    print(data)
    print(counts)
}
insertionSort()

///选择排序
func selectionSort(){
    var counts = 0
    var temp = 0
    for i in 0 ..< data.count{
        var minIndex = i
        
        //找到无序区域的最小值,并记录下标
        for j in i ..< data.count {
            if data[j] < data[minIndex] {
                minIndex = j
            }
            counts += 1
        }
        //将无序区域中的最小值和当前下标的值交换,那么当前下标之前的元素即为有序数组
        temp = data[i]
        data[i] = data[minIndex]
        data[minIndex] = temp
    }
    print(data)
    print(counts)
}
selectionSort()

///冒泡排序================
/** 优化之后的冒泡排序
 设置一标志性变量pos,用于记录每趟排序中最后一次进行交换的位置。由于pos位置之后的记录均已交换到位,故在进行下一趟排序时只要扫描到pos位置即可。
 */
func bubbleSort1(){
    var counts = 0
    var i = data.count - 1
    while i > 0 {
        var pos = 0//每趟开始将交换位置设为0
        for j in 0 ..< i {
            let before = data[j]
            let after = data[j+1]
            if before > after {
                data[j] = after
                data[j+1] = before
                pos = j//记录下每趟交换的位置
            }
            i = pos//记录本次循环的最后一次交换的位置, 那么此位置后的已经排好序, 下一趟就不用排此位置之后的元素
            counts += 1
        }
    }
    print(data)
    print(counts)
}

bubbleSort1()

/*
1. 比较相邻的元素。如果第一个比第二个大，就交换它们两个；
2. 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对，这样在最后的元素应该会是最大的数；
3. 针对所有的元素重复以上的步骤，除了最后一个；
4. 重复步骤1~3，直到排序完成。
 */
func bubbleSort(){
    var counts = 0
    for i in 0 ..< data.count {
        for j in 0 ..< data.count - i - 1 {
            let before = data[j]
            let after = data[j+1]
            if before > after {
                data[j] = after
                data[j+1] = before
            }
            counts += 1
        }
    }
    print(data)
    print(counts)
}
bubbleSort()


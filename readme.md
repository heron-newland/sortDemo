


排序的定义很简单: 对一序列对象根据某个关键字进行排序. 再讲的形象点就是排排坐，调座位，高的站在后面，矮的站在前面咯。

但是排序算法博大精深，前辈们用了数年甚至一辈子的心血研究出来的算法更值得我们推敲。站在十大算法的门前心里还是诚惶诚恐的


对于评述算法优劣术语的说明

* 稳定：如果a原本在b前面，而a=b，排序之后a仍然在b的前面；

 
* 不稳定：如果a原本在b的前面，而a=b，排序之后a可能会出现在b的后面；

* 内排序：所有排序操作都在内存中完成； 
* 外排序：由于数据太大，因此把数据放在磁盘中，而排序通过磁盘和内存的数据传输才能进行；

* 时间复杂度: 一个算法执行所耗费的时间。 
* 空间复杂度: 运行完一个程序所需内存的大小。


![](https://github.com/heron-newland/sortDemo/blob/master/sort/sortEfficient.png)

图片名词解释： n: 数据规模 k:“桶”的个数 In-place: 占用常数内存，不占用额外内存 Out-place: 占用额外内存


### 1.冒泡排序（Bubble Sort）

>冒泡排序对于它每个学过C语言的都会了解的吧，这可能是很多人接触的第一个排序算法。

#### (1)算法描述

冒泡排序是一种简单的排序算法。它重复地走访过要排序的数列，一次比较两个元素，如果它们的顺序错误就把它们交换过来。走访数列的工作是重复地进行直到没有再需要交换，也就是说该数列已经排序完成。这个算法的名字由来是因为越小的元素会经由交换慢慢“浮”到数列的顶端。

#### (2)算法描述和实现

具体算法描述如下：

1. 比较相邻的元素。如果第一个比第二个大，就交换它们两个；
2. 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对，这样在最后的元素应该会是最大的数；
3. 针对所有的元素重复以上的步骤，除了最后一个；
4. 重复步骤1~3，直到排序完成。

#### (3)图解

![](https://github.com/heron-newland/sortDemo/blob/master/sort/bubble.gif)


基本实现代码:
-

	func bubbleSort(){
	    var counts = 0//记录排序总次数
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




 优化之后的冒泡排序: 
 
 设置一标志性变量pos,用于记录每趟排序中最后一次进行交换的位置。由于pos位置之后的记录均已交换到位,故在进行下一趟排序时只要扫描到pos位置即可。
 
-
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


### 2.选择排序（Selection Sort）

>表现最稳定的排序算法之一(这个稳定不是指算法层面上的稳定哈，相信聪明的你能明白我说的意思2333)，因为无论什么数据进去都是O(n²)的时间复杂度…..所以用到它的时候，数据规模越小越好。唯一的好处可能就是不占用额外的内存空间了吧。理论上讲，选择排序可能也是平时排序一般人想到的最多的排序方法了吧。

#### (1)算法简介

选择排序(Selection-sort)是一种简单直观的排序算法。它的工作原理：首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置，然后，再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。以此类推，直到所有元素均排序完毕。

#### (2)算法描述和实现

n个记录的直接选择排序可经过n-1趟直接选择排序得到有序结果。具体算法描述如下：

1. 初始状态：无序区为R[1..n]，有序区为空；
2. 第i趟排序(i=1,2,3…n-1)开始时，当前有序区和无序区分别为R(0..<i)和N(i..<n）。该趟排序从当前无序区N中-选出关键字最小的记录 N[min]，将它与无序区的第1个记录N[i]交换，使R(0..<i + 1)和R[i+1..<n)分别变为记录个数增加1个的新有序区R和记录个数减少1个的新无序区N；
3. n-1趟结束，数组有序化了。

主要特点: 

1. 有序区域和无序区域
2. 每次在无序区域中找到最小值, 将其放在有序区域的最后一位.
3. 有序区域不断增加, 无序区域逐渐减小, 无序区域元素为0

#### (3)图解

![](https://github.com/heron-newland/sortDemo/blob/master/sort/selection.gif)

-
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
		
		
### 3.插入排序（Insertion Sort）

>插入排序的代码实现虽然没有冒泡排序和选择排序那么简单粗暴，但它的原理应该是最容易理解的了，因为只要打过**扑克牌**的人都应该能够秒懂。当然，如果你说你打扑克牌摸牌的时候从来不按牌的大小整理牌，那估计这辈子你对插入排序的算法都不会产生任何兴趣了

#### (1)算法简介

插入排序（Insertion-Sort）的算法描述是一种简单直观的排序算法。它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。插入排序在实现上，通常采用in-place排序（即只需用到O(1)的额外空间的排序），因而在从后向前扫描过程中，需要反复把已排序元素逐步向后挪位，为最新元素提供插入空间。

#### (2)算法描述和实现

一般来说，插入排序都采用in-place在数组上实现。具体算法描述如下：

1. 从第一个元素开始，该元素可以认为已经被排序；
2. 取出下一个元素，在已经排序的元素序列中从后向前扫描；
3. 如果该元素（已排序）大于新元素，将该元素移到下一位置；
4. 重复步骤3，直到找到已排序的元素小于或者等于新元素的位置；
5. 将新元素插入到该位置后；
6. 重复步骤2~5。

#### (3)图解

![](https://github.com/heron-newland/sortDemo/blob/master/sort/insertion.gif)

-
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
	
### 4.快速排序（Quick Sort）

>快速排序的名字起的是简单粗暴，因为一听到这个名字你就知道它存在的意义，就是快，而且效率高! 它是处理大数据最快的排序算法之一了。

#### (1)算法简介

快速排序的基本思想：通过一趟排序将待排记录分隔成独立的两部分，其中一部分记录的关键字均比另一部分的关键字小，则可分别对这两部分记录继续进行排序，以达到整个序列有序。

#### (2)算法描述和实现

快速排序使用分治法来把一个串（list）分为两个子串（sub-lists）。具体算法描述如下：

1. 从数列中挑出一个元素，称为 "基准"（pivot）；
2. 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分区退出之后，该基准就处于数列的中间位置。这个称为分区（partition）操作；
3. 递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。

#### (3)图解

![]({{site.url}}/assets/images/sort/quick.gif)

-

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
# **Animation with Queue**

Animation kết hợp với Queue để hoạt hình đa cảnh trong UIView.Ở bài này mình muốn dễ quản lý cũng như để dễ tái sử dụng thì mình chia ra 3 class nhỏ:

* Cấu trúc của queue để thêm vào từng hoạt cảnh hoạt hình, mà không ảnh hưởng tiến trình hoạt hình
* Class quản lý những hoạt cảnh và Timer của nó
* Extension của UIView cho phép lập trình viên hoạt hình có thể thực hiện trên bất kỳ đối tượng kiểu UIView mà không 

## **Cấu trúc của Queue**

```Swift
public struct Queue<T> {
    fileprivate var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }

    public var front: T? {
        return array.first
    }
}
```

## Tạo 1 lớp để lưu trữ các hành động mà muốn hoạt cảnh và timer của nó

```Swift
class AnimateItem: NSObject {

    //Mark:: Property
    var item : AnyObject
    var animateTime : CGFloat

    init(item : AnyObject , time : CGFloat) {
        self.item = item
        self.animateTime = time

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```





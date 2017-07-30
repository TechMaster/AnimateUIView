# **Animation with Queue**

Animation kết hợp với Queue để hoạt hình đa cảnh trong UIView.Ở bài này mình muốn dễ quản lý cũng như để dễ tái sử dụng thì mình chia ra 3 class nhỏ:

* Cấu trúc của queue để thêm vào từng hoạt cảnh hoạt hình, mà không ảnh hưởng tiến trình hoạt hình
* Class quản lý những hoạt cảnh và Timer của nó
* Extension của UIView cho phép lập trình viên hoạt hình có thể thực hiện trên bất kỳ đối tượng kiểu UIView mà không 

## Cấu trúc của Queue
Tại sao dùng Queue mà không phải Array? Giả sử nếu chúng ta dùng Array để lưu danh sách các hoạt hình, khi đối tượng UIView trong quá trình hoạt hình việc bổ xung thêm phần tử mảng sẽ khiến cho biến count đếm số phần tử mảng thay đổi. Nếu không kiểm tra liên tục biến count, ứng dụng chạy không còn đúng nữa.

Dùng Queue, thì việc bổ xung thêm phần tử trong quá trình chạy thoải mái. Nó hoạt động đúng như một hàng đợi, tác vụ hoạt hình mới sẽ xếp hàng để chờ chạy khi đến lượt.

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

## AnimateItem llưu trữ các hành động mà muốn hoạt cảnh và thời gian hoạt hình

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


## Mở rộng UIView bằng kỹ thuật extension
Nếu tạo một subclass kế thừa UIView để hoạt hình thì đây không phải cách hay. Bởi có những class đã kế thừa UIView rồi như UIImage, UILabel... thì không thể kế thừa một lần nữa. Cách tốt nhất là mở rộng UIView, mà không kế thừa.

Vấn đề khi mở rộng UIView khi dùng extension là Swift extension không cho phép chứa thuộc tính lưu trữ (storage property) mà chỉ cho phép thuộc tính tính toán (computed property). Trong khi đó chúng ta cần lưu biến Queue các hoạt cảnh vào UIView extension.

Tham khảo bài viết này [hướng dẫn cách để thêm storage property vào ](https://medium.com/@ttikitu/swift-extensions-can-add-stored-properties-92db66bce6cd)

Đây là cách chúng ta dùng objc_getAssociatedObject và objc_setAssociatedObject để gắn một computed property vào đối tượng mở rộng UIView extension, từ đó biết computed property thành storage property. Trình biên dịch không báo lỗi, chúng ta đạt được mục tiêu đề ra.
```swift
extension UIView {
    
    var animatingQueue: Queue<AnimateItem> {
        get {
            if let associated = objc_getAssociatedObject(self, &queueKey)
                as? Queue<AnimateItem> { return associated }
            
            let associated = Queue<AnimateItem>()
            
            objc_setAssociatedObject(self, &queueKey, associated,
                                     .OBJC_ASSOCIATION_RETAIN)
            return associated
            
        }
        set {
            objc_setAssociatedObject(self, &queueKey, newValue,
                                     .OBJC_ASSOCIATION_RETAIN)
        }
    }
```
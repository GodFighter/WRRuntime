# WRRuntime
Swift Runtime交换方法
### 只能交换class对象的方法，并且在方法前需要添加 *dynamic* 关键字

遵守 *WRRuntimeProtocol* 并实现

```Swift
// 第一个方法为原方法
// 第二个为替换方法
static var wr_swizzleMethods: [(Selector, Selector)] {get set}
```

例子

```Swift

class Dog: WRRuntimeProtocol {    
    public static var wr_swizzleMethods = [(#selector(eating), #selector(eatUp))]

    @objc dynamic func eating() {
        print("dog is eating")
    }

    @objc dynamic func eatUp() {
        print("dog is eat up")
    }
}

```

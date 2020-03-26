# WRRuntime
Swift Runtime交换方法
### 只能交换class方法，并且在方法前需要添加 *dynamic* 关键字

遵守 *WRRuntimeProtocol* 并实现

```Swift
// 第一个方法为原方法
// 第二个为替换方法
static var wr_swizzleMethods: [(Selector, Selector)] {get set}
```

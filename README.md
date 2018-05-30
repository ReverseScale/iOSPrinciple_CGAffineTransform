# iOSPrinciple_CGAffineTransform
Principle CGAffineTransform

> A structure for holding an affine transformation matrix.

CGAffineTransform 是一个用于处理形变的类,其可以改变控件的平移、缩放、旋转等,其坐标系统采用的是二维坐标系,即向右为x轴正方向,向下为y轴正方向。

![](http://og1yl0w9z.bkt.clouddn.com/18-5-30/85092855.jpg)

这个矩阵和坐标之间的关系如下：

```objc
struct CGAffineTransform { CGFloat a; CGFloat b; CGFloat c; CGFloat d; CGFloat tx; CGFloat ty; }; 
typedef struct CGAffineTransform CGAffineTransform;
```

![](http://og1yl0w9z.bkt.clouddn.com/18-5-30/27031911.jpg)

我们通过 UIImageView 的 transform 方法演示这一特性，注意默认情况下 UIImageView 的 User Interaction 为不可交互状态，需要设置一下：

![](http://og1yl0w9z.bkt.clouddn.com/18-5-30/91472478.jpg)

---

### 方法介绍
* CGAffineTransformMakeTranslation

CGAffineTransformMakeTranslation 实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位。

```objc
CGAffineTransform transform = CGAffineTransformMakeTranslation(-100, 150);
imageView.transform = transform;
```
* CGAffineTransformMakeScale

CGAffineTransformMakeScale 实现以初始位置为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍

```objc
CGAffineTransform transform = CGAffineTransformMakeScale(2, 2);
imageView.transform = transform;
```
* CGAffineTransformMakeRotation

CGAffineTransformMakeRotation 实现以初始位置为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)

```objc
CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
imageView.transform = transform;
```
* CGAffineTransformTranslate

CGAffineTransformTranslate 实现以一个已经存在的形变为基准,在x轴方向上平移x单位,在y轴方向上平移y单位

```objc 
CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
imageView.transform = CGAffineTransformTranslate(transform, 50, 50);
``` 
* CGAffineTransformScale
CGAffineTransformScale 实现以一个已经存在的形变为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍

```objc
CGAffineTransform transform = CGAffineTransformMakeScale(2, 0.5);
imageView.transform = CGAffineTransformScale(transform, 2, 1);
``` 

* CGAffineTransformRotate
CGAffineTransformRotate 实现以一个已经存在的形变为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)

```objc
CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI*0.25);
imageView.transform = CGAffineTransformRotate(transform, M_PI*0.25);
```

* CGAffineTransformIdentity
transform属性默认值为CGAffineTransformIdentity,可以在形变之后设置该值以还原到最初状态

```objc
imageView.transform = CGAffineTransformIdentity;
```

---

### CGAffineTransform原理

CGAffineTransform形变是通过"仿射变换矩阵"来控制的

* 平移是矩阵相加
* 旋转与缩放则是矩阵相乘

为了合并矩阵运算中的加法和乘法,引入了齐次坐标的概念。

> 齐次坐标提供了用矩阵运算把二维、三维甚至高维空间中的一个点集从一个坐标系变换到另一个坐标系的有效方法.

CGAffineTransform形变就是把二维形变使用一个三维矩阵来表示,其中第三列总是(0,0,1),形变通过前两列来控制,系统提供了CGAffineTransformMake结构体来控制形变。

```objc
CGAffineTransformMake(CGFloat a, CGFloat b, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty)
```

三维变换矩阵如下

![](http://og1yl0w9z.bkt.clouddn.com/18-5-30/95249451.jpg)

变换矩阵左乘向量,将空间中的一个点集从一个坐标系变换到另一个坐标系中,计算方式如下

![](http://og1yl0w9z.bkt.clouddn.com/18-5-30/36168475.jpg)

计算结果

![](http://og1yl0w9z.bkt.clouddn.com/18-5-30/60563219.jpg)

由上可知：
* tx用来控制在x轴方向上的平移
* ty用来控制在y轴方向上的平移
* a用来控制在x轴方向上的缩放
* d用来控制在y轴方向上的缩放
* abcd共同控制旋转

对应的代码实现：

1）平移CGAffineTransformMakeTranslation原理
```objc
self.demoImageView.transform = CGAffineTransformMakeTranslation(100, 100);
self.demoImageView.transform = CGAffineTransformMake(1, 0, 0, 1, 100, 100);
```

2）缩放CGAffineTransformMakeScale原理
```objc
self.demoImageView.transform = CGAffineTransformMakeScale(2, 0.5);
self.demoImageView.transform = CGAffineTransformMake(2, 0, 0, 0.5, 0, 0);
```

3）旋转CGAffineTransformMakeRotation原理
```objc
self.demoImageView.transform = CGAffineTransformMakeRotation(M_PI*0.5);
self.demoImageView.transform = CGAffineTransformMake(cos(M_PI * 0.5), sin(M_PI * 0.5), -sin(M_PI * 0.5), cos(M_PI * 0.5), 0, 0);
```

4）初始状态CGAffineTransformIdentity原理
```objc
self.demoImageView.transform = CGAffineTransformIdentity;
self.demoImageView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
```

> 以上文章整理自：https://www.jianshu.com/p/ca7f9bc62429

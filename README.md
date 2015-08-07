# TAHelpMasker
![image](https://github.com/jiaopen/TAHelpMasker/blob/master/screenshot.gif)

页面上增加一个蒙版用来显示当前页面的新功能引导，支持三种方式

1.默认方式：所有屏幕尺寸用同一张蒙版图片，直接在StoryBoard添加maskImageName属性即可
2.多图兼容方式：根据不同屏幕设置不同的图片，初始化maskDictionary这个属性即可：
```Objective-C
self.maskDictionary = @{@"4.0": @"user_home_guideview@2x.png",
                        @"4.7": @"user_home_guideview750.png",
                        @"5.5": @"user_home_guideview@3x.png",};
```

3.手动显示mask：displayMaskWhenViewDidAppear属性默认为YES，在进入页面自动显示mask，displayMaskWhenViewDidAppear设置为NO则关闭自动显示，可手动调用displayMask方法显示.
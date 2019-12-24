### 集成lottie动画自定义tabBar

在当今一个APP想要脱颖而出必须在用户体验上足够出色，而APP用户界面动画就能极大地提升用户体验流畅感和交互感，Airbnb开源的Lottie，可以让开发者免去写一行一行的代码而非常容易地渲染动画。你可以直接把 Adobe After Effects的动画用在你的Xcode 项目中。并且Android、macOS、React Native都可使用。

1. 开发成本低。设计师导出 json 文件后，扔给开发即可，跨平台。
2. iOS、安卓平台可以使用一套文件
3. 可以替代原来需要使用帧图完成的动画

![](/Users/letong/Desktop/MD/lottie.png)

```
<!--开始-->
NSArray *nameArray = @[@"huiyuan",@"fangzi",@"dingdan",@"wode"];
LOTAnimationView *LOTView = [LOTAnimationView animationNamed:nameArray[i]];
LOTView.contentMode = UIViewContentModeScaleAspectFill;
if (LOTView.animationProgress == 0 ) {
[LOTView playToProgress:0.5 withCompletion:^(BOOL animationFinished) {
NSLog(@"pressButtonAction isSelected animation");

}];
}

<!--停止-->
LOTAnimationView *LOTView = [self viewWithTag:(sender.tag + 100)];
for (LOTAnimationView *view in self.subviews) {
if ([view isKindOfClass:[LOTAnimationView class]]) {
[view stop];
}
}
```

#### 自定义tabBar

tabbar上加动画，就需要取自定义新的tabbar去承载动画，关键代码

```
<!--继承TabBar-->
- (void)layoutSubviews {
[super layoutSubviews];
// 移除系统的tabBarItem
Class class = NSClassFromString(@"UITabBarButton");
for (UIView *item in self.subviews) {
if ([item isKindOfClass:class]) {
[item removeFromSuperview];
}
}
// 设置自定义的tabBarItem
[self setupItems];
}


/// 设置自定义的tabbarItem
- (void)setupItems {
CGFloat width = self.frame.size.width/self.LMItems.count;
CGFloat height = self.frame.size.height;
for (int i = 0; i < self.LMItems.count; i++) {
LMTabBarItem *item = [self.LMItems objectAtIndex:i];
item.frame = CGRectMake(i*width, 0, width, height);
[self addSubview:item];
item.delegate = self;
}
}

<!--TabBarViewController-->
/// 设置自定义的tabBar
- (void)setupCustomTabBarItems {
self.tabBar.hidden = YES;

//创建items数组
NSArray *animationJsonNameArray = @[@"fangzi",@"huiyuan",@"dingdan",@"wode"];
NSMutableArray *items = [NSMutableArray array];
for (int i = 0; i < self.lmViewControllers.count; i++) {
LMTabBarItem *item = [[LMTabBarItem alloc]init];
item.animationJsonName = animationJsonNameArray[i];
[items addObject:item];
item.tag = i;
}
[self setBeginItemAnimation:items[0] item:0];
self.customTabBar.LMItems = [items copy];

[self.view addSubview:self.customTabBar];
self.customTabBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - LMTabBarHeight, CGRectGetWidth(self.view.frame), LMTabBarHeight);
}

<!--TabBarItem-->

// item点击手势，响应点击事件
- (void)tapItem:(UITapGestureRecognizer *)tap {
if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarItem:didSelectIndex:)]) {
[self.delegate tabBarItem:self didSelectIndex:self.tag - defaultTag];
}
}
// 修改布局
- (void)layoutSubviews {
[super layoutSubviews];
CGRect rect = self.frame;
rect.origin.x = 0;
rect.origin.y = -35;
rect.size.height += 20;
self.animationView.frame = rect;
}
```

#### KVO自定义tabBar

```
<!--TabBarView-->
- (void)itemButton:(NSInteger)itemNumber itemBlock:(nonnull itemButtonBlock)itemBlock{
CGFloat itemW = [UIScreen mainScreen].bounds.size.width / itemNumber;
CGFloat w = itemW / 2.0 - itemW / 2.0;
NSArray *nameArray = @[@"huiyuan",@"fangzi",@"dingdan",@"wode"];
for (int i = 0; i < itemNumber; i ++) {
TTItemButton *item = [[TTItemButton alloc]initWithFrame:CGRectMake(w +itemW *i, 0, itemW, 66) ];
item.tag = 100 + i;
LOTAnimationView *LOTView = [LOTAnimationView animationNamed:nameArray[i]];
LOTView.tag = item.tag + 100;
LOTView.contentMode = UIViewContentModeScaleAspectFill;
CGRect LOTViewFrame = item.frame;
LOTViewFrame.origin.y = -16;
[LOTView setFrame:LOTViewFrame];
[self addSubview:LOTView];
[item addTarget:self action:@selector(selectedButtonItem:) forControlEvents:UIControlEventTouchUpInside];
[self addSubview:item];
}
[self setBeginAnimationLOTView];
self.block = itemBlock;
}
- (void)setBeginAnimationLOTView{
LOTAnimationView *LOTView = [self viewWithTag:200];
if (LOTView.animationProgress == 0 ) {
[LOTView playToProgress:0.5 withCompletion:^(BOOL animationFinished) {
NSLog(@"pressButtonAction isSelected animation");

}];
}
}
- (void)selectedButtonItem:(UIButton *)sender{
if (self.currentItem != sender.tag) {
self.currentItem = sender.tag;
LOTAnimationView *LOTView = [self viewWithTag:(sender.tag + 100)];
for (LOTAnimationView *view in self.subviews) {
if ([view isKindOfClass:[LOTAnimationView class]]) {
[view stop];
}
}
if (LOTView.animationProgress == 0 ) {
[LOTView playToProgress:0.5 withCompletion:^(BOOL animationFinished) {
NSLog(@"pressButtonAction isSelected animation");

}];
}
self.block(sender.tag);
}
}
<!--TabBar-->
- (TTTabbarView *)tttabbarView{
if (!_tttabbarView) {
_tttabbarView = [[TTTabbarView alloc]initWithFrame:self.bounds];
[_tttabbarView itemButton:4 itemBlock:^(NSInteger item) {
if (self->_barDelegate && [self->_barDelegate respondsToSelector:@selector(selectedItemButton:)]) {
[self->_barDelegate selectedItemButton:item];
}
}];
}
return _tttabbarView;
}
- (void)layoutSubviews
{
[super layoutSubviews];
// 设置tabBarView的frame
self.tttabbarView.frame = self.bounds;
// 把tabBarView带到最前面，覆盖tabBar的内容
[self bringSubviewToFront:self.tttabbarView];
}

<!--TabBarViewController-->
TTCustomTabbar *customBar = [[TTCustomTabbar alloc]init];
customBar.barDelegate = self;
[self setValue:customBar forKey:@"tabBar"];
```

注意⚠️

在自定义TabBar时，可能会出现NavigationBar设置不生效的情况，
在TabBarViewController里去设置NavigationBar,这样也会导致二级跳转的时候TabBar不消失，需要在一级界面设置二级界面hidesBottomBarWhenPushed = YES

```
- (void)addAllChildViewController {
GoTabbarChildMessageViewController *homeVC = [[GoTabbarChildMessageViewController alloc] init];
homeVC.view.backgroundColor = [UIColor redColor];
[self addChildViewController:homeVC title:@"首页" imageNamed:@"tabBar_home"];

GoTabbarChildSetViewController *activityVC = [[GoTabbarChildSetViewController alloc] init];
activityVC.view.backgroundColor = [UIColor yellowColor];
[self addChildViewController:activityVC title:@"活动" imageNamed:@"tabBar_activity"];

UIViewController *findVC = [[UIViewController alloc] init];
findVC.view.backgroundColor = [UIColor blueColor];
[self addChildViewController:findVC title:@"发现" imageNamed:@"tabBar_find"];

UIViewController *mineVC = [[UIViewController alloc] init];
mineVC.view.backgroundColor = [UIColor greenColor];
[self addChildViewController:mineVC title:@"我的" imageNamed:@"tabBar_mine"];
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed {
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
[self addChildViewController:nav];
}
```


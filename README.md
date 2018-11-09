# HJWTable
在界面加一个浮动的按钮, 点击已自定义的形式, 进行push到下一界面
1. table的datasoure和delegate代理的分离, 不同的代理,写在不同的文件里面

2.调用起来比较方便

3.使用方式,只需要将
table.dataSource = self.dataSource;
table.delegate = self.tableDelegate;
这样就可以了, 设置的有HJWTableDelegate里面暴露的有很多j属性, 直接设置对应的属性就可以了

4.上拉加载和下拉刷新用的MJRefrsh , 需要改的自己去改

5.model转换用的MJExtension. 不习惯的自己把baseModel里面换一下

6.所有的model最好继承自BaseModel. 因为里面加了一个cellHeight默认值, 不继承也没关系,也可以用

7.至于父类cell没有写,  因为这个很多写法, 自己去搞


注意:
1.dataSource里面的canMoveRow属性书控制整个table的所有cell的开关, 这里没有写indexPath数组,去判断哪些cell不能进行编辑

2.tableDelegate的代理里面的headViews  footViews 是传的数组, 在使用的时候, 当对数据源进行操作,导致section分组增加的时候,请在外面处理headViews  footViews的内容,这里我没有做复用的机制, 大家可以自己补充

3.在左滑实现删除或者置顶等多项选择时editActionsTitleArr和editActionsColorArr数组传入显示t文字和颜色, 如果想修改字体那些, 你们自己改吧

4.使用自己设置的行高的时候就直接tableDelegate.cellHeight直接赋值,  需要关闭automaticDimension=yes属性如果不赋值,如果数据源继承basemodel, 会使用basemodel的cellheight属性默认高度, 如果不是basemodel,这里默认给了一个50行高

5.如果自动算高度, 就需要打开automaticDimension=yes属性, 然后不要写cellHeight行高了, 其实写了也没什么!

6.自动算cell高, 出现cell跳动用的是缓存高度解决的, 你们自己改吧


# XZPictureLookUp的使用简介

本版XZPictureLookUp实现功能：

       —查看缩略图大图
       -可放大缩小 

//使用时先创建XZPictureLookUpView
let view  = XZPictureLookUpView.creat()

//然后显示想要展现的图片
/*
   image : 想要展示的图片
   frame : 展示图片控件的初始frame
   fromeview : 展示图片所在控件的父视图
*/
view.showWithImage(_ image:UIImage,frame:CGRect,fromView:UIView)

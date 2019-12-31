#### VIMD for AfterEffect 使用说明

> VIMD for AfterEffect 宗旨只为Ae更高效，本脚本一直在优化，希望大家积极反馈！在使用前请记得以下2点.

> 1. Ctrl+A如无法打开AE请配置config.ini的Ae路径AEPath=C:\Program Files\Adobe\Adobe After Effects CC 2018\Support Files\AfterFX.exe

> 2. 使用本脚本请在Ae窗口双按zz下最大化使用，效果最佳，否则会有点影响体验



> 基本

        qq:渲染
        cc:新建合成
        xx:退出AE
        x:关闭当前
        zz:窗口最大化显示
        z:合成窗口100%
        oo:打开
        kk:当前合成设置
        R：清除所有效果
        X：图层独立显示
        C：图层锁定
        Z：图层隐藏显示
        <F1>：KeyBoard
        <F7>：QuickMenu
        <F8>：BoBO_AeTools
        ？:帮助

> 长按

  ![长按](https://s1.ax1x.com/2018/10/26/iyfj0g.gif)
     <p>P/R/S/T，显示Transform四大属性 Position/Rotation/Scale/Opacity。长按则是在目前的时间新增一个快捷键对应属性的keyframe。有了这个快捷键，不用滑鼠移去按码表旁的菱形，也不用去记ctrl+alt+什么的

        长按p_K位置关键帧
        长按s_K缩放关键帧
        长按r_K旋转关键帧
        长按t_K透明关键帧


> /系列

        /0 打开
        /1 保存
        /2 另存为
        /3 打开最近
        /4 导入
        /5 退出

+ 双按

    ![长按](https://s1.ax1x.com/2018/10/26/iyfzkj.gif)
    <p>调曲线总是要在timeline和graph editor切换千千万万次。在AE想通把这两个介面分开前，这真的方便很多～～

    ![长按](https://s1.ax1x.com/2018/10/26/iyhCpq.gif)
    <p>连按左边Ctrl两下新增选取属性的key
    游标在时间轴调Timing时，这样就不用还要移到码表旁边才能新增key


+ 按住鼠标左键在单击

    <p>这是在用AHK之前从没用过的操作方式。很方便的增加一层绝对不会冲突的快捷键区。这区主要用来启动一些单独功能的脚本：


    1. 按住左键再按d (difference)

        ![长按](https://s1.ax1x.com/2018/10/26/iyhEBF.gif)

        <p>切换选取的图层的混和模式（difference / normal），difference用来对位置很方便

    2. 按住左键再按a

         ![长按](https://s1.ax1x.com/2018/10/26/iyheAJ.gif)

        <p>叫出foolParent。因为KEYboard的foolParent就是用a叫出来，所以沿用一样的设定。但比起从KEYboard执行，这样用快了一步，而且因为ahk的功能，可以让视窗出现在滑鼠的位置上。

    3. 按住左键再按c（center）


        ![长按](https://s1.ax1x.com/2018/10/26/iyhK91.gif)

        <p>把选取的图层轴心置中。这是用内建的快捷键达成的功能，所以没办法像motion2那样对position已经设key的图层也正确的置中。但还是很常用到啦～

    4.  按住左键再按n （name）

         ![长按](https://s1.ax1x.com/2018/10/26/iyhQc6.gif)

        <p>启动一个可以简单批次命名的脚本，输入内容后按下enter即可。

    5.  按住左键再按h

         ![长按](https://s1.ax1x.com/2018/10/26/iyh3nO.gif)

        <p>Toggle Mask and Shape Path Visibility。不会很常用到，但有时候comp切来切去，都会自动关闭显示。原本的快捷键是Ctrl+Shift+H，所以就设定成按h来切换

    6. 按住左键再按j （jump）

        ![长按](https://s1.ax1x.com/2018/10/26/iyh8BD.gif)

        <p>选一个key，然后将目前时间移动到选取的key的时间上。




> 其它按键演示

        R/X/C/Z 如果正常模式的请按Shift+r/x/c/z 

            R 清除效果

> X 单独显示切换

![长按](https://s1.ax1x.com/2018/10/26/iy4rxx.gif)


> C 锁定图层

![长按](https://s1.ax1x.com/2018/10/26/iy40i9.gif)
            

> Z 图层隐藏显示切换

![长按](https://s1.ax1x.com/2018/10/26/iy4Izt.gif)


> 自定义设置

> 1.设置环境
    
    A.设置预设动画目录文件..\Vimdesktop\custom\ae_presetAnimation 最好把预设文件放这里

    B.\ae_scripts目录,add_PresetAnimation_1.jsx  一个文件代表一个预设 每个预设里面记得把路径填对，已注释 其它不要更改

> 2.在AfterEffects.ahk

        1.按键设定 请在注释为【;调用预设按键】进行添加

        2.有注释为【;调用动画预设文件】 请按方式进行添加 目前配置5个 预设脚本改变，里面必须跟着改变



部分功能效果来自olaola，已完美结合到VIMD.

* [olaola的原文地址](https://medium.com/@olaolayuan/after-effects-with-autohotkey-2-%E6%87%89%E7%94%A8-6204da5caa93)
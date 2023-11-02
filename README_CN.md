# Finovy UIKit

轻量、可靠的移动端Flutter组件库

[English](README.md) | 中文版
## **一、使用方法**
在pubspec.yaml文件dependencies节点加入：
```dart
fn_ui_kit:
  git:
    url: https://github.com/finovy/finovy_ui_kit.git
```

## **二、组件库基础信息**

|**名称**|                                                                                                                      **fn\_ui\_kit**                                                                                                                      |
| :-: |:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
|**使用类别**|                                                                                                                            UI类                                                                                                                            |
|**开发框架**|                                                                                                                          flutter                                                                                                                          |
|**开发语言**|                                                                                                                           Dart                                                                                                                            |
|**最低环境要求**|                                                                                                         flutter >=3.0.0    dart >=2.17.0 <=4.0.0                                                                                                          |
|**当前版本**|                                                                                                                          1\.1.0                                                                                                                           |
|**第三方依赖**| [auto_size_text](https://pub.dev/packages/auto_size_text)  [pin_code_fields](https://pub.dev/packages/pin_code_fields)   [pull_to _refesh](https://pub.dev/packages/pull_to_refresh)  [visibility_detector](https://pub.dev/packages/visibility_detector) |
|**开源地址**|                                                                                                        https://github.com/finovy/finovy_ui_kit.git                                                                                                        |
## **三、组件库目录结构**
```
fn_ui_kit
├── icons（svg通用图标：不会被编译进去）
│   ├── base （最常用的图标）
│   └── tabbar(底部导航栏图标)
├── lib (源代码) 
│   └── assets
│      ├── images （图片资源）
│      └── fn_icons.dart (通用图标引用类 类型IconData)│   
│      └── fn_icons_font.otf (通用图标生成的字体文件，pubspec.yaml文件里面引用)
│   └── src
│       ├── basic   (基础组件，包含文本Text、按钮Button、图片Image、图标Icon、输入框TextFiled、公共页面Page、标签Tag)
│       └── charts  (图表组件，包含折线图LineChart、柱状图BarChart等)
│       ├── constant(常量，包含颜色Color、字体大小FontSize、图片路径ImagePath)  
│       └── feedback (反馈组件，包含弹出确认框Dialog、轻提示框Toast、通知栏NoticeBar、步骤条Step)
│       ├── form    (表单组件，包含单元格Cell、复选框CheckBox，表格Form、单选框RadioButton，搜索组件Search,分栏组件Segment，星级投票Rate)
│       ├── third_lib(第三方库)
│       └── business(业务组件，包含验证码输入框VerifyInput、事件容器Event Container、状态占位组件EmptyWidget、日期选择DatePicker)
│       ├── theme   (主题组件，包含大部分组件的主题配置)
│       └── navigation (导航组件，包含导航栏AppBar、导航返回Back、网格组件Grid、脚手架Scaffold)
├── pubspec.yaml（项目配置信息）
└── README.md（英文描述文档）
├── README_CN.md（中文描述文档）
└── CHANGELOG.md （修改记录）
```

**目录结构说明：**

1. icons目录为通用，引用时并不会被编译进去；
1. src目录下的一级目录均为组件类别，如basic为基础组件类；
1. third\_lib为第三方依赖库目录，为本地依赖，目的是设置固定版本确保组件库的版本稳定迭代更新；
1. pubspec.yaml为组件库的配置文件，组件库的版本信息以及相关依赖均在此文件体现；
1. CHANGELOG.md文件为每次迭代更新组件库版本时必须填写的文件，里面记录了每次组件库迭代更新的具体信息；
1. readme.md为组件库更新到其他平台如github、pub、gitlab等时的描述文件。

**目录包含组件统计：**

<table>
<tr><th><b>目录名称</b></th><th><b>组件类别</b></th><th><b>组件名称</b></th><th><b>组件描述</b></th><th><b>使用场景</b></th></tr>
<tr><td rowspan="5"><p><b>basic</b></p><p>（基础类）</p></td><td>button</td><td>FNUIButton</td><td>按钮组件，支持主要按钮、次要按钮、文字按钮，图标按钮</td><td>全局均可使用，支持三种状态（可用、禁用、加载中），支持边框自定义，文本自定义</td></tr>
<tr><td>image</td><td>FNUIImage、</td><td>图片组件，支持网络图片、本地图片，支持指定模块加载；</td><td>全局使用</td></tr>
<tr><td>input</td><td>FNUITextField、FNUIPasswordInput</td><td><p>输入组件，支持普通文本输入，键盘样式、文本样式等常规设置；</p><p>密码输入组件，支持普通密码输入，键盘样式、文本样式等常规设置；</p></td><td>交互式输入场景、验证场景</td></tr>
<tr><td>text</td><td><p>FNUIText、</p><p>FNExpandLabel</p></td><td><p>文本组件，支持普通文本展示，文本样式自定义；</p><p>可折叠文本组件，支持多行文本的折叠和展开交互；</p></td><td><p>最常用的组件，全局使用；</p><p>需要多行文本展示折叠效果</p></td></tr>
<tr><td>icon</td><td>FNUIIcon</td><td>图标组件，支持文本和图标样式自定义</td><td>全局使用，通用图标返回IconData</td></tr>
<tr><td rowspan="8"><p><b>form</b></p><p>（表单类）</p></td><td>form</td><td>FNUIForm</td><td>表单组件，支持表单带常规输入框、箭头式、多行文本式表单展示；</td><td>个人信息展示或修改场景、意见反馈等场景</td></tr>
<tr><td>cell</td><td>FNUICell</td><td>表单单行组件，支持标题、内容、图标等展示</td><td>用户信息展示、资料展示场景</td></tr>
<tr><td>radio</td><td>FNUIRadio</td><td>单选按钮组件，支持唯一单选控制和展示</td><td>用户单一选择数据场景</td></tr>
<tr><td>checkbox</td><td>FNUICheckBox</td><td>复选按钮组件，支持多个选择控制和展示</td><td>用户选择多个数据场景</td></tr>
<tr><td><s>table</s></td><td><s>FNUITable</s></td><td><s>表格组件，支持常规表头、内容展示</s></td><td><s>带表头的数据列表展示场景</s></td></tr>
<tr><td>rate</td><td>FNUIRate</td><td>投票组件，支持投票、评级等icon展示</td><td>投票、评级场景</td></tr>
<tr><td>search</td><td>FNUISearch</td><td>搜索组件，支持常规搜索视图展示</td><td>需要提供搜索服务的场景</td></tr>
<tr><td>segment</td><td>FNUISegment</td><td>分栏组件，支持多组文本单一选择</td><td>需要选择或切换唯一分类的场景</td></tr>
<tr><td rowspan="3"><p><b>feedback</b></p><p>(操作反馈类)</p></td><td>toast</td><td>FNUIToast</td><td>轻提示组件，支持上中下位置展示，支持mask交互隔离</td><td>交互成功、失败、提醒弹窗场景，加载等待</td></tr>
<tr><td>dialog</td><td>FNUIDialog</td><td>弹出框组件，支持弹出确认框、底部确认框、自定义按钮以及事件响应</td><td>交互确认场景、用户主动选择确认场景</td></tr>
<tr><td>progress</td><td><p>FNUILinearProgress、</p><p>FNUICircularProgress</p></td><td>进度提示组件，支持线性、圆形视觉效果</td><td>明确需要进度展示的场景</td></tr>
<tr><td rowspan="4"><p><b>navigation</b></p><p>(导航类)</p></td><td>appbar</td><td>FNUIAppbar</td><td>顶部导航栏组件，支持常规背景、文字、按钮等配置</td><td>全局配置，路由导航页</td></tr>
<tr><td>back</td><td>FNUINavBack</td><td>导航返回按钮</td><td>全局配置，路由导航页</td></tr>
<tr><td>grid</td><td>FNUIGrid</td><td>网格组件，支持多种菜单</td><td>全局配置</td></tr>
<tr><td>scaffold</td><td>FNUIScaffold</td><td>脚手架组件</td><td>全局配置</td></tr>
<tr><td><p><b>charts</b></p><p>(图表类)</p></td><td>-</td><td>-</td><td>-</td><td>暂未完成封装</td></tr>
<tr><td rowspan="4"><p><b>business</b></p><p>(业务类)</p></td><td>verifycode</td><td>FNUIVerifyCodeInput</td><td>验证码输入组件，支持90%以上的验证码场景，可以高度自定义</td><td>用于登录、注册等验证码输入场景</td></tr>
<tr><td>place_holder</td><td>FNUIEmpty</td><td>占位视图组件，支持无数据、请求错误、网络错误等多类别展示</td><td>用于视图占位场景，可根据实际需要选择</td></tr>
<tr><td>picker</td><td>FNUIDatePicker</td><td>时间选择组件，支持时间选择多种样式</td><td>用于选择具体时间，支持常规时间格式化</td></tr>
<tr><td>event</td><td>FNUIEventContainer</td><td>事件普通容器组件，继承普通容器，支持点击事件</td><td>需要容器带点击事件的场景</td></tr>
<tr><td rowspan="3"><p><b>constant</b></p><p>(常量类)</p></td><td>colors</td><td>FNColors</td><td>颜色常量类，归类设计稿上不同场景的颜色值，支持快捷访问</td><td>用于统一颜色值，配合主题使用</td></tr>
<tr><td>fonts</td><td>FNFontSize</td><td>字体大小常量类，统一字体大小</td><td>用于统一项目内字体大小，一般不用额外指定</td></tr>
<tr><td>images</td><td>FNImagePath</td><td>图片路径处理类，提供图片路径存储和路径处理</td><td>用于定义组件库内图片类地址等</td></tr>
<tr><td rowspan="2"><p><b>theme</b></p><p>(主题配置类)</p></td><td>styles</td><td>组件主题配置文件夹</td><td>包含大部分组件主题配置</td><td>用于每个组件单独主题配置</td></tr>
<tr><td>theme</td><td>FNTheme</td><td>主题配置主文件</td><td>main文件入口引用</td></tr>
<tr><td rowspan="4"><p><b>third_lib</b></p><p>(第三方依赖类)</p></td><td>auto_size_text</td><td>-</td><td>文本自动大小组件，支持根据宽度自适应文本字体大小</td><td>用于特殊文本字体大小适配展示场景</td></tr>
<tr><td>pin_code_fields</td><td>-</td><td>验证码输入组件，支持验证码输入、自动填充等</td><td>用于登录、注册等验证码输入场景</td></tr>
<tr><td>pull_to_refresh</td><td>-</td><td>列表刷新组件，支持头部、底部自定义</td><td>用于列表组件刷新场景</td></tr>
<tr><td>visibility_detector</td><td>-</td><td>可见区域检测组件，支持视图的可见状态检测</td><td>用于路由切换、页面切换、前后台切换场景检测</td></tr>
<tr><td><p><b>context</b></p><p>(上下文类)</p></td><td>context</td><td>FNDesignContext</td><td>上下文配置入口，主要用于为弹框类提供上下文；提供了两种初始化的方法：initFNUIKitContext、FNUIKitContextBuilder</td><td>程序主入口进行初始化</td></tr>
</table>





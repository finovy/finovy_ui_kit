# Finovy UIKit

A lightweight and reliable mobile Flutter component library

English | [中文版](README_CN.md)
## **1. Usage**

Add the following line to the dependencies section in the pubspec.yaml file:

```dart
fn_ui_kit:
	git:
		url: https://github.com/finovy/finovy_ui_kit.git
```



## **2. Basic Information of the Component Library**

|              **Name**               |                       **fn\_ui\_kit**                        |
| :---------------------------------: | :----------------------------------------------------------: |
|            **Category**             |                              UI                              |
|      **Development Framework**      |                           flutter                            |
|      **Development Language**       |                             Dart                             |
| **Minimum Environment Requirement** |           flutter >=3.0.0    dart >=2.17.0 <=4.0.0           |
|         **Current Version**         |                            1\.0.0                            |
|    **Third-Party Dependencies**     | [auto_size_text](https://pub.dev/packages/auto_size_text)  [pin_code_fields](https://pub.dev/packages/pin_code_fields)   [pull_to _refesh](https://pub.dev/packages/pull_to_refresh)  [visibility_detector](https://pub.dev/packages/visibility_detector) |
|     **Open Source Repository**      |         https://github.com/finovy/finovy_ui_kit.git          |

## **3. Component Library Directory Structure**

```xml-dtd
fn_ui_kit
├── CHANGELOG.md
├── LICENSE
├── analysis_options.yaml
├── fn_ui_kit.iml
├── lib
│   ├── assets
│   │   └── images
│   ├── fn_ui_kit.dart
│   ├── res
│   │   └── lib_res.dart
│   └── src
│       ├── basic
│       ├── business
│       ├── charts
│       ├── constant
│       ├── context
│       ├── feedback
│       ├── form
│       ├── navigation
│       ├── theme
│       └── third_lib
├── pubspec.lock
├── pubspec.yaml
├── test
│   └── fn_ui_kit_test.dart
└── README.md
```
**Directory Structure Explanation:**

1. The first-level directories under the src directory represent different component categories, such as basic for basic components.
2. The third_lib directory is for local dependencies of third-party libraries, ensuring the stability and iterative updates of the component library.
3. The pubspec.yaml file is the configuration file of the component library, which contains version information and related dependencies of the component library.
4. The CHANGELOG.md file must be filled in each time the component library is iteratively updated, recording the specific information of each iteration update of the component library.
5. The readme.md file is the description file when the component library is updated to other platforms such as GitHub, Pub, GitLab, etc.

**Component Statistics in the Directory:**

<table><tr><th><b>Directory Name</b></th><th><b>Component Category</b></th><th><b>Component Name</b></th><th><b>Component Description</b></th><th><b>Usage Scenario</b></th></tr>
<tr><td rowspan="4"><p><b>basic</b></p><p>(basic category)</p></td><td>button</td><td>FNUIButton</td><td>A button component that supports primary, secondary, text, and icon buttons</td><td>Can be used globally, supports three states (enabled, disabled, loading), supports customizable border and text, supports custom styles with UIButtonStyle</td></tr>
<tr><td>image</td><td><p>FNUIImage, FNUIIcon</p></td><td><p>An image component that supports network and local images, supports specified module loading;</p><p>An icon component that supports customizable text and icon styles</p></td><td>Can be used globally</td></tr>
<tr><td>input</td><td>FNUITextField, FNUIPasswordInput</td><td><p>An input component that supports regular text input, keyboard style, text style, etc.;</p><p>A password input component that supports regular password input, keyboard style, text style, etc.</p></td><td>Interactive input and validation scenarios</td></tr>
<tr><td>text</td><td><p>FNUIText, FNExpandLabel</p></td><td><p>A text component that supports regular text display, customizable text style;</p><p>An expandable text component that supports folding and expanding of multi-line text</p></td><td><p>The most commonly used component, used globally;</p><p>Needed for multi-line text display with folding effect</p></td></tr>
<tr><td rowspan="8"><p><b>form</b></p><p>(form category)</p></td><td>form</td><td>FNUIForm</td><td>A form component that supports displaying forms with regular input boxes, arrow-style, and multi-line text;</td><td>Personal information display or modification scenarios, feedback scenarios, etc.</td></tr>
<tr><td>cell</td><td>FNUICell</td><td>A single-line form component that supports displaying titles, content, icons, etc.</td><td>User information display, data display scenarios</td></tr>
<tr><td>radio</td><td>FNUIRadio</td><td>A radio button component that supports unique radio selection and display</td><td>User single selection data scenarios</td></tr>
<tr><td>checkbox</td><td>FNUICheckBox</td><td>A checkbox component that supports multiple selection control and display</td><td>User multiple selection data scenarios</td></tr>
<tr><td>table</td><td>FNUITable</td><td>A table component that supports displaying regular table headers and content</td><td>Data list display scenarios with headers</td></tr>
<tr><td>rate</td><td>FNUIRate</td><td>A voting component that supports displaying voting, rating icons, etc.</td><td>Voting, rating scenarios</td></tr>
<tr><td>search</td><td>FNUISearch</td><td>A search component that supports regular search view display</td><td>Scenarios that require search services</td></tr>
<tr><td>segment</td><td>FNUISegment</td><td>A segment component that supports selecting a single category from multiple groups of text</td><td>Scenarios that require selecting or switching unique categories</td></tr>
<tr><td rowspan="3"><p><b>feedback</b></p><p>(feedback category)</p></td><td>toast</td><td>FNUIToast</td><td>A toast component that supports displaying in the top, middle, or bottom position, and supports mask interaction isolation</td><td>Interactive success, failure, reminder pop-up scenarios, loading/waiting scenarios</td></tr>
<tr><td>dialog</td><td>FNUIDialog</td><td>A dialog component that supports displaying confirmation dialogs, bottom confirmation dialogs, custom buttons, and event responses</td><td>Interactive confirmation scenarios, user-initiated confirmation selection scenarios</td></tr>
<tr><td>progress</td><td><p>FNUILinearProgress, FNUICircularProgress</p></td><td>A progress component that supports linear and circular visual effects</td><td>Scenarios that require clear progress display</td></tr>
<tr><td><p><b>navigation</b></p><p>(navigation category)</p></td><td>appbar</td><td>FNUIAppbar</td><td>A top navigation bar component that supports regular background, text, button configurations</td><td>Global configuration, routing navigation page</td></tr>
<tr><td><p><b>charts</b></p><p>(chart category)</p></td><td>-</td><td>-</td><td>-</td><td>Not yet implemented</td></tr>
<tr><td rowspan="4"><p><b>business</b></p><p>(business category)</p></td><td>verifycode</td><td>FNUIVerifyCodeInput</td><td>A verification code input component that supports over 90% of verification code scenarios and can be highly customized</td><td>Used in verification code input scenarios such as login, registration</td></tr>
<tr><td>place_holder</td><td>FNUIEmpty</td><td>A placeholder view component that supports displaying various types of data such as no data, request errors, network errors, etc.</td><td>Used in view placeholder scenarios, can be selected according to actual needs</td></tr>
<tr><td>picker</td><td>FNUIDatePicker</td><td>A date selection component that supports multiple styles of date selection</td><td>Used to select specific dates, supports regular date formatting</td></tr>
<tr><td>event</td><td>FNUIEventContainer</td><td>An event container component that inherits the regular container and supports click events</td><td>Used in scenarios where containers need click events</td></tr>
<tr><td rowspan="4"><p><b>constant</b></p><p>(constant category)</p></td><td>colors</td><td>FNColors</td><td>A color constant class that classifies color values for different scenarios on the design draft and supports quick access</td><td><tr><td>fonts</td><td>FNFontSize</td><td>A font size constant class that provides unified font sizes</td><td>Used for unified font sizes within the project, generally no need for additional specification</td></tr> 
<tr><td>styles</td><td>FNUIStyle</td><td>A collection of commonly used decorations, providing common container decorations</td><td>Used for configuring common container external decorations</td></tr> 
<tr><td>images</td><td>FNImagePath</td><td>An image path handling class that provides image path storage and retrieval</td><td>Used for defining image class addresses within the component library</td></tr> 
<tr><td rowspan="2"><p><b>theme</b></p><p>(theme configuration class)</p></td><td>theme_light</td><td>FNThemeManager</td><td>Light theme (default)</td><td>When adopted, all components will automatically become light configurations</td></tr> 
<tr><td>theme_dark</td><td>FNThemeManager</td><td>Dark theme</td><td>When adopted, all components will automatically become dark configurations</td></tr> 
<tr><td rowspan="5"><p><b>third_lib</b></p><p>(third-party dependency class)</p></td><td>auto_size_text</td><td>-</td><td>A text auto-sizing component that supports adapting text font size based on width</td><td>Used in special text font size adaptation display scenarios</td></tr> 
<tr><td>pin_code_fields</td><td>-</td><td>A verification code input component that supports code input and auto-filling</td><td>Used in code input scenarios such as login, registration</td></tr> 
<tr><td>pull_to_refresh</td><td>-</td><td>A list refresh component that supports customizing the header and footer</td><td>Used in list component refresh scenarios</td></tr> 
<tr><td>visibility_detector</td><td>-</td><td>A visible area detection component that supports detecting the visibility status of views</td><td>Used in scenarios such as route switching, page switching, and foreground/background switching detection</td></tr> 
<tr><td>animations</td><td>-</td><td>-</td><td>Not yet implemented</td></tr> 
  <tr><td><p><b>context</b></p><p>(context class)</p></td><td>context</td><td>FNDesignContext</td><td>Context configuration entry, mainly used to provide context for pop-up boxes; provides two initialization methods: initFNUIKitContext, smUIKitContextBuilder</td><td>Initialized at the main entry of the program</td></tr> </td</table>
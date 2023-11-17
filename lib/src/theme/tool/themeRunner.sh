#!/bin/bash

# 读取JSON配置文件
config=$(cat themeRunner.json)

# 解析JSON配置文件中的className和properties
themeName=$(echo $config | jq -r '.themeClass')
instanceName=$(echo $config | jq -r '.instanceName')
className=$(echo $config | jq -r '.className')
properties=$(echo $config | jq -c '.properties[]')

# 生成代码
code="import 'package:flutter/foundation.dart';
      import 'package:flutter/material.dart';
      import 'package:fn_ui_kit/fn_ui_kit.dart';
      import 'package:flutter/services.dart'; \n class $themeName extends InheritedTheme{
"

code+="
 const $themeName({
     Key? key,
     required this.data,
     required Widget child,
   }) : super(key: key, child: child);"

code+="
   static Widget merge({
     Key? key,
     required $className data,
     required Widget child,
   }) {
     return Builder(
       builder: (BuildContext context) {
         return $themeName(
           key: key,
           data: $themeName.of(context).merge(data),
           child: child,
         );
       },
     );
   }

   final $className data;

   static $className of(BuildContext context) {
     final $themeName? $instanceName =
         context.dependOnInheritedWidgetOfExactType<$themeName>();
     return $instanceName?.data ?? FNTheme.of(context).$instanceName;
   }

   @override
   bool updateShouldNotify($themeName oldWidget) => data != oldWidget.data;

   @override
   Widget wrap(BuildContext context, Widget child) {
     return $themeName(data: data, child: child);
   }

   @override
   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
     super.debugFillProperties(properties);
     data.debugFillProperties(properties);
   }
 }"


code+="class $className with Diagnosticable{
"

# 遍历properties，生成属性定义
while read -r property; do
  type=$(echo $property | jq -r '.type')
  value=$(echo $property | jq -r '.value')
  code+="final  $type $value;
"
done <<< "$properties"

# 生成工厂函数
code+="
 factory $className({"

while read -r property; do
  type=$(echo $property | jq -r '.type')
  value=$(echo $property | jq -r '.value')
  code+="$type? $value,
"
done <<< "$properties"

code+="  }){
return $className.raw(
"
while read -r property; do
  value=$(echo $property | jq -r '.value')
  code+="      $value: $value ?? null,
"
done <<< "$properties"

code+="    );
  }
"


# 生成构造函数
code+="
 const $className.raw({"

while read -r property; do
  value=$(echo $property | jq -r '.value')
  code+="required this.$value,
"
done <<< "$properties"

code+="  });
"

# 生成copyWith方法
code+="
   $className copyWith({"

while read -r property; do
  type=$(echo $property | jq -r '.type')
  value=$(echo $property | jq -r '.value')
  code+="$type? $value,
"
done <<< "$properties"

code+="  }) {
    return $className(
"

while read -r property; do
  value=$(echo $property | jq -r '.value')
  code+="      $value: $value ?? this.$value,
"
done <<< "$properties"

code+="    );
  }
"

# 生成merge方法
code+="
  $className merge($className? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
"

while read -r property; do
  value=$(echo $property | jq -r '.value')
  code+="      $value: other.$value,
"
done <<< "$properties"

code+="    );
  }
"

# 生成hashCode方法
code+="
  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
"

while read -r property; do
  value=$(echo $property | jq -r '.value')
  code+="      $value,
"
done <<< "$properties"

code+="    ];
    return Object.hashAll(values);
  }
"

# 生成equals方法
code+="
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is $className &&
"

while read -r property; do
  value=$(echo $property | jq -r '.value')
  code+="        other.$value == $value &&
"
done <<< "$properties"

code+="  1==1  ;
  }
"

# 生成debugFillProperties方法
code+="
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
"

while read -r property; do
  value=$(echo $property | jq -r '.value')
  type=$(echo $property | jq -r '.type')
  code+="    properties.add(DiagnosticsProperty<$type>('$value', $value,
        defaultValue: null));
"
done <<< "$properties"

code+="    super.debugFillProperties(properties);
  }
}"

# 输出生成的代码
echo "$code" > "tempTheme.dart"
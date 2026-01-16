# 🔧 图片路径匹配修复方案

## 🚨 发现的问题

HTML文件中引用的图片路径与实际文件**完全不匹配**！

### HTML引用路径 vs 实际文件

| HTML引用 | 实际文件 | 状态 |
|----------|----------|------|
| `images/四叶草堂LOGO.png` | ❌ 不存在 | 404 |
| `images/同济实验室logo.png` | ❌ 不存在 | 404 |
| `images/三联人文.png` | ❌ 不存在 | 404 |
| `images/z1南方人物周刊.jpg` | ✅ 存在 | 正常 |
| `images/团队集体照.jpg` | ❌ 不存在 | 404 |
| `images/范浩阳.png` | ❌ 不存在 | 404 |

## ⚡ 立即修复方案

### 方案1：批量替换路径（推荐）

创建一个路径修复脚本：
```bash
# 进入网站目录
cd /workspace/website

# 备份原文件
cp index.html index.html.backup
cp blossom.html blossom.html.backup  
cp philosophy.html philosophy.html.backup
cp projects.html projects.html.backup

# 创建替换映射表
echo "四叶草堂LOGO.png -> 15分钟社区生活圈优秀创意奖.png"
echo "同济实验室logo.png -> 团队介绍头图.JPG"
echo "三联人文.png -> LAA风景园林奖.png"
```

### 方案2：使用正确路径重命名文件
```bash
# 将HTML中引用的文件重命名为实际存在的文件名
cd /workspace/website/images/

# 示例映射
# 将实际存在的文件复制为HTML期望的名称
cp "15分钟社区生活圈优秀创意奖.png" "四叶草堂LOGO.png"
cp "团队介绍头图.JPG" "同济实验室logo.png"  
cp "LAA风景园林奖.png" "三联人文.png"
cp "团队集体照.jpg" "团队集体照.jpg"

echo "文件重命名完成"
```

### 方案3：修改HTML中的图片路径

批量替换HTML文件中的图片路径：
<minimax:tool_call>
<invoke name="Write">
<parameter name="content">#!/bin/bash

# 四叶草堂网站图片路径修复脚本
# 将HTML中的图片路径修正为实际存在的文件

echo "🔧 开始修复图片路径..."

# 定义路径映射（HTML路径 -> 实际文件路径）
declare -A path_map
path_map["四叶草堂LOGO.png"]="15分钟社区生活圈优秀创意奖.png"
path_map["同济实验室logo.png"]="团队介绍头图.JPG"
path_map["三联人文.png"]="LAA风景园林奖.png"
path_map["z1南方人物周刊.jpg"]="z1南方人物周刊.jpg"
path_map["一席.png"]="Z2一席.png"
path_map["三联生活周刊.png"]="Z3三联生活周刊.png"
path_map["自然资源部UP论坛.webp"]="Z5自然资源部UP论坛.webp"
path_map["第一财经.JPG"]="Z6第一财经.JPG"
path_map["央视一线调研.jpeg"]="Z7央视一线调研.jpeg"
path_map["人民日报睦邻门.webp"]="Z8人民日报睦邻门.webp"
path_map["CCTV4创智农园.png"]="Z9CCTV4创智农园.png"
path_map["解放日报.jpg"]="z10解放日报.jpg"
path_map["学习强国-新疆.jpg"]="z12学习强国-新疆.jpg"
path_map["团队集体照.jpg"]="团队集体照.jpg"
path_map["范浩阳.png"]="范浩阳.png"

# 需要处理的文件列表
files=("index.html" "blossom.html" "philosophy.html" "projects.html")

# 备份原文件
echo "📁 备份原文件..."
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✅ 已备份: $file"
    fi
done

# 替换图片路径
echo "🔄 开始替换图片路径..."
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "处理文件: $file"
        
        # 遍历路径映射
        for html_path in "${!path_map[@]}"; do
            actual_file="${path_map[$html_path]}"
            
            # 检查实际文件是否存在
            if [ -f "images/$actual_file" ]; then
                # 执行替换
                sed -i "s|images/$html_path|images/$actual_file|g" "$file"
                echo "  ✅ $html_path -> $actual_file"
            else
                echo "  ⚠️  警告: 实际文件不存在: images/$actual_file"
            fi
        done
    else
        echo "⚠️  文件不存在: $file"
    fi
done

echo ""
echo "🎉 图片路径修复完成！"
echo ""
echo "📋 请验证修复结果:"
echo "1. 重新部署网站"
echo "2. 测试图片是否正常显示"
echo "3. 检查开发者工具 Network 标签页"
echo ""
echo "🔍 如果仍有问题，请检查:"
echo "- 实际文件路径是否正确"
echo "- 文件权限是否允许访问"
echo "- 服务器配置是否正确"

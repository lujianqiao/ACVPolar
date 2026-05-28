#!/bin/sh

# 获取用户输入的 commit 信息
commit_msg_file=$1
commit_msg=$(cat "$commit_msg_file")

# 定义正则表达式，匹配规范：type(scope): subject 或 type: subject
# 支持常用类型：feat|fix|docs|style|refactor|perf|test|chore|revert|ci
reg_expr="^(feat|fix|docs|style|refactor|perf|test|chore|revert|ci)(\(.+\))?: .+"

if ! echo "$commit_msg" | grep -Eq "$reg_expr"; then
    echo "\033[31m❌ 错误: 你的 Git Commit 信息不符合规范！\033[0m"
    echo "--------------------------------------------------------"
    echo "💡 正确格式：\033[32m<type>: <description>\033[0m"
    echo "例如: \033[32mfix: 修复首页闪退问题\033[0m"
    echo "例如: \033[32mfeat(home): 新增下拉刷新功能\033[0m"
    echo "--------------------------------------------------------"
    echo "允许的 type 类型: feat, fix, docs, style, refactor, perf, test, chore, revert, ci"
    exit 1
fi
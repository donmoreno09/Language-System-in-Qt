#!/usr/bin/env python3
import re

def check_qml_brackets(filename):
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Remove comments and strings to avoid false matches
        content = re.sub(r'//.*', '', content)  # Remove line comments
        content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)  # Remove block comments  
        content = re.sub(r'"[^"]*"', '""', content)  # Remove string contents
        content = re.sub(r"'[^']*'", "''", content)  # Remove string contents
        
        # Count brackets
        open_braces = content.count('{')
        close_braces = content.count('}')
        open_parens = content.count('(')
        close_parens = content.count(')')
        open_brackets = content.count('[')
        close_brackets = content.count(']')
        
        print(f"Bracket analysis for {filename}:")
        print(f"Open braces {{: {open_braces}")
        print(f"Close braces }}: {close_braces}")
        print(f"Brace difference: {open_braces - close_braces}")
        print()
        print(f"Open parentheses (: {open_parens}")
        print(f"Close parentheses ): {close_parens}")
        print(f"Parentheses difference: {open_parens - close_parens}")
        print()
        print(f"Open brackets [: {open_brackets}")
        print(f"Close brackets ]: {close_brackets}")
        print(f"Brackets difference: {open_brackets - close_brackets}")
        
        if open_braces != close_braces:
            print(f"\n⚠️  MISSING BRACES: {open_braces - close_braces}")
        if open_parens != close_parens:
            print(f"\n⚠️  MISSING PARENTHESES: {open_parens - close_parens}")
        if open_brackets != close_brackets:
            print(f"\n⚠️  MISSING BRACKETS: {open_brackets - close_brackets}")
            
        if open_braces == close_braces and open_parens == close_parens and open_brackets == close_brackets:
            print("\n✅ All brackets appear balanced")
            
    except Exception as e:
        print(f"Error reading file: {e}")

if __name__ == "__main__":
    check_qml_brackets("src/qml/components/AddTaskDialog.qml")
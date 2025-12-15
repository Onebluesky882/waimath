# ถอนการติดตั้ง

dart pub global deactivate mason_cli

# ติดตั้งใหม่

dart pub global activate mason_cli

// เริ่มต้น
mason init

// สร้าง
mason new <name>

// next config mason.yaml

```follow layer
bricks:
  bricks:
    path: bricks
```

// config analysis_options.yaml
add เพื่อไม่ให้ folder dart error line

```
analyzer:
  exclude:
    - bricks/**

```

// เรียก ไฟล์ brick เข้า list
mason get

// list
mason list

// use bricks on list
mason make <name>

mason make bricks --name user -o lib/feature

# ลบ cache

rm -rf .mason

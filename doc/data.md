2️⃣ Data ทำหน้าที่อะไร ❓

👉 Data คือ “คนทำงาน” ตามคำสั่งจาก Domain

Data มีอะไรบ้าง
✅ 1. Data Source

แหล่งข้อมูลจริง

abstract class RemoteDataSource {
Future<User> login(String email, String password);
}

ตัวอย่าง implementation

REST API

Firebase Auth

GraphQL

class RemoteDataSourceImpl implements RemoteDataSource {
@override
Future<User> login(String email, String password) async {
// เรียก API จริง
}
}

✅ 2. Model

แปลงข้อมูลจาก API

class UserModel extends User {
UserModel({required super.email});

factory UserModel.fromJson(Map<String, dynamic> json) {
return UserModel(email: json['email']);
}
}

📌 Model อยู่ใน Data เท่านั้น

✅ 3. Repository Implementation

เชื่อม Domain ↔ Data

class AuthRepositoryImpl implements AuthRepository {
final RemoteDataSource remoteDataSource;

AuthRepositoryImpl({required this.remoteDataSource});

@override
Future<User> login(String email, String password) async {
return await remoteDataSource.login(email, password);
}
}

3️⃣ เปรียบเทียบแบบง่ายมาก 🍔
ส่วน เปรียบเทียบ
Domain ใบสั่งอาหาร
Data พ่อครัว
Presentation ลูกค้า
Entity เมนู
Repository รายการที่สั่งได้
DataSource เตา / ครัว

ลูกค้า → สั่ง → ใบสั่ง (Domain) → พ่อครัว (Data) → อาหารจริง

4️⃣ สิ่งที่ห้ามเด็ดขาด 🚫

❌ Domain import Data
❌ Domain import Flutter
❌ Domain รู้จัก Dio / Firebase

✅ Data import Domain ได้
✅ Presentation import Domain ได้

5️⃣ จำง่าย ๆ ด้วยประโยคเดียว

Domain = “ทำอะไร”
Data = “ทำยังไง”

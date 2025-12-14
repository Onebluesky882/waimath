Domain ทำหน้าที่อะไร ❓

👉 Domain คือ “สมอง” ของแอป

สิ่งที่อยู่ใน domain:

ไม่รู้จัก Flutter

ไม่รู้จัก API / Firebase

ไม่รู้จัก Dio / HTTP

รู้แค่ว่า “ระบบควรทำอะไร”

Domain มีอะไรบ้าง
✅ 1. Entity

โมเดลหลักของธุรกิจ

class User {
final String email;

User({required this.email});
}

ไม่มี JSON

ไม่มี fromMap / toJson

เป็น pure Dart

✅ 2. Repository (abstract)

กำหนดว่า “ระบบทำอะไรได้บ้าง”

abstract class AuthRepository {
Future<User> login(String email, String password);
}

🔴 สำคัญมาก

Domain “สั่งงาน” แต่ ไม่รู้ว่าข้อมูลมาจากไหน

ไม่รู้ว่า API หรือ Firebase

✅ 3. Use Case (ถ้ามี)

การกระทำ 1 อย่าง

class LoginUseCase {
final AuthRepository repository;

LoginUseCase(this.repository);

Future<User> call(String email, String password) {
return repository.login(email, password);
}
}

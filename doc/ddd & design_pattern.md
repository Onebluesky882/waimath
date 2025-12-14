DDD ใช้ Design Patterns ตรงไหนบ้าง

ด้านล่างคือ การ mapping ระหว่าง DDD ↔ refactoring.guru

1️⃣ Entity (DDD) ↔ NO specific pattern

Entity ไม่ใช่ pattern

Entity คือ แนวคิดทางธุรกิจ

class User {
final UserId id;
}

👉 Pattern ไม่เกี่ยว
👉 Domain concept ล้วน ๆ

2️⃣ Value Object (DDD) ↔ Value Object Pattern

(อยู่ใน catalog แบบ implicit)

class Money {
final int amount;
final Currency currency;
}

✔ immutable
✔ equality by value

3️⃣ Repository (DDD) ↔ Repository Pattern

📍 อยู่ใน Structural Patterns

👉 DDD “บอกว่าต้องมี repository”
👉 Pattern “บอกว่าจะเขียน repository ยังไง”

4️⃣ Factory (DDD) ↔ Factory Method / Abstract Factory

DDD บอกว่า:

“การสร้าง object บางอย่างมันซับซ้อน ควรแยก”

Pattern ช่วยทำให้โค้ดสะอาด

class QuestionFactory {
Question createRandom();
}

5️⃣ Domain Service (DDD) ↔ Strategy Pattern

เมื่อ logic เปลี่ยนได้หลายแบบ

abstract class ScoreCalculator {
int calculate(...);
}

เลือก strategy ตาม mode ของเกม

6️⃣ Aggregate (DDD) ↔ Facade Pattern

Aggregate Root ทำหน้าที่เหมือน facade

ป้องกันการเข้าถึง entity ข้างในตรง ๆ

คุม invariants

class GameRoom {
void submitAnswer(...) {}
}

7️⃣ Use Case (Clean / Application) ↔ Command Pattern

📍 อยู่ใน Behavioral Patterns

class SubmitAnswer {
Future<void> call(Params p);
}

หนึ่ง action = หนึ่ง object

เรียกใช้จาก UI

8️⃣ Infrastructure ↔ Adapter Pattern

สำคัญมาก!

class SupabaseAuthAdapter implements AuthRepository

Supabase = ของภายนอก

Adapter แปลงให้ domain ใช้ได้

🧠 สรุป Mapping สำคัญ (จำตารางนี้พอ)
DDD Concept Design Pattern
Repository Repository
Factory Factory Method
Domain Service Strategy
Aggregate Root Facade
Use Case Command
Infra Adapter Adapter
VO Value Object
❌ สิ่งที่ DDD ไม่ใช่

❌ DDD ≠ ใช้ pattern เยอะ ๆ

❌ DDD ≠ เขียน abstract ทุกอย่าง

❌ DDD ≠ folder เยอะ

❌ DDD ≠ clean code อัตโนมัติ

DDD คือ:

“วาง model ธุรกิจให้ถูก → แล้วเลือก pattern เท่าที่จำเป็น”

🎯 ตัวอย่างจากโปรเจกต์คุณ (เกมคิดเลขไว)
ปัญหา DDD บอก Pattern ที่ใช้
คิดคะแนน Domain Service Strategy
สร้างโจทย์ Factory Factory Method
ส่งคำตอบ Use Case Command
Backend เปลี่ยนได้ Repository Adapter
ห้องเกม Aggregate Facade
🧩 Mental Model จำง่ายมาก

DDD = แผนที่เมือง
Design Patterns = เครื่องมือก่อสร้าง

ถ้าไม่มี DDD → คุณสร้างตึกเก่ง แต่ไม่รู้จะสร้างอะไร
ถ้าไม่มี Pattern → คุณรู้ว่าจะสร้างอะไร แต่สร้างมั่ว

ถัดไปคุณอยากเจาะอะไรต่อ?

ผมช่วยต่อได้ เช่น:

อธิบาย DDD Tactical vs Strategic แบบง่ายมาก

เอา refactoring.guru มา mapping กับ Flutter project ของคุณทีละ pattern

Review โค้ดจริงของคุณว่า pattern ใช้ถูกไหม

อธิบาย “เมื่อไหร่ไม่ควรใช้ pattern”

Diagram ภาพรวม DDD + Clean + Patterns

เลือกข้อไหนได้เลยครับ 💡

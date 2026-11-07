## Схема бази даних

```mermaid
erDiagram
    users ||--o{ orders : "робить"
    orders ||--|{ order_items : "містить"

    users {
        int user_id PK
        varchar name
        varchar email
        date registration_date
        varchar city
    }
    orders {
        int order_id PK
        int user_id FK
        date order_date
        varchar status
        decimal total_amount
    }
    order_items {
        int item_id PK
        int order_id FK
        varchar product_name
        varchar category
        decimal price
        int quantity
    }
```
<img width="1056" height="400" alt="image" src="https://github.com/user-attachments/assets/45f94455-a5d7-4f0f-a658-58b19138d6fb" />
-- Електроніка лідирує і за доходом (17 950 грн, ≈43% від загального), і за кількістю проданих одиниць (11). Меблі продали лише 4 одиниці, але дохід майже такий же (15 401 грн), бо середній чек за одиницю значно вищий.
<img width="1618" height="582" alt="image" src="https://github.com/user-attachments/assets/d46080b4-f255-4a4b-bd0a-460af1f92527" />
-- У квітні дохід зріс на 36,3% відносно березня, у травні впав на 24,4%. Дані за червень охоплюють лише 1 день (одне замовлення), тому падіння на 83% не можна вважати реальною тенденцією.
<img width="1772" height="530" alt="image" src="https://github.com/user-attachments/assets/dc2965ee-dd23-4532-ac3a-37f098843e43" />
-- Чотири найбільші клієнти принесли ≈90% доходу (37 701 з 41 751 грн), тож бізнес залежить від невеликої групи покупців. Лідер: Олександр Петренко (10 050 грн).
<img width="1980" height="510" alt="image" src="https://github.com/user-attachments/assets/d939e990-b780-43f3-ba8f-ca947331b34e" />
-- 4 з 6 клієнтів потрапили в сегмент VIP (витрати від 8 000 грн), решта 2 в сегмент New. Сегмента Regular немає, тому пороги можна переглянути, якщо дані зміняться.




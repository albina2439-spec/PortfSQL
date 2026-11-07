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

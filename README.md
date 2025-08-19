# テーブル設計

## users テーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| nickname             | string  | null: false |
| email                | string  | null: false, unique: true |
| encrypted_password   | string  | null: false |

### Association
- has_many :recors
- has_many :archives
- has_many :sets, through: :records


## records テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| user               | references | null: false, foreign_key: true |
| date               | date       | null: false |
| workout_id         | integer    | null: false |
| body_goal_id       | integer    |

### Association
- belongs_to :user
- has_many   :sets



## sets テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| user               | references | null: false, foreign_key: true |
| record             | references | null: false, foreign_key: true |
| intervar           | references | null: false, foreign_key: true |
| weight             | integer    | null: false |
| rep                | integer    | null: false |

### Association
- belongs_to :user
- belongs_to :record



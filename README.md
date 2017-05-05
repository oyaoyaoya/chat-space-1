# README

## DB設計

### users table

| Column     | Type        | Option                                |
|:-----------|------------:|:-------------------------------------:|
| name       | string      | null: false,index: true              |
| email      | string      | null: false,unique: true, index: true |
| password   | string      | null: false                           |

#### Association
* has_many :messages
* has_many :groups,through: menmbers
* has_many :members

### messages table

| Column     | Type        | Option                      |
|:-----------|------------:|:---------------------------:|
| text       | text        |                             |
| image      | string      |                             |
| group_id   | integer     | null: false                 |
| user_id    | integer     | null: false                 |

#### Association
* belongs_to :users
* belongs_to :groups

### groups table

| Column     | Type        | Option                      |
|:-----------|------------:|:---------------------------:|
| name       | string      | null: false                 |

#### Association
* has_many :messages
* has_many :users, through: members
* has_many :members

### members table

| Column     | Type        | Option                      |
|:-----------|------------:|:---------------------------:|
| user_id    | integer     |                             |
| group_id   | integer     |                             |


#### Association
* belongs_to :user
* belongs_to :group

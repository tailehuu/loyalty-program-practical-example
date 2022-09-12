# Loyalty Program Practical Example

## Design

### Schema & Sample Data

**users**

| attribute  | type     | required | note                                             |
|------------|----------|----------|--------------------------------------------------|
| id         | integer  | YES      |
| name       | string   | YES      |
| dob        | string   |          |
| point      | integer  |          | Default is `0`                                   |
| tier       | string   |          | standard, gold or premium. Default is `standard` |
| currency   | string   | YES      | USD, EUR, SGD. Default is `USD`                  |
| created_at | datetime | YES      |
| updated_at | datetime | YES      |

**Sample date**

| id  | name  | dob        | point | currency | created_at          | updated_at          |
|-----|-------|------------|-------|----------|---------------------|---------------------|
| 1   | Tony  | 1981-04-18 | 0     | USD      | 2022-09-11 00:00:00 | 2022-09-11 00:00:00 |
| 2   | Wendy | 2015-02-05 | 0     | USD      | 2022-09-11 00:00:00 | 2022-09-11 00:00:00 |
| 3   | Jacky |            | 0     | USD      | 2022-09-11 00:00:00 | 2022-09-11 00:00:00 |

**transactions**

| attribute        | type     | required | note                           |
|------------------|----------|----------|--------------------------------|
| id               | integer  | YES      |
| user_id          | integer  | YES      |
| amount           | decimal  | YES      |
| currency         | string   | YES      |
| transaction_type | string   | YES      |
| status           | string   | YES      | pending, processing, processed |
| note             | text     |          |
| created_at       | datetime | YES      |
| updated_at       | datetime | YES      |

**Sample date**

| id  | user_id | amount | currency | transaction_type | status    | note       | created_at          | updated_at          |
|-----|---------|--------|----------|------------------|-----------|------------|---------------------|---------------------|
| 1   | 1       | 100    | USD      | BUY              | processed | Buy a cake | 2022-10-01 00:00:00 | 2022-10-01 00:00:00 |
| 2   | 1       | 50     | EUR      | BUY              | processed | Buy a book | 2022-10-02 00:00:00 | 2022-10-02 00:00:00 |

**points**

This table is intent to save user's point history

| attribute  | type     | required | note                             |
|------------|----------|----------|----------------------------------|
| id         | integer  | YES      |
| user_id    | integer  | YES      |
| point      | integer  | YES      |
| note       | text     | YES      | earn 10 points for spending $100 | 
| created_at | datetime | YES      |
| updated_at | datetime | YES      |

**Sample date**

| id  | user_id | point | note                                  | created_at          | updated_at          |
|-----|---------|-------|---------------------------------------|---------------------|---------------------|
| 1   | 1       | 10    | Earn 10 points when buy a cake        | 2022-10-01 00:00:30 | 2022-10-01 00:00:30 |
| 2   | 1       | 20    | Earn 20 points when buy a book in EUR | 2022-10-02 00:00:30 | 2022-10-02 00:00:30 |

**rewards**

| attribute  | type     | required |
|------------|----------|----------|
| id         | integer  | YES      |
| name       | string   | YES      |
| created_at | datetime | YES      |
| updated_at | datetime | YES      |

**Sample date**

| id  | name                            | created_at          | updated_at          |
|-----|---------------------------------|---------------------|---------------------|
| 1   | Free Coffee Reward              | 2022-09-11 00:00:00 | 2022-09-11 00:00:00 |
| 2   | 5% Cash Rebate Reward           | 2022-09-11 00:00:00 | 2022-09-11 00:00:00 |
| 3   | Free Movie Ticket Reward        | 2022-09-11 00:00:00 | 2022-09-11 00:00:00 |
| 4   | 4x Airport Lounge Access Reward | 2022-09-11 00:00:00 | 2022-09-11 00:00:00 |

**user_rewards**

| attribute  | type     | required | note               |
|------------|----------|----------|--------------------|
| id         | integer  | YES      |
| user_id    | integer  | YES      |
| reward_id  | integer  | YES      |
| status     | string   | YES      | pending, completed |
| created_at | datetime | YES      |
| updated_at | datetime | YES      |

**Sample date**

| id  | user_id | reward_id | status  | created_at          | updated_at          |
|-----|---------|-----------|---------|---------------------|---------------------|
| 1   | 1       | 1         | pending | 2022-09-11 00:00:00 | 2022-09-11 00:00:00 |

### Diagram

TBD

## Things to do

### Users

- Create user
- Get user's detail. ie: name, point, tier, rewards...

### Points

- PointEarningWorker: create point record
- PointExpiredWorker: reset point to zero every year

### Loyalty

Point to tier

    < 1_000:            standard
    >= 1_000 & < 5_000: gold
    >= 5_000:           premium

### Transactions

Workflow:

Create transaction => create point (async) => update user's tier (async)

### Reward

At the beginning of every month, let's call RewardWorker which will

- Give Free Coffee reward        if user.point >= 100
- Give Free Coffee reward        if user.dob == current month
- Give 5% Cash Rebate reward     if user.transactions.where(created_at: beginning_of_month..end_of_month).where('amount >= ?', 100) >= 10
- Give Free Movie Tickets reward if user.transactions.where(created_at: beginning_of_tx..beginning_of_tx_plus_60_days).sum(:amount) > = 1000





### Transaction

After create a `BUY` transaction, trigger `PointEarningWorker` which will do

    if transaction.currency != user.currency # foreign currency
        - new_point = user.point + 20
        - new_tier = new_point >= 5_000 ? 'platinum' : ( new_point >= 1_000 ? 'gold' : 'standard' )

        - user.points.create(point: 20)
        - user.update_attributes(point: new_point, tier: new_tier)
    elsif transaction.amount > 100
        - new_point = user.point + 20
        - new_tier = new_point >= 5_000 ? 'platinum' : ( new_point >= 1_000 ? 'gold' : 'standard' )

        - user.points.create(point: 10)
        - user.update_attributes(point: user.point + 10)
    end

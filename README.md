# Loyalty Program Practical Example

## Require

- Ruby `2.5.9`
- Rails `4.2.11.1`

## Proposal

Let's look at my proposal [here](https://github.com/tailehuu/loyalty-program-practical-example/wiki).

## How to use

### Open 1st terminal, start Clockwork to proceed scheduled worker

`bundle exec clockwork clockwork/cron.rb`

### Open 2nd terminal, start Sidekiq to execute job when enqueued

`bundle exec sidekiq`

### Open 3rd terminal, seed some users & rewards

`rake db:seed`

### Goto rails console then make some transactions
    
    $ rails console
    > user = User.first
    > user.transactions.create!(amount: 560, currency: 'USD', transaction_type: 'BUY', status: 'pending')
    > # wait some time for job is executed
    > # then see user's point
    > user

Thanks!
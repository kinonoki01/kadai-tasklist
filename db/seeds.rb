User.create(name: '111', email: '111@111.com', password: '111')
User.create(name: '222', email: '222@222.com', password: '222')
User.create(name: '333', email: '333@333.com', password: '333')
User.create(name: '444', email: '444@444.com', password: '444')

(1..100).each do |num|
  Task.create(content: 'タスク' + num.to_s, status: 'ステータス' + num.to_s, user_id: ((num % 4) + 1).to_s)
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

users = User.create!(
  [
    {email: 'takeru@test.com', name: 'たける', password: 'takerutakeru', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-mic.jpg"), filename:"sample-mic.jpg")},
    {email: 'chiyu@test.com', name: 'ちゆ', password: 'chiyuchiyu', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-base.jpg"), filename:"sample-base.jpg")},
    {email: 'shinpei@test.com', name: 'しんぺい', password: 'shinpeishsinpei', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-drum.jpg"), filename:"sample-drum.jpg")},
    {email: 'yuji@test.com', name: 'ユージ', password: 'yujiyuji', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-guitar.jpg"), filename:"sample-guitar.jpg")},
    {email: 'masato@test.com', name: 'まさと', password: 'masatomasato', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-guitar2.jpg"), filename:"sample-guitar2.jpg")},
    {email: 'mal@test.com', name: 'mal', password: 'malmal'},
    {email: 'hiro@test.com', name: 'hiro', password: 'hirohiro'}
  ]
)

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
    {email: 'takeru@test.com', name: 'たける', password: 'takerutakeru', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-mic.jpg"), filename:"sample-mic.jpg"), introduction: 'ロックが好きです！よろしくお願いします！'},
    {email: 'chiyu@test.com', name: 'ちゆ', password: 'chiyuchiyu', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-base.jpg"), filename:"sample-base.jpg"), introduction: 'ベース弾いてます！よろしくね〜'},
    {email: 'shinpei@test.com', name: 'しんぺい', password: 'shinpeishsinpei', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-drum.jpg"), filename:"sample-drum.jpg")},
    {email: 'yuji@test.com', name: 'ユージ', password: 'yujiyuji', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-guitar.jpg"), filename:"sample-guitar.jpg")},
    {email: 'masato@test.com', name: 'まさと', password: 'masatomasato', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-guitar2.jpg"), filename:"sample-guitar2.jpg")},
    {email: 'mal@test.com', name: 'mal', password: 'malmal'},
    {email: 'hiro@test.com', name: 'hiro', password: 'hirohiro'},
    {email: 'freeze@test.com', name: '凍結くん', password: 'freezefreeze', is_frozen: true},
    {email: 'unsubscribe@test.com', name: '退会くん', password: 'unsubscribe', is_deleted: true}
  ]
)

posts = Post.create!(
  [
    {body: "初めての投稿", user_id: users[0].id},
    {body: "J-POPやROCKをよく聞いてます!\n#JPOP #ROCK", user_id: users[0].id},
    {body: "初めての投稿!", user_id: users[1].id},
    {body: "AAバンドの新曲かっこいい！\n#AA", user_id: users[2].id},
    {body: "ギターが趣味です、よろしく！ #ギター", user_id: users[3].id},
    {body: "新しいベース欲しいな", user_id: users[1].id},
    {body: "流行の歌練習中！", user_id: users[3].id},
    {body: "ZZのギター好き！\n#ZZ #ROCK", user_id: users[4].id},
    {body: "XXがライブ決定！！！\n#XX", user_id: users[5].id},
    {body: "いいバンドいないかな〜\n#ROCK", user_id: users[6].id},
    {body: "歌詞が刺さる！\n#AA", user_id: users[2].id},
    {body: "ライブのチケット当たった！！！\n#XX", user_id: users[5].id}
  ]
)

tags = Tag.create!(
  [
    {body: "JPOP"},
    {body: "ROCK"},
    {body: "AA"},
    {body: "ギター"},
    {body: "ZZ"},
    {body: "XX"}
  ]
)

Tagging.create!(
  [
    {post_id: posts[1].id, tag_id: tags[0].id},
    {post_id: posts[1].id, tag_id: tags[1].id},
    {post_id: posts[3].id, tag_id: tags[2].id},
    {post_id: posts[4].id, tag_id: tags[3].id},
    {post_id: posts[7].id, tag_id: tags[4].id},
    {post_id: posts[7].id, tag_id: tags[1].id},
    {post_id: posts[8].id, tag_id: tags[5].id},
    {post_id: posts[9].id, tag_id: tags[1].id},
    {post_id: posts[10].id, tag_id: tags[2].id},
    {post_id: posts[11].id, tag_id: tags[5].id}
  ]
)

Comment.create!(
  [
    {comment: "AAっていうバンドがおすすめです！", user_id: users[2].id, post_id: posts[9].id},
    {comment: "いい歌詞ですよね！僕も好きです！！", user_id: users[0].id, post_id: posts[10].id},
    {comment: "おめでとう！", user_id: users[4].id, post_id: posts[11].id},
    {comment: "楽しみですね！！", user_id: users[3].id, post_id: posts[11].id}
  ]
)

Favorite.create!(
  [
    {user_id: users[2].id, post_id: posts[9].id},
    {user_id: users[0].id, post_id: posts[10].id},
    {user_id: users[4].id, post_id: posts[11].id},
    {user_id: users[3].id, post_id: posts[11].id}
  ]
)

groups = Group.create!(
  [
    {name: "AAバンド好きな人集まれ", introduction: "AAが好きな人、一緒に話しましょう！", owner_id: users[2].id},
    {name: "ROCK", introduction: "好きなバンドを教え合いましょう！", owner_id: users[0].id}
  ]
)

Entry.create!(
  [
    {user_id: users[2].id, group_id: groups[0].id},
    {user_id: users[6].id, group_id: groups[0].id},
    {user_id: users[0].id, group_id: groups[1].id},
    {user_id: users[2].id, group_id: groups[1].id},
    {user_id: users[4].id, group_id: groups[1].id},
    {user_id: users[5].id, group_id: groups[1].id}
  ]
)

Message.create!(
  [
    {message: "こんにちは！", user_id: users[2].id, group_id: groups[0].id},
    {message: "よろしく！", user_id: users[6].id, group_id: groups[0].id},
    {message: "よろしくね〜", user_id: users[0].id, group_id: groups[1].id},
    {message: "よろしく！", user_id: users[2].id, group_id: groups[1].id},
    {message: "初めまして！", user_id: users[4].id, group_id: groups[1].id},
    {message: "ZZのギターがかっこいいよ！", user_id: users[4].id, group_id: groups[1].id},
    {message: "AAっていうバンドの曲が、歌詞が良くておすすめです！", user_id: users[2].id, group_id: groups[1].id},
    {message: "XXのライブ当たったから、感想待っててね〜", user_id: users[5].id, group_id: groups[1].id},
    {message: "おめでとう！楽しんできてね〜", user_id: users[0].id, group_id: groups[1].id}
  ]
)

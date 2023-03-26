module Admin::PostsHelper

  # 投稿内のタグを押下するとそのタグを含む投稿の一覧を表示
  def render_with_admin_tags(body)
    return if body.nil?
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/admin/posts/tag/#{word.delete("#")}"}.html_safe
  end
end

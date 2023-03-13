module Admin::PostsHelper
  def render_with_admin_tags(body)
    return if body.nil?
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/admin/posts/tag/#{word.delete("#")}"}.html_safe
  end
end

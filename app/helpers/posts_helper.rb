module PostsHelper
	#def render_with_tags(tag_content)
		#tag_contentから正規表現でヒットする情報を取得、gsubで変換処理を行う
		#?tag_id=#{tag_id}でタグIDをリンクに組み込む
		#html_safeメソッドでエスケープ処理を回避、「#タグ」のリンクを表示する
		#tag_content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) {|word| link_to word, "/post/tag/#{word.delete("#")}"}.html_safe
	#end
end
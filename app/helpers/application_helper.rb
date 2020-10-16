module ApplicationHelper
	#現在時刻を基準とした相対時刻を表示
	def date_format(datetime)
		time_ago_in_words(datetime) + '前'
    end
end
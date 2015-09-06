module ApplicationHelper
	def fix_url(url)
		url.starts_with?("http://") ? url : "http://#{url}"
	end
	def display_time(t)
		t.strftime "%d %b, %Y %l:%M%P %Z"
	end
end

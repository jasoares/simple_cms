module SectionsHelper

	def content_type(section)
		if section.content_type.downcase === 'html'
			return 'HTML'
		else
			return 'Text'
		end
	end

	def show_content section
		if section.content.html_safe? && section.content_type === 'HTML'
			return raw(section.content)
		else
			return section.content
		end
	end

end

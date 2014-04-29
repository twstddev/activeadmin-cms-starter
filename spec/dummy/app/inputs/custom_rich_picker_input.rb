class CustomRichPickerInput < Formtastic::Inputs::RichPickerInput
	def preview_image_path
		method_value = object.send(method)

		# return placeholder image if this is a non-image picker OR if there is no value set
		return editor_options[:placeholder_image] if editor_options[:type].to_s == 'file'
		return editor_options[:placeholder_image] unless method_value.present?

		column = column_for( method )
		column_type = :string

		if column
			column_type = column_for(method).type
		end

		if column_type == :integer
			file = Rich::RichFile.find(method_value)
			file.rich_file.url(:ch_thumb) #we ask paperclip directly for the file, so asset paths should not be an issue
		else # should be :string
			method_value
		end
	end
end

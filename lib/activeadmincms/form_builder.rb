require "formtastic"

##
# @brief This class adds some extra functionality
# to handle custom fields for any model.
##
module MetaFormBuilder
	##
	# @brief Creates nested set of fields for custom fields.
	#
	# @param string association is the name of the 
	# nested fields fieldset
	##
	def has_many_meta( association, options = {}, &block )
		form_output = build_fields_group( association, "test", &block )

		form_output << template.content_tag( :li, create_add_fields_button( association, &block ), class: "has_many_container #{association}" ) 
		form_output
	end

	private
		def create_add_fields_button( association, &block )
			button_text = "Add #{association.to_s.singularize}"
			placeholder = "NEW_#{association.to_s.upcase.split( " " ).join( "_" )}_RECORD"

			form_fields = template.content_tag( :ol, build_fields_group( association, placeholder, &block ) ) 

			new_form = template.content_tag( :fieldset, form_fields, class: "inputs has_many_fields")

			template.link_to button_text, "#", class: "button has_many_add", data: { html: CGI.escapeHTML( new_form ).html_safe, placeholder: placeholder }
		end

		def build_fields_group( association, placeholder, &block )
			placeholder 
			semantic_fields_for association do |assoc|
				assoc.semantic_fields_for placeholder do |nested|
					block.call nested
				end
			end
		end
end

Formtastic::FormBuilder.send :include, MetaFormBuilder

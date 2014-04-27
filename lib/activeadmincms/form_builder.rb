require "formtastic"
require "active_admin/iconic"

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
		form_output = template.content_tag( :li, create_add_fields_button( association, &block ), class: "has_many_container #{association}", "data-sortable" => "position" ) 
		form_output
	end

	private
		##
		# @brief Creates an add button that creates
		# fieldset with nested fields.
		##
		def create_add_fields_button( association, &block )
			button_text = "Add #{association.to_s.singularize}"
			placeholder = "NEW_#{association.to_s.upcase.split( " " ).join( "_" )}_RECORD"

			new_form = build_fields_group( association, placeholder, &block )

			template.link_to button_text, "#", class: "button has_many_add", data: { html: CGI.escapeHTML( new_form ).html_safe, placeholder: placeholder }
		end

		##
		# @brief Outputs nested form HTML.
		##
		def build_fields_group( association, placeholder, &block )
			content = semantic_fields_for association do |assoc|
				assoc.semantic_fields_for placeholder do |nested|
					block.call nested
				end
			end

			content << create_remove_button
			content << create_drag_handler

			content = template.content_tag( :ol, content ) 
			content = template.content_tag( :fieldset, content, class: "inputs has_many_fields")

			content
		end

		##
		# @brief Creates a remove button that is used to
		# delete the current fieldset.
		##
		def create_remove_button
			template.content_tag( :li, template.link_to( "Remove", "#", class: "button has_many_remove" ) )
		end

		##
		# @brief Creates a drag handler that allows
		# change fieldsets position.
		##
		def create_drag_handler
			template.content_tag( :li, class: "handle" ) do
				ActiveAdmin::Iconic.icon :move_vertical
			end
		end
end

Formtastic::FormBuilder.send :include, MetaFormBuilder

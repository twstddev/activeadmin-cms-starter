class Page < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	validates :title, presence: true
	validates :slug, presence: true
	validates :slug, uniqueness: true
	validate :validate_template,
		:prepare_properties

	after_initialize :init

	serialize :properties, Hash

	##
	# @brief Contains the list of predefined templates, that
	# describe custom fields for a single model unit.
	# These template are used only in the admin panel and provide
	# fields to edit custom fields values.
	#
	# @return Hash the list of predefined templates
	##
	def self.templates
		{
			"Home" => "home",
			"About" => "about"
		}
	end

	##
	# @brief Tells friendly id when actually to generate
	# a slug for the page.
	##
	def should_generate_new_friendly_id?
		slug.blank?
	end

	private
		##
		# @brief Makes sure that passed template is on the list.
		##
		def validate_template
			unless template.empty? or self.class.templates.has_value? template
				errors.add( :template, "is not on the templates list" )
			end
		end

		def init
			self.template ||= ""
			self.slug ||= ""
		end

		def prepare_properties
			if !self.properties.is_a? Hash
				self.properties = {}
			end
		end
end

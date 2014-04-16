class Page < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	validates :title, presence: true
	validates :slug, presence: true
	validates :slug, uniqueness: true
	validate :validate_template

	before_validation :prepare_slug

	after_initialize :init

	def init
		self.template ||= ""
		self.slug ||= ""
	end

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
			"home" => "Home",
			"about" => "About"
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
			unless template.empty? or self.class.templates.include? template
				errors.add( :template, "is not on the templates list" )
			end
		end

		##
		# @brief Makes sure that empty slug is replaced with
		# one generated from the passed title.
		##
		def prepare_slug
			if slug.empty?
			end
		end
end

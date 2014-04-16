class Page < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	validates :title, presence: true
	validates :slug, presence: true
	validates :slug, uniqueness: true
	validate :validate_template

	after_initialize :init

	def init
		self.template ||= ""
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

	private
		##
		# @brief Makes sure that passed template is on the list.
		##
		def validate_template
			unless template.empty? or self.class.templates.include? template
				errors.add( :template, "is not on the templates list" )
			end
		end
end

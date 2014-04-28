json.array! @pages do |page|
	json.id page.id
	json.title page.title
	json.slug page.slug
	json.template page.template
	json.position page.position
	json.properties page.properties
end

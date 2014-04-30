json.menu_items @menus do |menu_item|
	json.id menu_item.id
	json.title menu_item.title
	json.url menu_item.url
	json.parent_id menu_item.parent_id
	json.position menu_item.position
end

json.pages @pages do |page|
	json.id page.id
	json.title page.title
	json.slug page.slug
	json.template page.template
	json.position page.position
	json.properties page.properties
end

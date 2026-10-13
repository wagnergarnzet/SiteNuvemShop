{% import "snipplets/navigation/hidden-menu-urls.tpl" as hidden_menu %}
<ul class="top-menu list-unstyled row align-items-center">
	{% for item in menus[settings.top_menu] if not (hidden_menu.is_hidden(item.url) | trim) %}
		<li class="top-menu-item ml-3">
	        <a class="top-menu-link" href="{{ item.url }}" {% if item.url | is_external %}target="_blank"{% endif %}>{{ item.name }}</a>
		</li>
	{% endfor %}
</ul>
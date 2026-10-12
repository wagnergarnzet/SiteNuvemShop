<ul class="top-menu list-unstyled row align-items-center">
	{% for item in menus[settings.top_menu] %}
		<li class="top-menu-item ml-3">
	        <a class="top-menu-link" href="{{ item.url }}" {% if item.url | is_external %}target="_blank"{% endif %}>{{ item.name }}</a>
		</li>
	{% endfor %}
</ul>
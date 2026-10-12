<ul class="footer-menu p-0 mb-4 mb-md-0 {% if menus[settings.footer_menu_secondary]|length > 10 %}multi-col{% endif %}">
	{% for item in menus[settings.footer_menu_secondary] %}
		<li class="footer-menu-item" data-component="menu.item">
	        <a class="footer-menu-link" href="{{ item.url }}" {% if item.url | is_external %}target="_blank"{% endif %}>{{ item.name }}</a>
		</li>
	{% endfor %}
</ul>
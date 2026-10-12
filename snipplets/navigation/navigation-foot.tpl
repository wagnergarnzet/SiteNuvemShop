{% if inline_menu %}
<ul class="footer-menu p-0 mb-4 mb-md-0 d-flex flex-column flex-md-row justify-content-center">
	{% for item in menus[settings.footer_menu] %}
		<li class="footer-menu-item px-2" data-component="menu.item">
	        <a class="footer-menu-link" href="{{ item.url }}" {% if item.url | is_external %}target="_blank"{% endif %}>{{ item.name }}</a>
		</li>
	{% endfor %}
</ul>
{% else %}
<ul class="footer-menu p-0 mb-4 mb-md-0 {% if menus[settings.footer_menu]|length > 10 %}multi-col{% endif %}">
	{% for item in menus[settings.footer_menu] %}
		<li class="footer-menu-item" data-component="menu.item">
	        <a class="footer-menu-link" href="{{ item.url }}" {% if item.url | is_external %}target="_blank"{% endif %}>{{ item.name }}</a>
		</li>
	{% endfor %}
</ul>
{% endif %}
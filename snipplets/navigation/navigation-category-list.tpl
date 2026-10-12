{% set desktop_nav = desktop_nav | default(false) %}

{% for category in categories[:5] %}
	{# asking for subcategories without images #}
	{% if category.subcategories(false) %}
    	<li class="{% if subitem %}nav-subitem{% endif %} nav-item navigation-banner {% if desktop_nav %}js-item-subitems-desktop nav-dropdown nav-item-desktop{% else %}p-0{% endif %} item-with-subitems" data-component="menu.item">
			<li class="nav-item {% if subitem %}nav-subitem{% endif %} {% if desktop_nav %}nav-item-desktop {% else %}p-0{% endif %}">
				<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ category.url }}">{{ category.name }}</a>
			</li>
			{% if not desktop_nav %}
				<div class="js-nav-list-toggle-accordion nav-item-container">
					<span class="js-toggle-page-accordion nav-list-arrow transition-soft">
						<svg class="icon-inline"><use xlink:href="#chevron-down"/></svg>
					</span>
				</div>
    		{% endif %}
		</li>
	{% else %}
		<li class="nav-item {% if subitem %}nav-subitem{% endif %} {% if desktop_nav %}nav-item-desktop{% else %}p-0{% endif %}" data-component="menu.item">
        	<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ category.url }}">{{ category.name }}</a>
        </li>
	{% endif %}
{% endfor %}
{% if category.subcategories|length > 5 %}
	<li class="nav-item" data-component="menu.item">
		<a class="category-more nav-list-link mt-2" href="{{ category.url }}">
			{{ "Ver todo" | translate }}
			<svg class="icon-inline icon-md"><use xlink:href="#chevron"/></svg>
		</a>
	</li>
{% endif %}
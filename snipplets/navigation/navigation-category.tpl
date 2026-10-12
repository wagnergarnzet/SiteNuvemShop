{% set desktop_nav = desktop_nav | default(false) %}

{% for category in categories %}
	{% if full_width %}
		{% if category.subcategories(false) %}
			<li class="nav-item item-with-subitems {% if desktop_nav %}nav-item-desktop{% endif %}" data-slug="{{ category.name|lower }}" data-component="menu.item">
				<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
					<a class="{% if not desktop_nav %}js-toggle-page-accordion{% endif %} nav-list-link {{ item.current ? 'selected' : '' }}" href="{% if desktop_nav %}{{ category.url }}{% else %}#{% endif %}">{{ category.name }}</a>
				</div>
				<ul class="nav-subitems {% if desktop_nav %}js-desktop-list-subcategories nav-list-subcategories{% else %}js-pages-accordion list-subitems nav-list-accordion{% endif %}" {% if not desktop_nav %}style="display:none;"{% endif %}>
					{% snipplet "navigation/navigation-category-list.tpl" with categories = category.subcategories %}
				</ul>
			</li>
		{% else %}
			<li class="nav-item mb-1 {% if desktop_nav %}nav-item-desktop{% endif %} sub" data-slug="{{ category.name|lower }}" data-component="menu.item">
				<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ category.url }}">{{ category.name }}</a>
			</li>
		{% endif %}
	{% else %}
		{% if category.subcategories(false) %}
			<li class="nav-item item-with-subitems {% if desktop_nav %}nav-item-desktop{% else %}p-0{% endif %} position-relative" data-slug="{{ category.name|lower }}" data-component="menu.item">
				<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
					<a class="{% if not desktop_nav %}js-toggle-page-accordion{% endif %} nav-list-link {{ item.current ? 'selected' : '' }}" href="{% if desktop_nav %}{{ category.url }}{% else %}#{% endif %}">

						{{ category.name }}

						{% if mobile_nav %}
							<span class="nav-list-arrow transition-soft">
								<svg class="icon-inline"><use xlink:href="#chevron-down"/></svg>
							</span>
						{% endif %}
						{% if not mobile_nav %}
							<span class="nav-list-arrow transition-soft arrow-right">
								<svg class="icon-inline"><use xlink:href="#chevron"/></svg>
							</span>
						{% endif %}    
					</a>
				</div>
				<ul class="nav-subitems {% if desktop_nav %}js-desktop-list-subcategories desktop-list-subitems nav-list-subcategories{% else %}js-pages-accordion{% endif %} list-subitems nav-list-accordion shadow-soft" {% if not desktop_nav %}style="display:none;"{% endif %}>
					{% snipplet "navigation/navigation-category.tpl" with categories = category.subcategories %}
				</ul>
			</li>
		{% else %}
			<li class="nav-item {% if desktop_nav %}nav-item-desktop{% else %}p-0{% endif %}" data-slug="{{ category.name|lower }}" data-component="menu.item">
				<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ category.url }}">{{ category.name }}</a>
			</li>
		{% endif %}
	{% endif %}
{% endfor %}
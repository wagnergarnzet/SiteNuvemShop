{% set desktop_nav = desktop_nav | default(false) %}
{% set mobile_nav = mobile_nav | default(false) %}
{% set subitem = subitem | default(false) %}
{% set departments = departments | default(false) %}
{% set departments_title = settings.departments_menu_title ? settings.departments_menu_title : 'Productos' | translate %}

{% set nav_departments = menus[settings.departments_menu] %}

<li class="{% if subitem %}nav-subitem{% endif %} nav-item navigation-banner {% if desktop_nav and not subitem %}js-item-subitems-desktop nav-dropdown{% endif %} {% if desktop_nav %}nav-item-desktop{% endif %} departments item-with-subitems {% if settings.menu_design == 'box' %}position-relative{% endif %}" data-slug="{{ item_slug }}" data-component="menu.item">
	<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
		<a class="{% if not desktop_nav %}js-toggle-page-accordion{% endif %} nav-list-link {% if settings.departments_uppercase %}text-uppercase{% endif %} {{ item.current ? 'selected' : '' }}" href="{% if desktop_nav %}{{ item.url }}{% else %}#{% endif %}">
			<span class="nav-list-arrow transition-soft mr-1">
				<svg class="icon-inline"><use xlink:href="#bars"/></svg>
			</span>
			{{ departments_title }}
		</a>
	</div>
	<div class="js-desktop-dropdown nav-dropdown-content desktop-dropdown shadow-soft {% if settings.menu_design == 'full' %}mega-menu{% endif %}">
		<ul class="desktop-list-subitems js-pages-accordion list-subitems nav-list-accordion flex-row">
			{% if settings.menu_design == 'full' %}
				{% if mobile_nav %}
					{% include 'snipplets/navigation/navigation-nav-list-full.tpl' with { 'navigation' : nav_departments, 'subitem' : true, 'mobile_nav' : true } %}
				{% else %}
					{% include 'snipplets/navigation/navigation-nav-list-full.tpl' with { 'navigation' : nav_departments, 'subitem' : true } %}
				{% endif %}
			{% else %}
				{% include 'snipplets/navigation/navigation-nav-list-box-sub.tpl' with {'desktop_nav': true, 'subitem' : true, 'navigation': nav_departments} %}
			{% endif %}
		</ul>
	</div>	
</li>

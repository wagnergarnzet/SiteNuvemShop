{% set desktop_nav = desktop_nav | default(false) %}
{% set mobile_nav = mobile_nav | default(false) %}
{% set subitem = subitem | default(false) %}
{% set departments = departments | default(false) %}

{% if not subitem %}
	{% set navigation = menus[settings.main_menu] %}
{% endif %}

{% set has_featured_link = settings.featured_link_url is not empty %}
{% if has_featured_link %}
	{% set featured_link_url = settings.featured_link_url | split('://') | last | split('/') | slice(1) | join('/') | trim('/') %}
{% endif %}

{% for item in navigation %}

	{% set link_url = item.url | split('://') | last | split('/') | slice(1) | join('/') | trim('/') %}
	{% if has_featured_link %}
		{% set featured_link_classes = link_url == featured_link_url ? 'js-nav-list-link-featured nav-list-link-featured' %}
	{% endif %}

	{% set item_slug = item.name|replace(" ","-")|lower %}
	{% if item.subitems %}
    	<li class="{% if subitem %}nav-subitem{% endif %} nav-item navigation-banner {% if desktop_nav %}js-item-subitems-desktop nav-dropdown nav-item-desktop{% endif %} item-with-subitems" data-slug="{{ item_slug }}" data-component="menu.item">

    		<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
	            <a class="{% if not desktop_nav %}js-toggle-page-accordion{% endif %} nav-list-link {{ item.current ? 'selected' : '' }} d-flex flex-row {% if settings.navigation_icons %}{% if settings.nav_icon_position == "above" %}flex-md-column{% else %}flex-md-row{% endif %}{% endif %} {{ featured_link_classes }}" href="{% if desktop_nav %}{{ item.url }}{% else %}#{% endif %}" data-url-cleaned="{{ link_url }}">
					
					{% if settings.navigation_icons %}
						{% for icon in settings.menu_icons %}
							{% set category_handle = icon.link | trim('/') | split('/') | last %}	
							{% set item_handle = item.url | trim('/') | split('/') | last %}
							{% if category_handle == item_handle %}
								<img src="{{ icon.image | static_url | settings_image_url('full') }}" class="category-icon mr-2 {% if settings.navigation_icons %}{% if settings.nav_icon_position == "above" %}mr-md-0 mb-md-1{% else %}mr-md-2{% endif %}{% endif %}" alt="{{ item.name }}">
							{% endif %}
						{% endfor %}
					{% endif %}

					{{ item.name }}
		            {% if not subitem or mobile_nav %}
			            <span class="nav-list-arrow transition-soft ml-2">
			            	<svg class="icon-inline icon-md"><use xlink:href="#chevron-down"/></svg>
			            </span>
			        {% endif %}
	        	</a>
	        </div>
	        {% if desktop_nav and not subitem %}<div class="js-desktop-dropdown nav-dropdown-content desktop-dropdown mega-menu">{% endif %}
				<ul class="{% if desktop_nav %}{% if not subitem %}desktop-list-subitems{% endif %}{% else %}js-pages-accordion{% endif %} nav-subitems list-subitems nav-list-accordion" {% if not desktop_nav %}style="display:none;"{% endif %}>
					{% if not desktop_nav and item.isCategory  %}
						<li class="nav-item nav-item-desktop sub" data-slug="{{ item.name|lower }}">
							<div class="nav-item-container">
								<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ item.url }}"><strong>{{ 'Todos los productos' | translate }}</strong></a>
							</div>
						</li>
					{% endif %}
					{% if mobile_nav %}
						{% include 'snipplets/navigation/navigation-nav-list-full.tpl' with { 'navigation' : item.subitems, 'subitem' : true, 'mobile_nav' : true  } %}
					{% else %}
						{% include 'snipplets/navigation/navigation-nav-list-full.tpl' with { 'navigation' : item.subitems, 'subitem' : true  } %}
					{% endif %}
				</ul>
			{% if desktop_nav and not subitem %}</div>{% endif %}
		</li>
	{% else %}
		<li class="nav-item {% if subitem %}nav-subitem{% endif %} {% if desktop_nav %}nav-item-desktop{% endif %}" data-slug="{{ item_slug }}" data-component="menu.item">
        	<a class="nav-list-link {{ item.current ? 'selected' : '' }} {{ featured_link_classes }}" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}" data-url-cleaned="{{ link_url }}">
			
					{% if settings.navigation_icons %}
						{% for icon in settings.menu_icons %}
							{% set category_handle = icon.link | trim('/') | split('/') | last %}	
							{% set item_handle = item.url | trim('/') | split('/') | last %}
							{% if category_handle == item_handle %}
								<img src="{{ icon.image | static_url | settings_image_url('full') }}" class="category-icon mr-2 {% if settings.navigation_icons %}{% if settings.nav_icon_position == "above" %}mr-md-0 mb-md-1{% else %}mr-md-2{% endif %}{% endif %}" alt="{{ item.name }}">
							{% endif %}
						{% endfor %}
					{% endif %}

			{{ item.name }}
			
			</a>
        </li>
	{% endif %}
{% endfor %}
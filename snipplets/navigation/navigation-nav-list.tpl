{% set desktop_nav = desktop_nav | default(false) %}
{% set mobile_nav = mobile_nav | default(false) %}
{% set subitem = subitem | default(false) %}
{% set mobile_menu = mobile_menu | default(false) %}
{% set mobile_menu_secondary = mobile_menu_secondary | default(false) %}

{% set menu_active = menus[settings.main_menu] %}


{% if mobile_menu %}
	{% set menu_active = menus[settings.mobile_menu] %}
{% endif %}
{% if mobile_menu_secondary %}
	{% set menu_active = menus[settings.mobile_menu_secondary] %}
{% endif %}

{% for item in menu_active %}
	{% if item.subitems %}
    	<li class="col flex-grow-0 nav-item {% if desktop_nav and not subitem %}js-item-subitems-desktop nav-dropdown{% endif %} {% if desktop_nav %}nav-item-desktop d-flex align-items-center justify-content-center{% else %}p-0{% endif %} item-with-subitems {% if subitem %}position-relative{% endif %}" data-slug="{{ item.name|lower }}" data-component="menu.item">
    		<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
          <a class="{% if not desktop_nav %}js-toggle-page-accordion{% endif %} nav-list-link {{ item.current ? 'selected' : '' }} d-flex flex-wrap flex-row {% if settings.navigation_icons %}{% if settings.nav_icon_position == "above" %}flex-md-column{% endif %}{% endif %} align-items-center" href="{% if desktop_nav %}{{ item.url }}{% else %}#{% endif %}">
					{% for icon in settings.menu_icons %}				
						{% set category_handle = icon.link | trim('/') | split('/') | last %}	
						{% set item_handle = item.url | trim('/') | split('/') | last %}
						{% if category_handle == item_handle %}
							<img src="{{ icon.image | static_url | settings_image_url('full') }}" class="category-icon mr-2 {% if settings.navigation_icons %}{% if settings.nav_icon_position == "above" %}mr-md-0 mb-md-1{% endif %}{% endif %}" alt="{{ item.name }}">
						{% endif %}
					{% endfor %}
					
					{% if subitem and not mobile_nav %}
						<span class="nav-list-arrow transition-soft arrow-left hidden">
							<svg class="icon-inline icon-md icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
						</span>
					{% endif %}

					{{ item.name }}

		            {% if not subitem or mobile_nav %}
						<span class="nav-list-arrow transition-soft ml-2">
			            	<svg class="icon-inline icon-md"><use xlink:href="#chevron-down"/></svg>
			            </span>
			        {% endif %}
					
					{% if subitem and not mobile_nav %}
						<span class="nav-list-arrow transition-soft arrow-right">
			            	<svg class="icon-inline icon-md"><use xlink:href="#chevron"/></svg>
			            </span>
					{% endif %}
	        	</a>
	        </div>
	        {% if desktop_nav %}{% if not subitem %}<div class="js-desktop-dropdown nav-dropdown-content desktop-dropdown shadow-soft">{% endif %}{% endif %}
				<ul class="{% if desktop_nav %}{% if not subitem %}desktop-list-subitems{% endif %}{% else %}js-pages-accordion{% endif %} list-subitems nav-list-accordion" {% if not desktop_nav %}style="display:none;"{% endif %}>
					{% if not desktop_nav and item.isCategory  %}
						<li class="nav-item nav-item-desktop">
				        	<a class="nav-list-link {{ item.current ? 'selected' : '' }}{% if settings.menu_uppercase %} text-uppercase{% endif %}" href="{{ item.url }}"><strong>{{ 'Ver todo en' | translate }} {{ item.name }}</strong></a>
				        </li>
			        {% endif %}
			        {% if mobile_nav %}
			        	{% include 'snipplets/navigation/navigation-nav-list-box-sub.tpl' with { 'navigation' : item.subitems, 'subitem' : true, 'mobile_nav' : true  } %}
			        {% else %}
						{% include 'snipplets/navigation/navigation-nav-list-box-sub.tpl' with { 'navigation' : item.subitems, 'subitem' : true  } %}
			        {% endif %}
					
				</ul>
			{% if desktop_nav %}{% if not subitem %}</div>{% endif %}{% endif %}
		</li>
	{% else %}
		<li class="col flex-grow-0 nav-item {% if desktop_nav %}nav-item-desktop d-flex align-items-center justify-content-center{% else %}p-0{% endif %}" data-component="menu.item">
        	<a class="nav-list-link d-flex flex-wrap flex-row {% if settings.navigation_icons %}{% if settings.nav_icon_position == "above" %}flex-md-column{% endif %}{% endif %} align-items-center {{ item.current ? 'selected' : '' }}" href="{{ item.url }}">
			
				{% for icon in settings.menu_icons %}				
					{% set category_handle = icon.link | trim('/') | split('/') | last %}	
					{% set item_handle = item.url | trim('/') | split('/') | last %}
					{% if category_handle == item_handle %}
						<img src="{{ icon.image | static_url | settings_image_url('full') }}" class="category-icon mr-2 {% if settings.nav_icon_position == "above" %}mr-md-0 mb-md-1{% endif %}" alt="{{ item.name }}">
					{% endif %}
				{% endfor %}
			
				{{ item.name }}
				
			</a>
        </li>
	{% endif %}
{% endfor %}
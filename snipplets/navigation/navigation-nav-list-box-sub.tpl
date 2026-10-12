{% set desktop_nav = desktop_nav | default(false) %}
{% set mobile_nav = mobile_nav | default(false) %}
{% set subitem = subitem | default(false) %}

{% for item in navigation %}
	{% set item_slug = item.name|replace(" ","-")|lower %}
	{% if item.subitems %}
    	<li class="{% if desktop_nav %}col {% endif %}nav-item position-relative{% if desktop_nav and not subitem %} js-item-subitems-desktop nav-dropdown{% endif %}{% if desktop_nav %} nav-item-desktop{% endif %} item-with-subitems" data-slug="{{ item_slug }}" data-component="menu.item">
    		<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
	            <a class="{% if not desktop_nav %}js-toggle-page-accordion{% endif %} nav-list-link {{ item.current ? 'selected' : '' }}" href="{% if desktop_nav %}{{ item.url }}{% else %}#{% endif %}">
					{% if subitem and not mobile_nav %}
						<span class="nav-list-arrow transition-soft arrow-left hidden">
							<svg class="icon-inline icon-md icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
						</span>
					{% endif %}

					{{ item.name }}

		            {% if not subitem or mobile_nav %}
			            <span class="nav-list-arrow transition-soft">
			            	<svg class="icon-inline icon-md"><use xlink:href="#chevron"/></svg>
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
				<ul class="{% if desktop_nav %}{% if not subitem %}desktop-list-subitems{% endif %}{% else %}js-pages-accordion{% endif %} list-subitems nav-list-accordion {% if not mobile_nav %}shadow-soft{% endif %}" {% if not desktop_nav %}style="display:none;"{% endif %}>
					{% if not desktop_nav and item.isCategory %}
						<li class="nav-item nav-item-desktop">
				        	<a class="nav-list-link {{ item.current ? 'selected' : '' }}{% if settings.menu_uppercase %} text-uppercase{% endif %}" href="{{ item.url }}"><strong>{{ 'Ver todo en' | translate }} {{ item.name }}</strong></a>
				        </li>
			        {% endif %}
			        {% if mobile_nav %}
			        	{% include 'snipplets/navigation/navigation-nav-list-box-sub.tpl' with { 'navigation' : item.subitems, 'subitem' : true, 'mobile_nav' : true} %}
			        {% else %}
						{% include 'snipplets/navigation/navigation-nav-list-box-sub.tpl' with { 'navigation' : item.subitems, 'subitem' : true} %}
			        {% endif %}
					
				</ul>
			{% if desktop_nav %}{% if not subitem %}</div>{% endif %}{% endif %}
		</li>
	{% else %}
		<li class="nav-item position-relative sub {% if desktop_nav %}nav-item-desktop{% endif %}" data-slug="{{ item_slug }}" data-component="menu.item">
        	<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ item.url }}">{{ item.name }}</a>
        </li>
	{% endif %}
{% endfor %}
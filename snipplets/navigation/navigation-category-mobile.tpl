{% set desktop_nav = desktop_nav | default(false) %}
{% set mobile_nav = mobile_nav | default(false) %}
{% set subcategory = subcategory | default(false) %}

{% for category in categories %}
	{% if category.subcategories %}
    	<li class="col {% if subcategory %}nav-subitem{% endif %} nav-item {% if settings.show_icon_mobile %}with-icon{% endif %} navigation-banner {% if desktop_nav %}js-item-subitems-desktop nav-item-desktop{% else %}p-0{% endif %} item-with-subitems {{ category.name|lower }}" data-component="menu.item">
    		<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
	            <a class="{% if not desktop_nav %}js-toggle-page-accordion{% endif %} nav-list-link {% if settings.show_icon_mobile %}d-flex align-items-center{% endif %}" href="{% if desktop_nav %}{{ category.url }}{% else %}#{% endif %}">
					{% if settings.show_icon_mobile %}
						{% for icon in settings.menu_icons %}				
							{% if icon.title == category.name %}
								<img src="{{ icon.image | static_url | settings_image_url('full') }}" class="category-icon mr-2" alt="{{ category.name }}">
							{% endif %}
						{% endfor %}
					{% endif %}
					{{ category.name }}
		            {% if not subcategory or mobile_nav %}
			            <span class="nav-list-arrow transition-soft">
			            	<svg class="icon-inline"><use xlink:href="#chevron-down"/></svg>
			            </span>
			        {% endif %}
	        	</a>
	        </div>
			<ul class="{% if desktop_nav %}{% if not subcategory %}desktop-list-subitems{% endif %}{% else %}js-pages-accordion{% endif %} nav-subitems list-subitems nav-list-accordion flex-row" {% if not desktop_nav %}style="display:none;"{% endif %}>
				<div class="col-12 {% if not desktop_nav %}p-0{% endif %}">
					<div class="pl-2 {% if mobile_nav %}submenu-mobile{% endif %}">
                        <li class="nav-item nav-item-desktop">
                            <div class="nav-item-container">
                                <a class="nav-list-link all-products {{ category.current ? 'selected' : '' }}" href="{{ category.url }}"><strong>{{ 'Todos los productos' | translate }}</strong></a>
                            </div>
                        </li>
						{% if mobile_nav %}
							{% include 'snipplets/navigation/navigation-category-mobile.tpl' with { categories : category.subcategories, 'subcategory' : true, 'mobile_nav' : true  } %}
						{% endif %}
					</div>
				</div>
			</ul>
		</li>
	{% else %}
		<li class="col nav-item {% if subcategory %}nav-subitem{% endif %}mb-1 {% if desktop_nav %}nav-item-desktop{% else %}p-0{% endif %}{% if settings.show_icon_mobile %} with-icon{% endif %} {{ category.name|lower }}" data-component="menu.item">
        	<a class="nav-list-link {{ category.current ? 'selected' : '' }} {% if settings.show_icon_mobile %}d-flex align-items-center{% endif %}" href="{{ category.url }}">
				{% if settings.show_icon_mobile %}
					{% for icon in settings.menu_icons %}				
						{% if icon.title == category.name %}
							<img src="{{ icon.image | static_url | settings_image_url('full') }}" class="category-icon mr-2" alt="{{ category.name }}">
						{% endif %}
					{% endfor %}
				{% endif %}
				{{ category.name }}
			</a>
        </li>
	{% endif %}
{% endfor %}
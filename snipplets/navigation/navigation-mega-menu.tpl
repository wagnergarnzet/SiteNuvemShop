{% set desktop_nav = desktop_nav | default(false) %}
{% set mobile_nav = mobile_nav | default(false) %}
{% set subitem = subitem | default(false) %}

{% for item in navigation %}
	{% if item.subitems %}
    	<li class="nav-item item-with-subitems {% if desktop_nav %}nav-item-desktop{% endif %}" data-component="menu.item">
    		<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
	            <a class="{% if not desktop_nav %}js-toggle-page-accordion{% endif %} nav-list-link {{ item.current ? 'selected' : '' }}" href="{% if desktop_nav %}{{ item.url }}{% else %}#{% endif %}">{{ item.name }}</a>
	        </div>
			<ul class="p-0 nav-subitems">
				{% for item in item.subitems %}
					<li class="nav-item nav-subitem">
						<a class="nav-list-link" href="{{ item.url }}">
							{{ item.name }}
						</a>
					</li>
				{% endfor %}
			</ul>
		</li>
	{% else %}
		<li class="nav-item {% if desktop_nav %}nav-item-desktop{% endif %}" data-component="menu.item">
        	<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ item.url }}">{{ item.name }}</a>
        </li>
	{% endif %}
{% endfor %}
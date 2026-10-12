{% set has_featured_link = settings.featured_link_url is not empty %}
{% if has_featured_link %}
    {% set featured_link_url = settings.featured_link_url | split('://') | last | split('/') | slice(1) | join('/') | trim('/') %}
{% endif %}

<div class="nav-desktop {% if settings.head_style %}head-{{ settings.head_style }}{% endif %} {% if settings.menu_design == 'full' %}nav-menu-full{% else %}nav-menu-box{% endif %} {% if settings.head_style == "style3" or settings.head_style == "style5" %}nav-short{% endif %}" data-featured-link="{{ has_featured_link ? 'true' : false }}" data-featured-link-url="{{ featured_link_url }}" data-featured-link-color="{{ settings.featured_link_color ? 'true' : 'false' }}">
    <ul class="js-nav-desktop-list nav-desktop-list d-none d-md-flex align-items-stretch text-center flex-wrap justify-content-{% if settings.desktop_nav_position == "center" %}center{% else %}between{% endif %}" data-store="navigation" data-component="menu">
        {% if settings.departments_show %}
            {% include 'snipplets/navigation/navigation-departments.tpl' with {'desktop_nav': true, 'departments': true} %}
        {% endif %}
        {% if settings.menu_design == 'full' %}
            {% include 'snipplets/navigation/navigation-nav-list-full.tpl' with {'desktop_nav': true} %}
        {% else %}
            {% include 'snipplets/navigation/navigation-nav-list-box.tpl' with {'desktop_nav': true} %}
        {% endif %}

    </ul>
</div>

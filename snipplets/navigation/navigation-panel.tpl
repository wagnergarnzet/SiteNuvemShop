{% if settings.search_position == 'menu' %}
    <div class="search-mobile">
        {% snipplet "header/header-search.tpl" %}
    </div>
{% endif %}
<div class="nav-primary">
    {% if settings.mobile_menu_label %}
    <h3 class="menu-section-title">{{ settings.mobile_menu_label }}</h3>
    {% endif %}
    <ul class="nav-list" data-store="navigation" data-component="menu">
        {% if settings.mobile_menu %}
            {% include 'snipplets/navigation/navigation-nav-list.tpl' with {mobile_nav : true, mobile_menu : true} %}
        {% else %}
            {% include 'snipplets/navigation/navigation-category-mobile.tpl' with {'mobile_nav': true} %}
        {% endif %}
    </ul>
</div>
{% if settings.second_mobile_active %}
<div class="nav-secondary">
    {% if settings.mobile_menu_label_secondary %}
    <h3 class="menu-section-title">{{ settings.mobile_menu_label_secondary }}</h3>
    {% endif %}
    <ul class="nav-list">
        {% if settings.mobile_menu_secondary %}
            {% include 'snipplets/navigation/navigation-nav-list.tpl' with {mobile_nav : true, mobile_menu_secondary : true} %}
        {% endif %}
    </ul>
</div>
{% endif %}
{% if settings.mobile_menu_contacts or settings.mobile_menu_social %}
    <div class="nav-secondary">
        {% if settings.mobile_menu_contacts_label %}
            <h3 class="menu-section-title">{{ settings.mobile_menu_contacts_label }}</h3>
        {% endif %}
        {% if settings.mobile_menu_contacts %}
            {% include "snipplets/contact-links.tpl" %}
        {% endif %}
        {% if settings.mobile_menu_social %}
            <div class="px-3">{% include "snipplets/social/social-links.tpl" %}</div>
        {% endif %}
    </div>
{% endif %}
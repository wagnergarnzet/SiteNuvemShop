{% set menu_icon_option = settings.mobile_menu_icon %}
{% set whatsapp_format = settings.top_whatsapp_format %}

{% set mobile_menu_icon %}
    {% if menu_icon_option == 'bars' %}
        <svg class="icon-inline icon-2x mr-2"><use xlink:href="#bars"></use></svg>
    {% else %}
        <svg class="icon-inline icon-2x mr-2"><use xlink:href="#menu"></use></svg>
    {% endif %}
{% endset %}

{# Site Overlay #}
<div class="js-menu-overlay menu-overlay" style="display: none;"></div>

{# Header #}

{% set show_transparent_head = template == 'home' and settings.head_transparent and settings.slider and not settings.slider is empty %}

{# Header colors dynamic classes #}

{% set header_colors_classes = settings.header_colors ? 'head-colors' : '' %}

{# Advertising #}

{% if settings.ad_bar_show %}
    {% snipplet "header/header-advertising.tpl" %}
{% endif %}

{% include "snipplets/notification.tpl" with {order_notification: true} %}

<header class="js-head-main head-main {{ header_colors_classes }} {% if show_transparent_head %}head-transparent head-absolute {% if settings.head_fix_desktop %}head-transparent-fixed{% else %}head-transparent-absolute{% endif %}{% endif %}" data-store="head">
    {% if settings.head_background or settings.head_background_mobile %}
        <div class="header-background">
    {% endif %}

    {% set has_social_network = store.facebook or store.twitter or store.pinterest or store.instagram %}
    {% set show_top_bar = settings.top_bar and (store.phone or store.email and has_social_network) %}
    {% if show_top_bar %}
    <div class="js-contact-bar contact-bar d-none d-md-block">
        <div class="container">
            <div class="row d-none d-md-flex no-gutters">
                <div class="col col-md-auto d-flex align-items-center">
                    {% if store.whatsapp and settings.top_whatsapp %}
                        <div class="utilities-item utilities-text d-flex align-items-center">
                            <svg class="icon-inline icon-1x mr-1"><use xlink:href="#whatsapp"/></svg>
                            <a href="{{ store.whatsapp }}{% if settings.wpp_message %}?text={{ settings.wpp_message }}{% endif %}" target="_blank" class="contact-link {% if whatsapp_format == "number" %} contact-whatsapp{% endif %}">{% if settings.top_whatsapp_format == 'number' %}{{ store.whatsapp | trim('/') | split('/') | last }}{% else %}WhatsApp{% endif %}</a>
                        </div>
                    {% endif %}
                    {% if store.phone and settings.top_phone %}
                        <div class="utilities-item utilities-text d-flex align-items-center">
                            <svg class="icon-inline icon-1x mr-1"><use xlink:href="#phone"/></svg>
                            <a href="tel:{{ store.phone }}" class="contact-link">{{ store.phone }}</a>
                        </div>
                    {% endif %}
                    {% if store.email and settings.top_email %}
                        <div class="utilities-item utilities-text d-flex align-items-center">
                            <svg class="icon-inline icon-1x mr-1"><use xlink:href="#icon-email"/></svg>
                            <a href="mailto:{{ store.email }}" class="contact-link">{{ store.email }}</a>
                        </div>
                    {% endif %}
                </div>
                <div class="col col-md text-right d-flex align-items-center justify-content-end">
                    {% if settings.top_menu_show %}
                    {# Menu #}
                    <div class="col-auto utilities-item">
                        {% include "snipplets/navigation/navigation-top.tpl" %}
                    </div>
                    {% endif %}
                    {# Social #}
                    {% if has_social_network and settings.top_social %}
                        <div class="utilities-item pl-3 {% if languages | length > 1 %}pr-1{% else %}pr-0{% endif %} d-none d-lg-inline-flex">
                            {% include "snipplets/social/social-links.tpl" %}
                        </div>
                    {% endif %}
                    {% include "snipplets/languages.tpl" %}
                </div>
            </div>
        </div>
    </div>
    {% endif %}

    {% if settings.head_style == "style2" %}
        <div class="d-none d-md-block header-logo-row">
            <div class="container">
                <div class="js-head-logo row no-gutters align-items-center justify-content-between justify-content-md-center position-relative">
                    <div class="col d-none d-md-inline-flex">
                        <div class="utilities-item d-none d-md-inline-block d-lg-none">
                            <div class="head-search-icon">
                                <a href="#" class="js-modal-open js-toggle-search js-fullscreen-modal-open js-search-link" data-toggle="#nav-search" data-modal-url="modal-fullscreen-search">
                                    <svg class="icon-inline icon-1x svg-icon-secondary"><use xlink:href="#search"/></svg>
                                </a>
                            </div>
                        </div>
                        <div class="d-none d-lg-block search-wrapper">
                            {% snipplet "header/header-search.tpl" %}
                        </div>
                    </div>
                    <div class="centered-logo-logo col text-center">{% snipplet "header/header-logo.tpl" %}</div>
                    <div class="centered-logo-utilities col h-col d-block text-right">
                        {% snipplet "header/header-utilities.tpl" %}
                    </div>
                </div>
            </div>
        </div>
    {% elseif settings.head_style == "style3" %}
        <div class="d-none d-md-block header-logo-row">
            <div class="container">
                <div class="js-head-logo row align-items-center justify-content-between">
                    <div class="d-lg-none col h-col">
                        {# Navigation mobile #}
                        <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                            {{ mobile_menu_icon }}
                        </a>
                    </div>
                    <div class="col col-lg-auto text-center text-md-left">{% snipplet "header/header-logo.tpl" %}</div>
                    <div class="col d-none d-lg-block">
                        {% snipplet "navigation/navigation.tpl" %}
                    </div>
                    <div class="col col-lg-auto h-col d-block text-right">
                        {% include "snipplets/header/header-utilities.tpl" with {'subutilities': true} %}
                    </div>
                </div>
            </div>
        </div>
    {% elseif settings.head_style == "style4" %}
        <div class="d-none d-md-block header-logo-row">
            <div class="container">
                <div class="js-head-logo row align-items-center justify-content-between justify-content-md-center{% if settings.centered_logo %} position-relative{% endif %}">
                    <div class="col h-col">
                        {# Navigation mobile #}
                        <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                            {{ mobile_menu_icon }}
                            <strong>{{ 'Menú' | translate }}</strong>
                        </a>
                    </div>
                    <div class="centered-logo-logo col text-center">{% snipplet "header/header-logo.tpl" %}</div>
                    <div class="centered-logo-utilities col h-col d-block text-right">
                        {% include "snipplets/header/header-utilities.tpl" with {'subutilities': true} %}
                    </div>
                </div>
            </div>
        </div>
    {% elseif settings.head_style == "style5" %}
        <div class="d-none d-md-block header-logo-row header-style5" data-menu="{{ settings.menu_design == "box" ? 'box' : 'full' }}">
            <div class="container">
                <div class="js-head-logo row align-items-center justify-content-between">
                    <div class="d-lg-none col h-col">
                        {# Navigation mobile #}
                        <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                            {{ mobile_menu_icon }}
                        </a>
                    </div>
                    <div class="col col-lg-auto text-center text-md-left">{% snipplet "header/header-logo.tpl" %}</div>
                    <div class="col d-none d-lg-block navigation-col">
                        {% snipplet "navigation/navigation.tpl" %}
                    </div>
                    <div class="col-auto d-none d-md-block">
                        {% snipplet "header/header-search.tpl" %}
                    </div>
                    <div class="col col-lg-auto h-col d-block text-right">
                        {% include "snipplets/header/header-utilities.tpl" with {'subutilities': true} %}
                    </div>
                </div>
            </div>
        </div>        
    {% else %}
        <div class="d-none d-md-block header-logo-row">
            <div class="container">
                <div class="js-head-logo row align-items-center justify-content-between justify-content-md-center">
                    <div class="d-md-none col h-col">
                        {# Navigation mobile #}
                        <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center d-md-none" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                            {{ mobile_menu_icon }}
                        </a>
                    </div>
                    <div class="col col-md-auto text-center text-md-left">
                        {% snipplet "header/header-logo.tpl" %}
                    </div>
                    <div class="col d-none d-md-block">
                        {% snipplet "header/header-search.tpl" %}
                    </div>
                    <div class="col col-md-auto h-col d-block text-right">
                        {% snipplet "header/header-utilities.tpl" %}
                    </div>
                </div>
            </div>
        </div>
    {% endif %}
    
    {# Menu mobile #}
    <div class="d-block d-md-none header-logo-row">
        <div class="container">
            <div class="js-head-logo row no-gutters align-items-center justify-content-between justify-content-md-center">
                <div class="col-2 h-col">
                    {# Navigation mobile #}
                    <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                        {{ mobile_menu_icon }}
                    </a>
                </div>
                <div class="col col-md-auto text-center text-md-left">{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}</div>
                {% if settings.search_position == 'cart' %}
                <div class="head-search-icon px-1">
                    <a href="#" class="js-modal-open js-toggle-search js-fullscreen-modal-open js-search-link" data-toggle="#nav-search" data-modal-url="modal-fullscreen-search">
                        <svg class="icon-inline icon-2x"><use xlink:href="#search"/></svg>
                    </a>
                </div>
                {% endif %}
                <div class="{% if settings.search_position == 'cart' %}col-auto pl-1{% else %}col-2{% endif %} col-md-auto h-col d-block text-right">
                    {% snipplet "header/header-utilities.tpl" %}
                </div>
            </div>
        </div>
    </div>

    {% if settings.head_style == "style1" or settings.head_style == "style2" %}
        <section class="main-menu d-none d-md-block">
            <div class="container">
                {% snipplet "navigation/navigation.tpl" %}
            </div>
        </section>
    {% endif %}
    {% if settings.search_position == 'default' %}
        <section class="search-mobile d-block d-md-none">
            {% snipplet "header/header-search.tpl" %}
        </section>
    {% endif %}
    {% if settings.head_background or settings.head_background_mobile %}
        </div>
    {% endif %}
</header>

{{ component('nubesdk-slot', { type: "after_header" }) }}

{% if settings.head_fix_desktop %}
    <header class="js-head-fixed header-fixed {{ header_colors_classes }}">
        {% if settings.head_background or settings.head_background_mobile %}
            <div class="header-background">
        {% endif %}
        {% if settings.head_style == "style2" %}
            <div class="d-none d-md-block header-logo-row">
                <div class="container">
                    <div class="js-head-logo row no-gutters align-items-center justify-content-between justify-content-md-center position-relative">
                        <div class="col d-none d-md-inline-flex align-items-center">
                            {# Navigation mobile #}
                            <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                                {{ mobile_menu_icon }}
                            </a>
                            <div class="utilities-item d-none d-md-inline-block d-lg-none">
                                <div class="head-search-icon">
                                    <a href="#" class="js-modal-open js-toggle-search js-fullscreen-modal-open js-search-link" data-toggle="#nav-search" data-modal-url="modal-fullscreen-search">
                                        <svg class="icon-inline icon-1x svg-icon-secondary"><use xlink:href="#search"/></svg>
                                    </a>
                                </div>
                            </div>
                            <div class="d-none d-lg-block search-wrapper">
                                {% snipplet "header/header-search.tpl" %}
                            </div>
                        </div>
                        <div class="centered-logo-logo col text-center">{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}</div>
                        <div class="centered-logo-utilities col h-col d-block text-right">
                            {% snipplet "header/header-utilities.tpl" %}
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-md-none header-logo-row">
                <div class="container">
                    <div class="js-head-logo row no-gutters align-items-center justify-content-between justify-content-md-center{% if settings.centered_logo %} position-relative{% endif %}">
                        <div class="d-md-none col h-col">
                            {# Navigation mobile #}
                            <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center d-md-none" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                                {{ mobile_menu_icon }}
                            </a>
                        </div>
                        <div class="col col-md-auto text-center text-md-left">{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}</div>
                        <div class="col d-none d-md-block">
                            {% snipplet "header/header-search.tpl" %}
                        </div>
                        <div class="col col-md-auto h-col d-block text-right">
                            {% snipplet "header/header-utilities.tpl" %}
                        </div>
                    </div>
                </div>
            </div>
        {% elseif settings.head_style == "style3" %}
            <div class="header-logo-row">
                <div class="container">
                    <div class="js-head-logo row no-gutters align-items-center justify-content-between justify-content-md-center{% if settings.centered_logo %} position-relative{% endif %}">
                        <div class="col h-col">
                            {# Navigation mobile #}
                            <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                                {{ mobile_menu_icon }}
                            </a>
                        </div>
                        <div class="col text-center">{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}</div>
                        <div class="col h-col d-block text-right">
                            {% include "snipplets/header/header-utilities.tpl" with {'subutilities': true} %}
                        </div>
                    </div>
                </div>
            </div>
        {% elseif settings.head_style == "style4" %}
            <div class="d-none d-md-block header-logo-row">
                <div class="container">
                    <div class="js-head-logo row no-gutters align-items-center justify-content-between justify-content-md-center">
                        <div class="col h-col">
                            {# Navigation mobile #}
                            <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                                {{ mobile_menu_icon }}
                                <strong>{{ 'Menú' | translate }}</strong>
                            </a>
                        </div>
                        <div class="centered-logo-logo col text-center">{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}</div>
                        <div class="centered-logo-utilities col h-col d-block text-right">
                            {% include "snipplets/header/header-utilities.tpl" with {'subutilities': true} %}
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-md-none header-logo-row">
                <div class="container">
                    <div class="js-head-logo row no-gutters align-items-center justify-content-between justify-content-md-center">
                        <div class="d-md-none col-2 h-col">
                            {# Navigation mobile #}
                            <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center d-md-none" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                                {{ mobile_menu_icon }}
                            </a>
                        </div>
                        <div class="col col-md-auto text-center text-md-left">{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}</div>
                        <div class="col d-none d-md-block">
                            {% snipplet "header/header-search.tpl" %}
                        </div>
                        <div class="col-2 col-md-auto h-col d-block text-right">
                            {% snipplet "header/header-utilities.tpl" %}
                        </div>
                    </div>
                </div>
            </div>
        {% elseif settings.head_style == "style5" %}
            <div class="header-logo-row">
                <div class="container">
                    <div class="js-head-logo row align-items-center justify-content-between justify-content-md-center">
                        <div class="col-2 col-md-auto h-col">
                            {# Navigation mobile #}
                            <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                                {{ mobile_menu_icon }}
                            </a>
                        </div>
                        <div class="col col-md-auto text-center text-md-left">{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}</div>
                        <div class="col d-none d-md-block">
                            {% snipplet "header/header-search.tpl" %}
                        </div>
                        <div class="col-2 col-md-auto h-col d-block text-right">
                            {% include "snipplets/header/header-utilities.tpl" with {'subutilities': true} %}
                        </div>
                    </div>
                </div>
            </div>            
        {% else %}
            <div class="header-logo-row">
                <div class="container">
                    <div class="js-head-logo row align-items-center justify-content-between justify-content-md-center">
                        <div class="col-2 col-md-auto h-col">
                            {# Navigation mobile #}
                            <a href="#" class="js-modal-open btn btn-hamburger d-flex align-items-center justify-content-center" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
                                {{ mobile_menu_icon }}
                            </a>
                        </div>
                        <div class="col col-md-auto text-center text-md-left">{% include "snipplets/header/header-logo.tpl" with {fixed_header: true} %}</div>

                        {% if settings.search_position == 'cart' %}
                            <div class="d-block d-md-none head-search-icon px-1">
                                <a href="#" class="js-modal-open js-toggle-search js-fullscreen-modal-open js-search-link" data-toggle="#nav-search" data-modal-url="modal-fullscreen-search">
                                    <svg class="icon-inline icon-2x"><use xlink:href="#search"/></svg>
                                </a>
                            </div>
                        {% endif %}

                        <div class="col d-none d-md-block">
                            {% snipplet "header/header-search.tpl" %}
                        </div>

                        <div class="{% if settings.search_position == 'cart' %}col-auto pl-1{% else %}col-2{% endif %} col-md-auto h-col d-block text-right">
                            {% snipplet "header/header-utilities.tpl" %}
                        </div>
                    </div>
                </div>
            </div>
        {% endif %}
        {% if settings.head_background or settings.head_background_mobile %}
            </div>
        {% endif %}
    </header>
{% endif %}

{# Show cookie validation message #}

{% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

{# Add to cart notification #}

{% if settings.ajax_cart %}
    {% if not settings.head_fix_desktop %}
        <div class="d-block d-md-none">
    {% endif %}
            {% include "snipplets/notification.tpl" with {add_to_cart: true} %}
    {% if not settings.head_fix_desktop %}
        </div>
    {% endif %}
{% endif %}

{# Add to cart notification for non fixed header #}

{% if settings.ajax_cart and not settings.head_fix_desktop %}
    <div class="{{ show_block_desktop_hide_mobile_class }}">
        {% include "snipplets/notification.tpl" with {add_to_cart: true, add_to_cart_fixed: true} %}
    </div>
{% endif %}

{# Cross selling promotion notification on add to cart #}

{% embed "snipplets/modal.tpl" with {
    modal_id: 'js-cross-selling-modal',
    modal_class: 'bottom modal-bottom-sheet h-auto overflow-none modal-body-scrollable-auto',
    modal_header: true,
    modal_header_class: 'w-100',
    modal_position: 'bottom',
    modal_transition: 'slide',
    modal_footer: true,
    modal_width: 'centered-md m-0 p-0 modal-full-width modal-md-width-400px'
} %}
    {% block modal_head %}
        {{ '¡Descuento exclusivo!' | translate }}
    {% endblock %}

    {% block modal_body %}
        {# Promotion info and actions #}

        <div class="js-cross-selling-modal-body" style="display: none"></div>
    {% endblock %}
{% endembed %}

{% include "snipplets/header/header-modals.tpl" %}

{# Hamburger panel #}
{% embed "snipplets/modal.tpl" with{modal_id: 'nav-hamburger', modal_class: 'nav-hamburger nav-hamburger modal-docked-small head-' ~ settings.head_background, modal_position: 'left', modal_transition: 'slide', modal_width: 'full', modal_title_class: 'd-flex justify-content-between align-items-center', modal_show_languages: true, modal_no_close: true} %}
    {% block modal_head %}
        {% block page_header_text %}
        <div class="nav-account">
            {% if not customer %}
                <div class="d-inline-flex align-items-center">
                    <a href="{{ store.customer_login_url }}" class="nav-accounts-link">
                        <svg class="icon-inline mr-2 svg-icon-background"><use xlink:href="#enter"/></svg>
                        {{ "Entrar" | translate }}
                    </a>
                </div>
            {% else %}
                <div class="d-inline-flex align-items-center">
                    <a href="{{ store.customer_home_url }}" class="nav-accounts-link">
                        <svg class="icon-inline mr-2 svg-icon-background"><use xlink:href="#enter"/></svg>
                        {{ "Mi cuenta" | translate }}
                    </a>
                </div>
            {% endif %}
        </div>
        {% if customer %}
            <a href="{{ store.customer_logout_url }}" class="btn-logout font-small">{{ "Cerrar sesión" | translate }}</a>
        {% endif %}
        {% endblock %}
    {% endblock %}
    {% block modal_body %}
        {% snipplet "navigation/navigation-panel.tpl" %}
    {% endblock %}
    {% block modal_languages %}
        <div class="languages row no-gutters align-items-center">
            <div class="col-auto">{{ "Elegí el idioma" | translate }}</div>
            <div class="col pl-3">
            {% for language in languages %}
                {% set class = language.active ? "active" : "opacity-50" %}
                {% if settings.language_icons %}
                    <a href="{{ language.url }}" class="{{ class }} d-inline-block pr-2">
                        <div class="flag">
                            {% if language.country == "BR" %}
                                <img class="lazyload" width="24" height="18" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/br.svg' | static_url }}" alt="{{ language.name }}" />
                            {% elseif language.country == "AR" %}
                                <img class="lazyload" width="24" height="18" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/ar.svg' | static_url }}" alt="{{ language.name }}" />
                            {% elseif language.country == "US" %}
                                <img class="lazyload" width="24" height="18" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/en.svg' | static_url }}" alt="{{ language.name }}" />                                
                            {% else %}
                                <img class="lazyload" width="24" height="18" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" />
                            {% endif %}
                        </div>
                    </a>
                {% else %}
                <a href="{{ language.url }}" class="{{ class }} px-2">{{ language.country }}</a>
                {% endif %}
            {% endfor %}
            </div>
        </div>
    {% endblock %}
{% endembed %}

{# Modal Search #}

{% embed "snipplets/modal.tpl" with{modal_id: 'nav-search',modal_class: 'nav-search', modal_header_class: 'd-none', modal_body_class: 'p-0 h-100',  modal_transition: 'fade', modal_header_title: false, modal_mobile_full_screen: true} %}
    {% block modal_body %}
        {% include "snipplets/header/header-search.tpl" with {search_modal: true} %}
    {% endblock %}
{% endembed %}

{# Modal Cart #}

{% if not store.is_catalog and settings.ajax_cart and template != 'cart' %}           

    {# Cart Ajax #}

    {% embed "snipplets/modal.tpl" with{modal_id: 'modal-cart', modal_position: 'right', modal_transition: 'slide', modal_class: 'cart-big modal-cart shadow-longer', modal_width: 'docked-md', modal_form_action: store.cart_url, modal_form_class: 'js-ajax-cart-panel', modal_mobile_full_screen: true, modal_form_hook: 'cart-form' } %}
        {% block modal_head %}
            {% block page_header_text %}
            <div class="d-inline-flex align-items-center">
                {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-background icon-1x pr-2"} %}
                {{ "Mis Compras" | translate }}
            </div>
            {% endblock page_header_text %}
        {% endblock %}
        {% block modal_body %}
            {% snipplet "cart-panel.tpl" %}
        {% endblock %}
    {% endembed %}

    {% if settings.add_to_cart_recommendations %}

        {# Recommended products on add to cart #}

        {% embed "snipplets/modal.tpl" with{modal_id: 'related-products-notification', modal_class: 'bottom modal-overflow-none modal-bottom-sheet h-auto', modal_header_class: 'modal-header-reverse', modal_position: 'bottom', modal_position_desktop: 'centered', modal_transition: 'slide', modal_width: 'centered-md modal-centered-md-600px h-auto'} %}
            {% block modal_head %}
                {% block page_header_text %}{{ '¡Agregado al carrito!' | translate }}{% endblock page_header_text %}
            {% endblock %}
            {% block modal_body %}

                {# Product added info #}

                {% include "snipplets/notification-cart.tpl" with {related_products: true} %}

                <div class="divider mb-3"></div>

                {# Product added recommendations #}

                <div class="js-related-products-notification-container" style="display: none"></div>

            {% endblock %}
        {% endembed %}
    {% endif %}

{% endif %}
{% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
    {% block page_header_text %}{{ "Carrito" | translate }}{% endblock page_header_text %}
{% endembed %}

<div id="shoppingCartPage" class="container" data-minimum="{{ settings.cart_minimum_value }}" data-store="cart-page">
    <form action="{{ store.cart_url }}" method="post" id="ajax-cart-details" class="js-ajax-cart-panel cart-page" data-component="cart">
        <div class="cart-page-body row my-md-5">
            {% if settings.cart_banner_show %}
                <div class="d-block d-md-none">
                    {% include "snipplets/cart-banner.tpl" %}
                </div>
            {% endif %}
            <div class="col-md-8 cart-page-list">
                {% if cart.items %}

                    {{ component('nubesdk-slot', { type: "before_line_items" }) }}

                    <div class="js-ajax-cart-list cart-row">
                        {# Cart panel items #}
                        {% if cart.items %}
                          {% for item in cart.items %}
                            {% include "snipplets/cart-item-ajax.tpl" with {'cart_page': true} %}
                          {% endfor %}
                        {% endif %}
                    </div>

                    {{ component('nubesdk-slot', { type: "after_line_items" }) }}

                {% else %}
                    {#  Empty cart  #}
                    <div class="alert alert-info">
                        {% if error %}
                            {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}
                            <a href="{{ store.products_url }}" class="btn btn-link p-none">{{ "ver otros acá" | translate }}</a>
                        {% else %}
                            {{ "El carrito de compras está vacío." | translate }}
                        {% endif %}
                        {{ ("Ver más productos" | translate ~ " »") | a_tag(store.products_url) }}
                    </div>
                {% endif %}
                <div id="error-ajax-stock" style="display: none;">
                    <div class="alert alert-warning">
                        {{ "¡Uy! No tenemos más stock de este producto para agregar este producto al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link">{{ "ver otros acá" | translate }}</a>
                    </div>
                </div>
            </div>
            {% if cart.items %}
                <div class="col-md-4 cart-page-totals p-4 shadow-soft">
                    {% if settings.cart_banner_show %}
                        <div class="d-none d-md-block">
                            {% include "snipplets/cart-banner.tpl" %}
                        </div>
                    {% endif %}
                    {% include "snipplets/cart-totals.tpl" with {'cart_page': true} %}
                </div>
            {% endif %}
        </div>
    </form>
    <div id="store-curr" class="hidden">{{ cart.currency }}</div>
</div>

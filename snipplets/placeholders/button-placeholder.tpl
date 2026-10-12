<div class="js-addtocart-placeholder{% if not product_form %}-btn{% endif %} btn-add-to-cart {% if settings.add_button_invert %}add-button-invert{% endif %} {% if not direct_add and not item_quantity %}btn btn-primary btn-block{% endif %} btn-transition {{ custom_class }} disabled" style="display: none;">
    <div class="{{ item_quantity ? 'd-inline-block' : 'd-block position-relative' }}">
        {% if not quickshop_button %}
            {% if not add_button_text %}
                {% set add_button_text = settings.add_button_text ? settings.add_button_text : 'Agregar al carrito' | translate %}
            {% endif %}
            <span class="js-addtocart-text" style="display: none">
                <span>{{ add_button_text }}</span>
            </span>
        {% endif %}
        <span class="js-addtocart-success transition-container">
            {% if quickshop_button or item_quantity %}
                <svg class="icon-inline font-body icon-lg"><use xlink:href="#check"/></svg>
            {% else %}
                {{ '¡Listo!' | translate }}
                <svg class="icon-inline font-body"><use xlink:href="#check"/></svg>
            {% endif %}
        </span>
        <div class="js-addtocart-adding transition-container transition-icon">
            {% if quickshop_button or item_quantity %}
                <svg class="icon-inline icon-spin icon-lg"><use xlink:href="#spinner-third"/></svg>
            {% else %}
                <span class="js-addtocart-adding-text">{{ 'Agregando...' | translate }}</span>
                <svg class="icon-inline icon-spin icon-w-2em ml-1"><use xlink:href="#spinner-third"/></svg>
            {% endif %}
        </div>
    </div>
</div>

{% set hide_compare_price_subtotal = not item.compare_at_price_subtotal or item.is_subscription_item %}
{% set discount_percentage = item.discount_percentage %}
{% set is_gift = item.is_gift %}

{{ component('nubesdk-slot', { type: "before_line_item", pick: item.id }) }}

<div class="js-cart-item {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %} cart-item form-row" data-item-id="{{ item.id }}" data-gift="{{ is_gift ? 'true' : 'false' }}" data-store="cart-item-{{ item.product.id }}" data-component="cart.line-item">

  {# Cart item image #}
  <div class="cart-item-image col-2 p-0 {% if cart_page %}col-md-1{% endif %}">
    <div class="image-wrapper">
      <img class="img-fluid" src="{{ item.featured_image | product_image_url('medium') }}" />
    </div>
  </div>

  <div class="cart-item-detail col pl-3 align-items-center {% if cart_page %}col-md-10{% endif %}">
    <div class="row align-items-center">

      <div class="col-12">
        <div class="row w-100 no-gutters">

          {# Cart item name #}
          <div class="col">

            {% if cart_summary %}
              <div class="cart-item-name" data-component="line-item.name">
                <a href="{{ item.url }}" data-component="name.short-name">
                  {{ item.short_name }}
                </a>
                <small data-component="name.short-variant-name">{{ item.short_variant_name }}</small>
              </div>
            {% else %}
              <div class="cart-item-name text-left mb-2" data-component="line-item.name">
                <a href="{{ item.url }}" data-component="name.short-name">
                  {{ item.short_name }}
                </a>
                <small data-component="name.short-variant-name">{{ item.short_variant_name }}</small>
                {% if item.is_kit and item.kit_components is not empty %}
                  {% set kit_modal_id = 'cart-kit-modal-' ~ item.id %}
                  {% set kit_modal_body %}
                    {{ component('cart-kit-components', {
                      kit_components: item.kit_components,
                      kit_quantity: item.quantity,
                      classes: {
                        list: 'list-unstyled mb-0',
                        item: 'row no-gutters align-items-center py-2',
                        image_wrap: 'col-auto pr-3',
                        image: 'kit-products-item-image',
                        text: 'col font-small',
                        name: 'font-body font-weight-normal mb-0',
                      }
                    }) }}
                  {% endset %}
                  <button type="button" class="js-modal-open btn btn-link p-0 mt-1 font-small d-block" data-toggle="#{{ kit_modal_id }}" data-component="line-item.kit-breakdown-link">
                    {{ "Ver contenido" | translate }}
                  </button>
                  {% embed "snipplets/modal.tpl" with {
                    modal_id: kit_modal_id,
                    modal_class: 'bottom modal-bottom-sheet h-auto modal-body-scrollable-auto',
                    modal_position: 'bottom',
                    modal_transition: 'slide',
                    modal_width: 'centered-md modal-md-width-400px',
                    data_component: 'cart.kit-breakdown'
                  } %}
                    {% block modal_head %}
                      <span data-component="cart.kit-breakdown.kit-name">{{ item.short_name }}</span>
                    {% endblock %}
                    {% block modal_body %}
                      {{ kit_modal_body }}
                    {% endblock %}
                  {% endembed %}
                {% endif %}
                {% if settings.show_custom_fields %}
                  <div class="mt-1">
                  {% for key, value in item.attributes if key[:1] != '_' %}
                    <div class="font-small"><strong>{{key}}</strong>: {{value}}</div>
                  {% endfor %}
                  </div>
                {% endif %}
              </div>
            {% endif %}

            {% if is_gift %}
              <div class="text-accent font-smallest font-weight-bold text-uppercase w-100">
                {{ "Regalo" | translate }}
              </div>
            {% endif %}

            {{ component(
              'cart-labels', {
                group: true,
                subscription_label: true,
                labels_classes: {
                  group: 'mb-3',
                  label: 'text-accent font-smallest font-weight-bold text-uppercase w-100',
                  shipping: 'mb-1',
                  subscription: 'font-smallest opacity-80 mt-1 mb-2',
                },
              })
            }}

          </div>

          {# Cart item delete #}
          {% if not is_gift %}
            <div class="col-auto cart-item-delete text-right">
              <button type="button" class="btn" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="line-item.remove">
                <svg class="icon-inline icon-lg"><use xlink:href="#trash"></use></svg>
              </button>
            </div>
          {% endif %}
        </div>
      </div>
      <div class="col-12">
      
        <div class="row no-gutters align-items-center">
          {# Cart item quantity controls #}
          <div class="cart-item-quantity col-auto" data-component="line-item.subtotal">
            {% set cart_qty_margin = '' %}
            {% if cart_page %}
              {% set cart_qty_margin = 'm-md-auto' %}
            {% endif %}
            {% embed "snipplets/forms/form-input.tpl" with{
              type_number: true, 
              input_value: item.quantity, 
              input_name: 'quantity[' ~ item.id ~ ']', 
              input_data_attr: 'item-id',
              input_data_val: item.id,
              input_group_custom_class: cart_quantity_class ~ ' float-left form-quantity cart-item-quantity small p-0 mb-0 ' ~ cart_qty_margin, 
              input_custom_class: 'js-cart-quantity-input text-center py-1 ' ~  cart_quantity_input_class, 
              input_label: false, input_append_content: true,
              input_disabled: is_gift,
              data_component: 'quantity.value',
              form_control_container_custom_class: 'js-cart-quantity-container col px-0'} %}
                {% block input_prepend_content %}
                <div class="form-row m-0 align-items-center">
                  <span class="js-cart-quantity-btn form-quantity-icon icon-30px font-small" onclick="LS.minusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.minus">
                    <svg class="icon-inline"><use xlink:href="#minus"/></svg>
                  </span>
                {% endblock input_prepend_content %}
                {% block input_append_content %}
                  
                  {# Always place this spinner before the quantity input #}
            
                  <span class="js-cart-input-spinner cart-item-spinner" style="display: none;">
                    <svg class="icon-inline icon-spin svg-icon-text"><use xlink:href="#spinner-third"/></svg>
                  </span>

                  <span class="js-cart-quantity-btn form-quantity-icon icon-30px font-small" onclick="LS.plusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.plus">
                    <svg class="icon-inline"><use xlink:href="#plus"/></svg>
                  </span>
                </div>
                {% endblock input_append_content %}
            {% endembed %}
          </div>

          {% if cart_page %}
            {# Cart item unit price #}
            <span class="col-3 d-none d-md-flex justify-content-center">
              {% if is_gift %}
                <span class="d-flex align-self-center flex-column align-items-center">
                  <span class="price-compare font-small opacity-50">{{ item.compare_at_price | money }}</span>
                  <span>{{ "Gratis" | translate }}</span>
                </span>
              {% else %}
                <span class="js-cart-item-unit-price d-flex align-self-center" data-line-item-id="{{ item.id }}">{{ item.unit_price | money }}</span>
              {% endif %}
            </span>
          {% endif %}

          {# Cart item subtotal #}

          <div class="col {% if cart_page %}col-md-3 d-flex justify-content-end justify-content-md-center pr-md-0{% else %} cart-item-subtotal{% endif %} text-right">
            {% if is_gift %}
              <div class="d-inline-flex flex-column align-items-center {% if cart_page %}align-self-center{% endif %}">
                <span class="price-compare font-small opacity-50">{{ item.compare_at_price_subtotal | money }}</span>
                <span class="font-weight-bold">{{ "Gratis" | translate }}</span>
              </div>
            {% else %}
              <div class="{% if cart_page %}align-self-center text-md-center{% endif %}">
                <div class="js-cart-item-subtotal-compare-price-container mb-1" data-line-item-id="{{ item.id }}"{% if hide_compare_price_subtotal %} style="display: none"{% endif %}>
                  {% if discount_percentage > 0 %}
                    <span class="text-accent font-small font-weight-bold">-{{ discount_percentage }}%</span>
                  {% endif %}
                  <span class="js-cart-item-subtotal-compare-price price-compare font-small opacity-50 mr-0" data-line-item-id="{{ item.id }}" data-component="subtotal_compare_price.value" data-component-value='{{ item.compare_at_price_subtotal | money }}'>{{ item.compare_at_price_subtotal | money }}</span>
                </div>
                <div class="js-cart-item-subtotal font-weight-bold" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value='{{ item.subtotal | money }}'>{{ item.subtotal | money }}</div>
              </div>
            {% endif %}
          </div>

        </div>

      </div>
    </div>

  </div>
</div>

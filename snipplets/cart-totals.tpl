{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
{% set has_free_shipping_bar = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

{% set gift_progress_parameters = {
  progress_bar_icon_svg_id: 'gift',
  check_svg_id: 'check',
  show_check: true,
  progress_bar_classes: {
    container: 'progress-bar',
    title_container: 'progress-bar-title-container',
    title: 'progress-bar-title',
    icon: 'progress-bar-icon icon-inline',
    subtitle: 'progress-bar-subtitle',
    track: 'bar-progress',
    fill: 'bar-progress-active transition-soft',
    check: 'bar-progress-check transition-soft',
    check_icon: 'icon-inline',
  }
} %}

{{ component('gift-promotion-progress', gift_progress_parameters) }}

{% if has_free_shipping_bar %}
  
  {# includes free shipping progress bar: only if store has free shipping with a minimum #}
  
  {% if cart_page %}
    <div class="d-block d-md-none">
  {% endif %}
      {% include "snipplets/shipping/shipping-free-rest.tpl" %}
  {% if cart_page %}
    </div>
  {% endif %}

{% endif %}

{% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}

{% if settings.shipping_calculator_cart_page or settings.cart_coupon %}

  <div class="js-visible-on-cart-filled mb-3" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

    {% if settings.shipping_calculator_cart_page %}

      <div class="js-has-new-shipping js-shipping-calculator-container">

        {# Saved shipping not available #}

        <div class="js-shipping-method-unavailable alert alert-warning form-row" style="display: none;">
          <div>
            <strong>{{ 'El medio de envío que habías elegido ya no se encuentra disponible ' | translate }}</strong>{{ 'porque el total de los items del carrito superan el peso máximo.' | translate }}
          </div>
          <div>
            {{ '¡No te preocupes! Podés elegir otro medio de envío.' | translate}}
          </div>
        </div>

        {# Shipping calculator and branch link #}

        <div id="cart-shipping-container" class="cart-panel-shipping-calculator" {% if cart.items_count == 0 %} style="display: none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

          {# Used to save shipping #}

          <span id="cart-selected-shipping-method" data-code="{{ cart.shipping_data.code }}" class="hidden">{{ cart.shipping_data.name }}</span>

          {# Shipping Calculator #}

          {% if store.has_shipping %}
            <div class="cart-shipping">
              {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_show': settings.shipping_calculator_cart_page, 'product_detail': false} %}
            </div>
          {% endif %}

          {# Store branches #}

          {% if store.branches %}

            {# Link for branches #}

            {% include "snipplets/shipping/branches.tpl" with {'product_detail': false} %}
          {% endif %}
        </div>
      </div>

    {% endif %}

    {# Coupon input #}

    {% if settings.cart_coupon %}
      {{ component('coupon-input', {
        label_svg_id: 'tag',
        toggle_inactive_svg_id: 'plus',
        toggle_active_svg_id: 'minus',
        spinner_svg_id: 'spinner-third',
        container_classes: {
          container: 'cart-coupon mb-2',
          toggle: 'row no-gutters align-items-center p-3',
          toggle_label: 'col h6 text-uppercase mb-0',
          label_icon: 'icon-inline icon-lg svg-icon-text mr-1',
          toggle_inactive: 'col-auto',
          toggle_active: 'col-auto',
          toggle_icon: 'icon-inline svg-icon-text',
          actions: 'px-3 pb-3',
          applied_row: 'd-flex align-items-center justify-content-between',
          applied_code: 'mr-4 font-body',
          remove_button: 'btn-link font-small coupon-action-btn',
          form: 'mb-0',
          input_wrapper: 'd-flex',
          input: 'form-control flex-fill',
          apply_button: 'btn btn-default flex-shrink-0 ml-2',
          spinner_icon: 'icon-inline icon-spin',
          spinner: 'ml-2',
          error: 'coupon-error alert alert-danger mb-0 mt-3',
        }
      }) }}
    {% endif %}

  </div>
{% endif %}

{# Cart totals: subtotal, promos, coupon discount, shipping cost, total, payment/installments #}

{{ component('cart-totals', {
  shipping_enabled: show_calculator_on_cart,
  shipping_discount_row_enabled: true,
  payment_discount_price_enabled: settings.payment_discount_price,
  installments_enabled: not settings.payment_discount_price,
  totals_divider: not cart_page,
  container_classes: {
    discounts_container: 'pt-1',
    totals_divider: 'divider',
  },
  text_classes: {
    subtotal: 'row font-weight-normal mb-2' ~ (cart_page ? ' no-gutters h5 font-big'),
    subtotal_label: cart_page ? 'col pl-md-0' : 'col',
    subtotal_price: 'col-auto text-right font-weight-bold' ~ (cart_page ? ' pr-md-0'),
    price_without_taxes: 'row opacity-50 mb-2',
    price_without_taxes_label: 'col-auto',
    price_without_taxes_price: 'col text-right',
    promotions: 'text-accent mb-2',
    discounts_row: 'row no-gutters mb-2',
    discounts_label: 'col pr-3 text-accent',
    discounts_price: 'col-auto text-right text-accent' ~ (cart_page ? ' pr-md-0'),
    shipping_costs: 'mb-3 row' ~ (cart_page ? ' no-gutters'),
    shipping_costs_label: 'col',
    shipping_costs_price: 'col-auto text-right opacity-40',
    shipping_costs_calculating: 'col-auto text-right opacity-40',
    shipping_costs_empty: 'col-auto text-right opacity-40',
    shipping_discount_row: 'row no-gutters mb-2 text-accent',
    shipping_discount_label: 'col pr-3',
    shipping_discount_price: 'col-auto text-right' ~ (cart_page ? ' pr-md-0'),
    total: 'row h4 font-large' ~ (cart_page ? ' no-gutters mb-3'),
    total_label: 'col' ~ (cart_page ? ' pl-md-0'),
    total_price: 'col-auto text-right' ~ (cart_page ? ' pr-md-0'),
    payment_discount_and_installments: 'mb-3',
    payment_discount_price: 'text-accent font-small font-weight-normal mt-1 text-right',
    installments: 'font-small font-weight-normal mt-1 text-right',
  },
}) }}

  <div class="js-visible-on-cart-filled" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

    {# No stock alert #}
    <div id="error-ajax-stock" class='alert alert-warning' role='alert' style="display:none;">
      {{ "¡Uy! No tenemos más stock de este producto para agregar este producto al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link">{{ "ver otros acá" | translate }}</a>
    </div>

    {# Cart panel CTA #}
    
    {% set has_validation_messages = cart.checkout_enabled_validation_messages | length > 0 %}
    {% set should_show_checkout_button = cart.checkout_enabled and not has_validation_messages %}

    {{ component('nubesdk-slot', { type: "before_go_to_checkout" }) }}

    <div class="row">
        <div class="js-ajax-cart-submit col-12 mb-2" {{ not should_show_checkout_button ? 'style="display:none"' }} id="ajax-cart-submit-div">
          <input class="btn btn-primary d-block w-100" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}" data-component="cart.checkout-button"/>
        </div>

        {# Cart panel continue buying link #}
        
        {% if settings.continue_buying %}
          <div class="col-12">
              <a href="{% if template == 'category' or (settings.cart_continue_action == "modal" and not cart_page) %}#{% else %}{{ store.products_url }}{% endif %}" class="d-block {% if template == 'category' or (settings.cart_continue_action == "modal" and not cart_page) %}js-modal-close js-fullscreen-modal-close {% endif %}btn btn-medium btn-opacity-05 btn-bold">{{ 'Ver más productos' | translate }}</a>
          </div>        
        {% endif %}
    </div>

    {{ component('nubesdk-slot', { type: "after_go_to_checkout" }) }}

    {# Cart alert messages #}

    {{ component(
      'checkout-enabled-validation-messages', {
        alert_classes: 'alert alert-warning mb-2 mt-4',
        cart_minimum_value: settings.cart_minimum_value
      })
    }}

</div>
